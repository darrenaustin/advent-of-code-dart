// Intcode virtual machine

class Intcode {

  Intcode({
    required List<int> memory,
    List<int>? input,
    List<int>? output,
  }) : _memory = List.from(memory),
       input = input ?? <int>[],
       output = output ?? <int>[];

  Intcode.from({
    required String program,
    List<int>? input,
    List<int>? output,
  }) : this(
    memory: parseProgram(program),
    input: input,
    output: output
  );

  final List<int?> _memory;

  final List<int> input;
  final List<int> output;

  bool _complete = false;
  bool get complete => _complete;

  int _pc = 0;
  int _relativeBase = 0;

  int operator [](int address) {
    _ensureAddress(address);
    return _memory[address] ?? 0;
  }

  void operator []=(int address, int value) {
    _ensureAddress(address);
    _memory[address] = value;
  }

  void _ensureAddress(int address) {
    if (address >= _memory.length) {
      _memory.length = address + 1;
    }
  }

  bool execute([int? startAddress]) {
    _pc = startAddress ?? _pc;
    var running = true;
    while (running) {
      final opCode = _opCode(_pc);
      switch (opCode) {
        case 99:
          // Halt
          _complete = true;
          running = false;
          break;

        case 1:
          // param1 + param2 -> param3
          final modes = _parameterModes(_pc);
          final param1 = _parameter(_pc, 1, modes);
          final param2 = _parameter(_pc, 2, modes);
          this[_paramAddress(_pc, 3, modes)] = param1 + param2;
          _pc += 4;
          break;

        case 2:
          // param1 * param2 -> param3
          final modes = _parameterModes(_pc);
          final param1 = _parameter(_pc, 1, modes);
          final param2 = _parameter(_pc, 2, modes);
          this[_paramAddress(_pc, 3, modes)] = param1 * param2;
          _pc += 4;
          break;

        case 3:
          // input -> param1
          final modes = _parameterModes(_pc);
          if (input.isEmpty) {
            // No input ready so stop and wait for some to arrive
            running = false;
            break;
          }
          this[_paramAddress(_pc, 1, modes)] = input.removeAt(0);
          _pc += 2;
          break;

        case 4:
          // param1 -> output
          final modes = _parameterModes(_pc);
          final param1 = _parameter(_pc, 1, modes);
          output.add(param1);
          _pc += 2;
          break;

        case 5:
          // jump-if-true
          final modes = _parameterModes(_pc);
          if (_parameter(_pc, 1, modes) != 0) {
            _pc = _parameter(_pc, 2, modes);
          } else {
            _pc += 3;
          }
          break;

        case 6:
          // jump-if-false
          final modes = _parameterModes(_pc);
          if (_parameter(_pc, 1, modes) == 0) {
            _pc = _parameter(_pc, 2, modes);
          } else {
            _pc += 3;
          }
          break;

        case 7:
          // param1 < param2 -> set param3 to 1
          final modes = _parameterModes(_pc);
          final param1 = _parameter(_pc, 1, modes);
          final param2 = _parameter(_pc, 2, modes);
          this[_paramAddress(_pc, 3, modes)] = param1 < param2 ? 1 : 0;
          _pc += 4;
          break;

        case 8:
          // param1 == param2 -> set param3 to 1
          final modes = _parameterModes(_pc);
          final param1 = _parameter(_pc, 1, modes);
          final param2 = _parameter(_pc, 2, modes);
          this[_paramAddress(_pc, 3, modes)] = param1 == param2 ? 1 : 0;
          _pc += 4;
          break;

        case 9:
          // adjust relative base by param
          final modes = _parameterModes(_pc);
          final param1 = _parameter(_pc, 1, modes);
          _relativeBase += param1;
          _pc += 2;
          break;

        default:
          throw Exception('Unknown op code $opCode');
      }
    }

    return complete;
  }

  int _opCode(int address) {
    final instruction = this[address];
    return instruction - ((instruction ~/ 100) * 100);
  }

  List<int> _parameterModes(int address) {
    final instruction = this[address];
    return (instruction ~/ 100).toString().padLeft(3, '0').split('').reversed.map(int.parse).toList();
  }

  int _parameter(int opAddress, int paramIndex, List<int> modes) {
    final param = this[opAddress + paramIndex];
    switch (modes[paramIndex - 1]) {
      // Position mode
      case 0: return this[param];
      // Immediate mode
      case 1: return param;
      // Relative mode
      case 2: return this[param + _relativeBase];

      default:
        throw Exception('Unknown parameter mode ${modes[paramIndex -1]}');
    }
  }

  int _paramAddress(int opAddress, int paramIndex, List<int> modes) {
    final param = this[opAddress + paramIndex];
    switch (modes[paramIndex - 1]) {
      // Position mode
      case 0: return param;
      // Immediate mode
      case 1: throw Exception('Trying to get an immediate mode address');
      // Relative mode
      case 2: return param + _relativeBase;

      default:
        throw Exception('Unknown parameter mode ${modes[paramIndex -1]}');
    }
  }

  static List<int> parseProgram(String program) =>
    program.split(',').map(int.parse).toList();

  static String disassemble(List<int> program, [int? startAddress]) {
    final buffer = StringBuffer();

    int pc = startAddress ?? 0;

    void instruction(String opCode, [int numParams = 0]) {
      final address = pc.toString().padLeft(4);
      if (numParams > 0) {
        final params = <String>[];
        final modes = (program[pc] ~/ 100).toString().padLeft(3, '0').split('').reversed.map(int.parse).toList();
        for (int p = 0; p < numParams; p++) {
          final paramAddress = (pc + p + 1).toString();
          switch (modes[p]) {
            case 0: params.add(paramAddress); break;
            case 1: params.add('#$paramAddress'); break;
            case 2: params.add('@$paramAddress'); break;
          }
        }
        buffer.writeln('$address: $opCode ${params.join(', ')}');
        for (int p = 0; p < numParams; p++) {
          final paramAddress = (pc + p + 1).toString().padLeft(4);
          buffer.writeln('$paramAddress:   [${program[pc + p + 1]}]');
        }
      } else {
        buffer.writeln('$address: $opCode');
      }
      pc += numParams + 1;
    }

    while (pc < program.length) {
      final instr = program[pc];
      final opCode = instr - ((instr ~/ 100) * 100);
      switch (opCode) {
        case 99: instruction('HALT'); break;
        case 1: instruction('ADD', 3); break;
        case 2: instruction('MUL', 3); break;
        case 3: instruction('IN', 1); break;
        case 4: instruction('OUT', 1); break;
        case 5: instruction('JZ', 2); break;
        case 6: instruction('JNZ', 2); break;
        case 7: instruction('SLT', 3); break;
        case 8: instruction('SEQ', 3); break;
        case 9: instruction('INCB', 1); break;
        default: instruction('DATA [$instr]', 0); break;
      }
    }
    return buffer.toString();
  }
}
