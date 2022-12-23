// https://adventofcode.com/2015/day/2

import '../../day.dart';
import '../util/collection.dart';

class Day02 extends AdventDay {
  Day02() : super(2015, 2, solution1: 1598415, solution2: 3812909);

  @override
  dynamic part1() {
    return inputPackages().map(wrapNeededFor).sum;
  }

  @override
  dynamic part2() {
    return inputPackages().map(ribbonNeededFor).sum;
  }

  Iterable<List<int>> inputPackages() {
    return inputDataLines().map(parsePackage);
  }

  static List<int> parsePackage(String input) {
    return input.split('x').map(int.parse).toList()..sort();
  }

  static int wrapNeededFor(List<int> dimens) =>
    3 * (dimens[0] * dimens[1]) + // smallest side counts one extra.
    2 * (dimens[1] * dimens[2]) +
    2 * (dimens[0] * dimens[2]);

  static int ribbonNeededFor(List<int> dimens) =>
    2 * (dimens[0] + dimens[1]) + (dimens[0] * dimens[1] * dimens[2]);
}
