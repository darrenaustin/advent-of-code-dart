class Assembunny {
  Assembunny(List<String> instructions)
      : instructions = instructions.map(Instruction.parse).toList();

  final List<Instruction> instructions;
  final Map<String, int> registers = {'a': 0, 'b': 0, 'c': 0, 'd': 0};
  int pc = 0;

  void execute() {
    while (pc < instructions.length) {
      _performPeepholeOpt();
      final instruction = instructions[pc];
      // print('[$pc]: $instruction');
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
        case OpCode.tgl:
          final addr = pc + value(instruction.op1);
          if (addr < instructions.length) {
            final targetInstruction = instructions[addr];
            final Instruction toggledInstruction;
            switch (targetInstruction.opCode) {
              case OpCode.cpy:
                toggledInstruction = Instruction(
                    OpCode.jnz, targetInstruction.op1, targetInstruction.op2);
                break;
              case OpCode.inc:
                toggledInstruction =
                    Instruction(OpCode.dec, targetInstruction.op1);
                break;
              case OpCode.dec:
                toggledInstruction =
                    Instruction(OpCode.inc, targetInstruction.op1);
                break;
              case OpCode.jnz:
                toggledInstruction = Instruction(
                    OpCode.cpy, targetInstruction.op1, targetInstruction.op2);
                break;
              case OpCode.tgl:
                toggledInstruction =
                    Instruction(OpCode.inc, targetInstruction.op1);
                break;
            }
            instructions[addr] = toggledInstruction;
          }
          pc += 1;
          break;
      }
    }
  }

  void _performPeepholeOpt() {
    _performMultLoopOpt();
  }

  void _performMultLoopOpt() {
    // Look for something like:
    //
    // cpy <value> d
    // inc a
    // dec d
    // jnz d -2
    // dec c
    // jnz c -5
    //
    // Which will be a loop resulting in:
    // a += <value> * c, and d, c = 0.
    const finalJmpOffset = Operand.constant(-5);
    const innerJmpOffset = Operand.constant(-2);

    if (pc + 5 >= instructions.length) {
      return;
    }
    final finalJmp = instructions[pc + 5];
    if (finalJmp.opCode != OpCode.jnz || finalJmp.op2 != finalJmpOffset) {
      return;
    }
    final multOp2 = finalJmp.op1;
    if (instructions[pc + 4] != Instruction(OpCode.dec, multOp2)) {
      return;
    }
    final innerJmp = instructions[pc + 3];
    if (innerJmp.opCode != OpCode.jnz || innerJmp.op2 != innerJmpOffset) {
      return;
    }
    final multOp1 = innerJmp.op1;
    if (instructions[pc + 2] != Instruction(OpCode.dec, multOp1)) {
      return;
    }
    final innerInc = instructions[pc + 1];
    if (innerInc.opCode != OpCode.inc) {
      return;
    }
    final resultOp = innerInc.op1;
    final initialCpy = instructions[pc];
    if (initialCpy.opCode != OpCode.cpy || initialCpy.op2 != multOp1) {
      return;
    }
    // Found it, so perform multiplication, adjust registers and advance pc
    final result = value(initialCpy.op1) * value(multOp2);
    registers[resultOp.register] = registers[resultOp.register]! + result;
    registers[multOp1.register] = 0;
    registers[multOp2.register] = 0;
    pc += 5;
  }

  int value(Operand op) {
    switch (op.type) {
      case OperandType.constant:
        return op.constant;
      case OperandType.register:
        return registers[op.register]!;
    }
  }
}

enum OperandType { constant, register }

class Operand {
  const Operand.constant(this.constant)
      : type = OperandType.constant,
        register = '';

  const Operand.register(this.register)
      : type = OperandType.register,
        constant = 0;

  final OperandType type;
  final int constant;
  final String register;

  static Operand parse(String input) {
    final int? number = int.tryParse(input);
    return number != null ? Operand.constant(number) : Operand.register(input);
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is Operand &&
        other.type == type &&
        other.constant == constant &&
        other.register == register;
  }

  @override
  int get hashCode => type.hashCode ^ constant.hashCode ^ register.hashCode;

  @override
  String toString() =>
      type == OperandType.constant ? constant.toString() : register;
}

enum OpCode { cpy, inc, dec, jnz, tgl }

class Instruction {
  const Instruction(this.opCode, this.op1, [this.op2]);

  final OpCode opCode;
  final Operand op1;
  final Operand? op2;

  static final _opCode = {
    'cpy': OpCode.cpy,
    'inc': OpCode.inc,
    'dec': OpCode.dec,
    'jnz': OpCode.jnz,
    'tgl': OpCode.tgl
  };
  static final _pattern = RegExp(
      '(${_opCode.keys.join('|')})' r' ((-?\d+)|[a-d])( ((-?\d+)|[a-d]))?');

  static Instruction parse(String input) {
    final parts = _pattern.firstMatch(input);
    if (parts != null) {
      final opCode = _opCode[parts[1]];
      if (opCode != null) {
        return Instruction(opCode, Operand.parse(parts[2]!),
            parts[5] != null ? Operand.parse(parts[5]!) : null);
      }
    }
    throw 'Unknown instruction: $input';
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is Instruction &&
        other.opCode == opCode &&
        other.op1 == op1 &&
        other.op2 == op2;
  }

  @override
  int get hashCode => opCode.hashCode ^ op1.hashCode ^ (op2?.hashCode ?? 0);

  @override
  String toString() =>
      '${opCode.name} ${op1.toString()} ${op2?.toString() ?? ''}';
}
