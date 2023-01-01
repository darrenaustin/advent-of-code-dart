// https://adventofcode.com/2015/day/7

import 'package:aoc/aoc.dart';
import 'package:aoc/util/string.dart';

main() => Day07().solve();

class Day07 extends AdventDay {
  Day07() : super(
    2015, 7, name: 'Some Assembly Required',
    solution1: 46065, solution2: 14134,
  );

  @override
  dynamic part1(String input) => signal('a', circuit(input));

  @override
  dynamic part2(String input) {
    Circuit c = circuit(input);
    c['b'] = Gate(GateOp.assign, 'b',  signal('a', c).toString());
    return signal('a', c);
  }

  static Circuit circuit(String input) {
    final Map<String, GateOp> opMap = <String, GateOp>{
      'AND': GateOp.and,
      'OR': GateOp.or,
      'LSHIFT': GateOp.lshift,
      'RSHIFT': GateOp.rshift,
    };

    final gates = input.lines.map((line) {
      final List<String> parts = line.trim().split(' -> ');
      final String output = parts[1];
      final List<String> gateParts = parts[0].split(' ').toList();
      if (gateParts.length == 1) {
        return Gate(GateOp.assign, output, gateParts[0]);
      }
      if (gateParts.length == 2) {
        return Gate(GateOp.not, output, gateParts[1]);
      }
      // Binary gate
      return Gate(opMap[gateParts[1]]!, output, gateParts[0], gateParts[2]);
    });

    return Circuit.fromEntries(gates.map((g) => MapEntry<String, Gate>(g.output, g)));
  }

  static int signal(String wire, Circuit circuit) {
    final Map<String, int> wires = <String, int>{};
    late final Map<GateOp, GateFn> ops;

    int eval(String wire) {
      final int? constant = int.tryParse(wire);
      if (constant != null) {
        return constant;
      }
      if (!wires.containsKey(wire)) {
        final Gate gate = circuit[wire]!;
        final GateFn op = ops[gate.op]!;
        final int value = op(gate) & 0xffff;
        wires[wire] = value;
      }
      return wires[wire]!;
    }

    ops = <GateOp, GateFn>{
      GateOp.assign: (Gate c) => eval(c.input1!),
      GateOp.and: (Gate c) => eval(c.input1!) & eval(c.input2!),
      GateOp.or: (Gate c) => eval(c.input1!) | eval(c.input2!),
      GateOp.not: (Gate c) => ~eval(c.input1!),
      GateOp.lshift: (Gate c) => eval(c.input1!) << int.parse(c.input2!),
      GateOp.rshift: (Gate c) => eval(c.input1!) >> int.parse(c.input2!),
    };

    return eval(wire);
  }
}

enum GateOp { assign, and, or, not, lshift, rshift }

typedef GateFn = int Function(Gate c);

class Gate {
  Gate(this.op, this.output, [this.input1, this.input2]);

  final GateOp op;
  final String output;
  final String? input1;
  final String? input2;
}

typedef Circuit = Map<String, Gate>;