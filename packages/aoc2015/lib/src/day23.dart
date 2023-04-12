// https://adventofcode.com/2015/day/23

import 'package:aoc/aoc.dart';
import 'package:aoc/util/string.dart';

main() => Day23().solve();

class Day23 extends AdventDay {
  Day23() : super(2015, 23, name: 'Opening the Turing Lock');

  @override
  dynamic part1(String input) {
    final machine = Machine(instructions(input))..execute();
    return machine.registers[Register.b];
  }

  @override
  dynamic part2(String input) {
    final machine = Machine(instructions(input))
     ..registers[Register.a] = 1
     ..execute();
    return machine.registers[Register.b];
  }

  static List<Instruction> instructions(String input) =>
    input
      .lines
      .map(Instruction.parse)
      .toList();
}

enum Register { a, b }

enum OpCode { hlf, tpl, inc, jmp, jie, jio }

class Instruction {
  Instruction(this.op, {this.register, this.offset});

  factory Instruction.parse(String s) {
    Register registerFor(String r) => r == 'a' ? Register.a : Register.b;

    RegExpMatch? match = RegExp(r'hlf (a|b)').firstMatch(s);
    if (match != null) {
      return Instruction(OpCode.hlf, 
        register: match.group(1)! == 'a' ? Register.a : Register.b);
    }
    match = RegExp(r'tpl (a|b)').firstMatch(s);
    if (match != null) {
      return Instruction(OpCode.tpl, register: registerFor(match.group(1)!));
    }
    match = RegExp(r'inc (a|b)').firstMatch(s);
    if (match != null) {
      return Instruction(OpCode.inc, register: registerFor(match.group(1)!));
    }
    match = RegExp(r'jmp ((\+|-)\d+)').firstMatch(s);
    if (match != null) {
      return Instruction(OpCode.jmp, offset: int.parse(match.group(1)!));
    }
    match = RegExp(r'jie (a|b), ((\+|-)\d+)').firstMatch(s);
    if (match != null) {
      return Instruction(OpCode.jie,
        register: registerFor(match.group(1)!),
        offset: int.parse(match.group(2)!));
    }
    match = RegExp(r'jio (a|b), ((\+|-)\d+)').firstMatch(s);
    if (match != null) {
      return Instruction(OpCode.jio,
        register: registerFor(match.group(1)!),
        offset: int.parse(match.group(2)!));
    }
    throw Exception('Illegal instruction: $s');
  }

  final OpCode op;
  final Register? register;
  final int? offset;
}

class Machine {
  Machine(this.program) :
    registers = Map.fromEntries(Register.values.map((r) => MapEntry(r, 0)));

  final List<Instruction> program;
  final Map<Register, int> registers;

  void execute() {
    int pc = 0;
    while (0 <= pc && pc < program.length) {
      final instruction = program[pc];
      switch (instruction.op) {
        case OpCode.hlf:
          registers[instruction.register!] = registers[instruction.register!]! ~/ 2;
          pc++;
          break;
        case OpCode.tpl:
          registers[instruction.register!] = registers[instruction.register!]! * 3;
          pc++;
          break;
        case OpCode.inc:
          registers[instruction.register!] = registers[instruction.register!]! + 1;
          pc++;
          break;
        case OpCode.jmp:
          pc += instruction.offset!;
          break;
        case OpCode.jie:
          if (registers[instruction.register!]!.isEven) {
            pc += instruction.offset!;
          } else {
            pc++;
          }
          break;
        case OpCode.jio:
          if (registers[instruction.register!]! == 1) {
            pc += instruction.offset!;
          } else {
            pc++;
          }
          break;
      }
    }
  }
}
