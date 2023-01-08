// https://adventofcode.com/2019/day/4

import 'package:aoc/aoc.dart';
import 'package:aoc/util/collection.dart';
import 'package:aoc/util/comparison.dart';

main() => Day04().solve();

class Day04 extends AdventDay {
  Day04() : super(
    2019, 4, name: 'Secure Container',
    solution1: 530, solution2: 324,
  );

  @override
  dynamic part1(String input) {
    bool possiblePassword(int n) {
      final digits = n.toString().split('');
      return
        digits.slicesWhere(isGreaterThan).length == 1 &&
        digits.slicesWhere(isNotEqual).any((l) => l.length > 1);
    }

    return inputRange(input).where(possiblePassword).length;
  }

  @override
  dynamic part2(String input) {
    bool possiblePassword(int n) {
      final digits = n.toString().split('');
      return
        digits.slicesWhere(isGreaterThan).length == 1 &&
        digits.slicesWhere(isNotEqual).any((l) => l.length == 2);
    }

    return inputRange(input).where(possiblePassword).length;
  }

  Iterable<int> inputRange(String input) {
    final parts = input.split('-');
    return range(int.parse(parts[0]), int.parse(parts[1]));
  }
}
