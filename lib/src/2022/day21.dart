// https://adventofcode.com/2022/day/21

import 'package:aoc/aoc.dart';

class Day21 extends AdventDay {
  Day21() : super(2022, 21, solution1: 78342931359552, solution2: 3296135418820);

  @override
  dynamic part1() => eval('root', inputExpressions(), <String, int>{});

  @override
  dynamic part2() {
    final expressions = inputExpressions();
    final values = <String, dynamic>{};

    final rootExpr = expressions.remove('root')!;
    expressions['humn'] = ['?'];

    // Calculate the value that will make the variable equal the goal.
    int valueFor(String variable, int goal)  {
      final expr = expressions[variable]!;
      if (expr.length == 1) {
        if (expr.first == '?') {
          return goal;
        }
        throw('Can not change a constant value');
      } else {
        assert(expr.length == 3);
        final op1 = eval(expr[0], expressions, values);
        final op2 = eval(expr[2], expressions, values);
        if (op1 != null && op2 == null) {
          switch (expr[1]) {
            case '+': return valueFor(expr[2], goal - op1);
            case '-': return valueFor(expr[2], op1 - goal);
            case '*': return valueFor(expr[2], goal ~/ op1);
            case '/': return valueFor(expr[2], op1 ~/ goal);
          }
        } else if (op1 == null && op2 != null) {
          switch (expr[1]) {
            case '+': return valueFor(expr[0], goal - op2);
            case '-': return valueFor(expr[0], goal + op2);
            case '*': return valueFor(expr[0], goal ~/ op2);
            case '/': return valueFor(expr[0], goal * op2);
          }
        }
      }
      throw('No solution');
    }

    final rootOp1 = eval(rootExpr[0], expressions, values);
    final rootOp2 = eval(rootExpr[2], expressions, values);

    if (rootOp1 != null) {
      return valueFor(rootExpr[2], rootOp1);
    } if (rootOp2 != null) {
      return valueFor(rootExpr[0], rootOp2);
    }
    throw('No solution');
  }

  int? eval(String variable,
      Map<String, List<String>> expressions, Map<String, dynamic> values) {
    if (values.containsKey(variable)) {
      return values[variable]!;
    }
    final expr = expressions[variable]!;
    late final int? result;
    if (expr.length == 1) {
      result = int.tryParse(expr.first);
    } else {
      assert(expr.length == 3);
      final op1 = eval(expr[0], expressions, values);
      final op2 = eval(expr[2], expressions, values);
      if (op1 != null && op2 != null) {
        switch (expr[1]) {
          case '+': result = op1 + op2; break;
          case '-': result = op1 - op2; break;
          case '*': result = op1 * op2; break;
          case '/': result = op1 ~/ op2; break;
        }
      } else {
        result = null;
      }
    }
    if (result != null) {
      values[variable] = result;
    }
    return result;
  }

  Map<String, List<String>> inputExpressions() =>
    Map.fromEntries(inputDataLines().map((line) {
      final parts = line.split(': ');
      return MapEntry(parts.first, parts.last.split(' '));
    }));
}
