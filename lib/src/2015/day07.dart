// https://adventofcode.com/2015/day/7

import 'package:aoc/aoc.dart';

class Day07 extends AdventDay {
  Day07() : super(2015, 7, solution1: 46065, solution2: 14134);

  @override
  dynamic part1() {
    return signal('a', inputConnections());
  }

  @override
  dynamic part2() {
    return signal('a', inputConnections()
      ..['b'] = Connection(Op.assign, 'b', part1().toString()));
  }

  Map<String, Connection> inputConnections() {
    final Map<String, Op> opMap = <String, Op>{
      'AND': Op.and,
      'OR': Op.or,
      'LSHIFT': Op.lshift,
      'RSHIFT': Op.rshift,
    };
    return Map<String, Connection>.fromEntries(inputDataLines().map((String line) {
      final List<String> parts = line.trim().split(' -> ');
      final String output = parts[1];
      final List<String> connectionParts = parts[0].split(' ').toList();
      if (connectionParts.length == 1) {
        return Connection(Op.assign, output, connectionParts[0]);
      }
      if (connectionParts.length == 2) {
        return Connection(Op.not, output, connectionParts[1]);
      }
      return Connection(opMap[connectionParts[1]]!, output, connectionParts[0], connectionParts[2]);
    }).map((Connection c) => MapEntry<String, Connection>(c.output, c)));
  }

  int signal(String wire, Map<String, Connection> circuit) {
    final Map<String, int> values = <String, int>{};
    late final Map<Op, OpFn> ops;

    int eval(String wire) {
      final int? constant = int.tryParse(wire);
      if (constant != null) {
        return constant;
      }
      if (!values.containsKey(wire)) {
        final Connection connection = circuit[wire]!;
        final int Function(Connection p1) op = ops[connection.op]!;
        final int value = op(connection) & 0xffff;
        values[wire] = value;
      }
      return values[wire]!;
    }

    ops = <Op, OpFn>{
      Op.assign: (Connection c) => eval(c.input1!),
      Op.and: (Connection c) => eval(c.input1!) & eval(c.input2!),
      Op.or: (Connection c) => eval(c.input1!) | eval(c.input2!),
      Op.not: (Connection c) => ~eval(c.input1!),
      Op.lshift: (Connection c) => eval(c.input1!) << int.parse(c.input2!),
      Op.rshift: (Connection c) => eval(c.input1!) >> int.parse(c.input2!),
    };

    return eval(wire);
  }
}

enum Op { assign, and, or, not, lshift, rshift }

class Connection {
  Connection(this.op, this.output, [this.input1, this.input2]);

  final Op op;
  final String? input1;
  final String? input2;
  final String output;

  @override
  String toString() {
    final String? input =
      op == Op.assign
        ? input1
        : op == Op.not
            ? 'NOT $input1'
            : '$input1 ${op.toString().toUpperCase().split('.').last} $input2';
    return '$input -> $output';
  }
}

typedef OpFn = int Function(Connection c);
