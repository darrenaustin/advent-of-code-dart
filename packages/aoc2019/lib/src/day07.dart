// https://adventofcode.com/2019/day/7

import 'package:aoc/aoc.dart';
import 'package:aoc/util/collection.dart';
import 'package:aoc/util/combinatorics.dart';
import 'package:collection/collection.dart';

import 'intcode.dart';

main() => Day07().solve();

class Day07 extends AdventDay {
  Day07() : super(
    2019, 7, name: 'Amplification Circuit',
    solution1: 24405, solution2: 8271623,
  );

  @override
  dynamic part1(String input) {
    int runAmps(Iterable<int> phases, [initialInput = 0]) {
      int inputSignal = initialInput;
      for (final phase in phases) {
        final machine = Intcode.from(program: input, input: [phase, inputSignal]);
        while (!machine.execute()) {}
        inputSignal = machine.output.last;
      }
      return inputSignal;
    }

    return permutations(range(5).toSet()).map(runAmps).max;
  }

  @override
  dynamic part2(String input) {
    int runAmps(Iterable<int> phases, [initialInput = 0]) {
      final inputs = phases.map((p) => [p]).toList();
      final machines = <Intcode>[];
      for (int i = 0; i < phases.length; i++) {
        machines.add(Intcode.from(
            program: input,
            input: inputs[i],
            output: inputs[(i + 1) % phases.length]
        ));
      }
      inputs[0].add(initialInput);
      while (!machines.every((m) => m.complete)) {
        for (final m in machines) {
          m.execute();
        }
      }
      return machines.last.output.last;
    }

    return permutations(range(5, 10).toSet()).map(runAmps).max;
  }
}