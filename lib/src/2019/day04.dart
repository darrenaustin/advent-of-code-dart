// https://adventofcode.com/2019/day/4

import '../../day.dart';
import '../util/collection.dart';
import '../util/comparison.dart';

class Day04 extends AdventDay {
  Day04() : super(2019, 4, solution1: 530, solution2: 324);

  @override
  dynamic part1() {
    bool possiblePassword(int n) {
      final digits = n.toString().split('');
      return
        digits.partitionWhere(isNotEqual).any((l) => l.length > 1) &&
        digits.partitionWhere(isGreaterThan).length == 1;
    }

    return range(357253, 892942).where(possiblePassword).length;
  }

  @override
  dynamic part2() {
    bool possiblePassword(int n) {
      final digits = n.toString().split('');
      return
        digits.partitionWhere(isNotEqual).any((l) => l.length == 2) &&
        digits.partitionWhere(isGreaterThan).length == 1;
    }

    return range(357253, 892942).where(possiblePassword).length;
  }
}
