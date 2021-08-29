// https://adventofcode.com/2015/day/23

import '../../day.dart';

class Day23 extends AdventDay {
  Day23() : super(2015, 23, solution1: 170, solution2: 247);

  @override
  dynamic part1() {
    final Machine machine = Machine(inputProgram());
    machine.execute();
    return machine.registers[Register.b];
  }

  @override
  dynamic part2() {
    final Machine machine = Machine(inputProgram());
    machine.registers[Register.a] = 1;
    machine.execute();
    return machine.registers[Register.b];
  }

  List<Instruction> inputProgram() {
    return inputDataLines().map((String s) => Instruction.parse(s)).toList();
  }
}

enum Register { a, b }

enum OpCode { hlf, tpl, inc, jmp, jie, jio }

class Instruction {
  Instruction(this.op, {this.register, this.offset});

  factory Instruction.parse(String s) {
    RegExpMatch? parse = RegExp(r'hlf (a|b)').firstMatch(s);
    if (parse != null) {
      return Instruction(OpCode.hlf, register: parse.group(1)! == 'a' ? Register.a : Register.b);
    }
    parse = RegExp(r'tpl (a|b)').firstMatch(s);
    if (parse != null) {
      return Instruction(OpCode.tpl, register: parse.group(1)! == 'a' ? Register.a : Register.b);
    }
    parse = RegExp(r'inc (a|b)').firstMatch(s);
    if (parse != null) {
      return Instruction(OpCode.inc, register: parse.group(1)! == 'a' ? Register.a : Register.b);
    }
    parse = RegExp(r'jmp ((\+|-)\d+)').firstMatch(s);
    if (parse != null) {
      return Instruction(OpCode.jmp, offset: int.parse(parse.group(1)!));
    }
    parse = RegExp(r'jie (a|b), ((\+|-)\d+)').firstMatch(s);
    if (parse != null) {
      return Instruction(OpCode.jie,
          register: parse.group(1)! == 'a' ? Register.a : Register.b,
          offset: int.parse(parse.group(2)!));
    }
    parse = RegExp(r'jio (a|b), ((\+|-)\d+)').firstMatch(s);
    if (parse != null) {
      return Instruction(OpCode.jio,
          register: parse.group(1)! == 'a' ? Register.a : Register.b,
          offset: int.parse(parse.group(2)!));
    }
    throw Exception('Illegal instruction: $s');
  }

  final OpCode op;
  final Register? register;
  final int? offset;

  @override
  String toString() {
    if (register != null && offset != null) {
      return '${enumText(op)} ${enumText(register!)}, ${offset.toString()}';
    }
    if (register != null) {
      return '${enumText(op)} ${enumText(register!)}';
    }
    return '${enumText(op)} ${offset.toString()}';
  }

  String enumText(Object o) => o.toString().split('.').last;
}

class Machine {
  Machine(this.program) :
    registers = Map<Register, int>.fromEntries(Register.values.map((Register r) =>
        MapEntry<Register, int>(r, 0)));

  final List<Instruction> program;

  final Map<Register, int> registers;

  void execute() {
    int pc = 0;
    while (0 <= pc && pc < program.length) {
      final Instruction instruction = program[pc];
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
