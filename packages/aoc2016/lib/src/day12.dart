// https://adventofcode.com/2016/day/12

import 'package:aoc/aoc.dart';
import 'package:aoc/util/string.dart';

main() => Day12().solve();

class Day12 extends AdventDay {
  Day12() : super(
    2016, 12, name: "Leonardo's Monorail",
    solution1: 318083, solution2: 9227737,
  );

  @override
  dynamic part1(String input) {
    final machine = Assembunny(input.lines);
    machine.execute();
    return machine.registers['a'];
  }

  @override
  dynamic part2(String input) {
    final machine = Assembunny(input.lines);
    machine.registers['c'] = 1;
    machine.execute();
    return machine.registers['a'];
  }
}

class Assembunny {
  Assembunny(List<String> instructions)
    : instructions = instructions.map(Instruction.parse).toList();

  final List<Instruction> instructions;
  final Map<String, int> registers = { 'a': 0, 'b': 0, 'c': 0, 'd': 0 };
  int pc = 0;

  void execute() {
    while (pc < instructions.length) {
      final instruction = instructions[pc];
      switch (instruction.opCode) {
        case OpCode.cpy:
          assert(instruction.op2!.type == OperandType.register);
          registers[instruction.op2!.register] = value(instruction.op1);
          pc += 1;
          break;
        case OpCode.inc:
          assert(instruction.op1.type == OperandType.register);
          final r = instruction.op1.register;
          registers[r] = registers[r]! + 1;
          pc += 1;
          break;
        case OpCode.dec:
          assert(instruction.op1.type == OperandType.register);
          final r = instruction.op1.register;
          registers[r] = registers[r]! - 1;
          pc += 1;
          break;
        case OpCode.jnz:
          if (value(instruction.op1) != 0) {
            pc += value(instruction.op2!);
          } else {
            pc += 1;
          }
          break;
      }
    }
  }

  int value(Operand op) {
    switch (op.type) {
      case OperandType.constant: return op.constant;
      case OperandType.register: return registers[op.register]!;
    }
  }
}

enum OperandType { constant, register }
class Operand {
  Operand.constant(this.constant)
    : type = OperandType.constant, register = '';

  Operand.register(this.register)
      : type = OperandType.register, constant = 0;

  final OperandType type;
  final int constant;
  final String register;

  static Operand parse(String input) {
    final int? number = int.tryParse(input);
    return number != null
      ? Operand.constant(number)
      : Operand.register(input);
  }

  @override
  String toString() => type == OperandType.constant ? constant.toString() : register;
}

enum OpCode { cpy, inc, dec, jnz }
class Instruction {
  Instruction(this.opCode, this.op1, [this.op2]);

  final OpCode opCode;
  final Operand op1;
  final Operand? op2;

  static final _pattern = RegExp(r'(cpy|inc|dec|jnz) ((-?\d+)|[a-d])( ((-?\d+)|[a-d]))?');
  static final _opCode = { 'cpy': OpCode.cpy, 'inc': OpCode.inc, 'dec': OpCode.dec, 'jnz': OpCode.jnz };

  static Instruction parse(String input) {
    final parts = _pattern.firstMatch(input);
    if (parts != null) {
      final opCode = _opCode[parts[1]];
      if (opCode != null) {
        return Instruction(opCode,
          Operand.parse(parts[2]!),
          parts[5] != null ? Operand.parse(parts[5]!) : null);
      }
    }
    throw 'Unknown instruction: $input';
  }

  @override
  String toString() {
    return '${opCode.name} ${op1.toString()} ${op2?.toString() ?? ''}';
  }
}
