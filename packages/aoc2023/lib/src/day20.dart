// ignore_for_file: public_member_api_docs, sort_constructors_first
// https://adventofcode.com/2023/day/20

import 'package:aoc/aoc.dart';
import 'package:aoc/util/math.dart';
import 'package:aoc/util/string.dart';

main() => Day20().solve();

class Day20 extends AdventDay {
  Day20() : super(2023, 20, name: '');

  @override
  dynamic part1(String input) {
    final config = Config(input);
    for (int i = 0; i < 1000; i++) {
      config.buttonPress();
    }
    return config.warmUpScore();
  }

  @override
  dynamic part2(String input) => Config(input).rxPresses();
}

enum ModuleType { broadcast, flipFlop, conjunction }

class Module {
  Module(
      {required this.name,
      required this.type,
      required this.outputs,
      required this.conjInputs});

  final String name;
  final ModuleType type;
  final List<String> outputs;
  final Map<String, bool> conjInputs;

  bool state = false;

  static Module parse(String input) {
    final match = RegExp(r'(\%|\&)?(\w+) -> (.*)').firstMatch(input)!;
    final type = switch (match.group(1)) {
      '%' => ModuleType.flipFlop,
      '&' => ModuleType.conjunction,
      _ => ModuleType.broadcast,
    };
    final name = match.group(2)!;
    final outputs = match.group(3)!.split(', ');
    return Module(name: name, type: type, outputs: outputs, conjInputs: {});
  }

  List<Pulse> recievePulse(Pulse pulse) {
    switch (type) {
      case ModuleType.broadcast:
        return outputs.map((o) => Pulse(o, pulse.value, name)).toList();

      case ModuleType.flipFlop:
        if (pulse.low) {
          state = !state;
          return outputs.map((o) => Pulse(o, state, name)).toList();
        }

      case ModuleType.conjunction:
        conjInputs[pulse.sender] = pulse.value;
        state = !conjInputs.values.every((e) => e);
        return outputs.map((o) => Pulse(o, state, name)).toList();
    }
    return [];
  }

  @override
  String toString() =>
      'Module(name: $name, state: $state, type: $type, outputs: $outputs, conjInputs: $conjInputs)';
}

class Pulse {
  Pulse(this.target, this.value, this.sender);

  final String target;
  final bool value;
  bool get high => value;
  bool get low => !value;
  final String sender;

  @override
  String toString() => 'Pulse($sender, -${value ? 'high' : 'low'} -> $target)';
}

class Config {
  Config(String input) {
    modules = Map.fromEntries(
        input.lines.map(Module.parse).map((m) => MapEntry(m.name, m)));

    // Hook up conj inputs, and track broadcast module
    for (final m in modules.values) {
      if (m.type == ModuleType.broadcast) {
        _broadcastName = m.name;
      }
      for (final o in m.outputs) {
        final output = modules[o];
        if (output != null) {
          if (output.type == ModuleType.conjunction) {
            output.conjInputs[m.name] = false;
          }
        }
      }
    }
  }

  late final Map<String, Module> modules;
  late final String _broadcastName;

  int _lowPulses = 0;
  int _highPulses = 0;

  int warmUpScore() => _lowPulses * _highPulses;

  void buttonPress() {
    final open = <Pulse>[Pulse(_broadcastName, false, 'button')];
    while (open.isNotEmpty) {
      final pulse = open.removeAt(0);
      if (pulse.high) {
        _highPulses++;
      } else {
        _lowPulses++;
      }
      final target = modules[pulse.target];
      if (target != null) {
        open.addAll(target.recievePulse(pulse));
      }
    }
  }

  int rxPresses() {
    final rxInputs = modules.values.where((m) => m.outputs.contains('rx'));
    assert(rxInputs.length == 1);
    assert(rxInputs.first.type == ModuleType.conjunction);
    final rxInput = rxInputs.first;

    final previousHigh = <String, int>{};
    final cycleCount = <String, int>{};

    var done = false;
    var buttonPresses = 0;
    while (!done) {
      final open = <Pulse>[Pulse(_broadcastName, false, 'button')];
      buttonPresses++;
      while (open.isNotEmpty) {
        final pulse = open.removeAt(0);
        final target = modules[pulse.target];
        if (target != null) {
          open.addAll(target.recievePulse(pulse));
        }

        // Check for any high pulses to the rxInput module that we don't
        // already have a cycle count for.
        if (pulse.target == rxInput.name &&
            pulse.high &&
            !cycleCount.containsKey(pulse.sender)) {
          if (previousHigh.containsKey(pulse.sender)) {
            // We have seen a high from this sender before, so record
            // the cycle count.
            cycleCount[pulse.sender] =
                buttonPresses - previousHigh[pulse.sender]!;

            // If we have cycle counts for all them, we are done.
            done = cycleCount.length == rxInput.conjInputs.length;
          } else {
            // Record the first high pulse for this sender.
            previousHigh[pulse.sender] = buttonPresses;
          }
        }
      }
    }
    return cycleCount.values.reduce(lcm);
  }

  @override
  String toString() {
    final buffer = StringBuffer('Module config: [\n');
    for (final m in modules.values) {
      buffer.writeln('  $m');
    }
    buffer.writeln(']');
    return buffer.toString();
  }
}
