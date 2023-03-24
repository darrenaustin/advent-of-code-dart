// https://adventofcode.com/2020/day/8

import 'package:aoc/aoc.dart';
import 'package:aoc/util/string.dart';

main() => Day08().solve();

class Day08 extends AdventDay {
  Day08() : super(
    2020, 8, name: 'Handheld Halting',
    solution1: 2025, solution2: 2001,
  );

  @override
  dynamic part1(String input) {
    final machine = Machine(parseProgram(input));
    runUntilCycleDetected(machine);
    return machine.accumulator;
  }

  @override
  dynamic part2(String input) {
    bool canPatch(Instruction instruction) =>
      instruction.operation == OpCode.nop || instruction.operation == OpCode.jmp;

    Instruction patch(Instruction instruction) =>
      Instruction(instruction.operation == OpCode.nop
          ? OpCode.jmp
          : OpCode.nop,
        instruction.argument
      );

    final program = parseProgram(input);
    int? patchAddress;
    while (true) {
      final machine = Machine(program);
      if (runUntilCycleDetected(machine)) {
        return machine.accumulator;
      }

      // Hit an infinite loop, so find a place to patch a nop or jmp
      if (patchAddress == null) {
        // Find first instruction to patch
        patchAddress = program.indexWhere(canPatch);
      } else {
        // Undo any previous patch and find the next one
        program[patchAddress] = patch(program[patchAddress]);
        patchAddress = program.indexWhere(canPatch, patchAddress + 1);
      }
      if (patchAddress != -1) {
        // Patch tne next viable instruction
        program[patchAddress] = patch(program[patchAddress]);
      } else {
        throw Exception('No patch found that works for this program.');
      }
    }
  }

  List<Instruction> parseProgram(String input) =>
    input
      .lines
      .map(Instruction.parse)
      .toList();

  bool runUntilCycleDetected(Machine machine) {
    final executedAddressess = <int>{};
    bool completed = false;
    while (!completed && !executedAddressess.contains(machine.programCounter)) {
      executedAddressess.add(machine.programCounter);
      completed = machine.execute();
    }
    return completed;
  }
}

enum OpCode {
  acc('acc'), jmp('jmp'), nop('nop');

  const OpCode(this.name);
  final String name;

  @override
  String toString() => name;

  static OpCode parse(String text) {
    final match = values.where((o) => o.name == text);
    if (match.isNotEmpty) {
      return match.first;
    }
    throw Exception('Unknown operation: $text');
  }
}

class Instruction {
  Instruction(this.operation, this.argument);

  final OpCode operation;
  final int argument;

  static Instruction parse(String text) {
      final opCode = OpCode.parse(text.substring(0, 3));
      final argument = int.parse(text.substring(4));
      return Instruction(opCode, argument);
  }

  @override
  String toString() => '$operation $argument';
}

class Machine {

  Machine(this.program);

  final List<Instruction> program;
  int accumulator = 0;
  int programCounter = 0;

  bool execute() {
    if (programCounter == program.length) {
      return true;
    }
    final instruction = program[programCounter];
    switch (instruction.operation) {
      case OpCode.acc:
        accumulator += instruction.argument;
        programCounter++;
        break;
      case OpCode.jmp:
        programCounter += instruction.argument;
        break;
      case OpCode.nop:
        programCounter++;
        break;
    }
    return false;
  }
}
