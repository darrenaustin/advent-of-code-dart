// https://adventofcode.com/2018/day/1

import 'package:aoc/aoc.dart';
import 'package:collection/collection.dart';

main() => Day01().solve();

class Day01 extends AdventDay {
  Day01() : super(2018, 1, name: 'Chronal Calibration');

  @override
  dynamic part1(String input) => frequencies(input).sum;

  @override
  dynamic part2(String input) {
    final nums = frequencies(input);
    final seen = <int>{};
    int freq = 0;

    int index = 0;
    while (!seen.contains(freq)) {
      seen.add(freq);
      freq += nums[index];
      index = (index + 1) % nums.length;
    }
    return freq;
  }

  List<int> frequencies(String input) =>
    input.split(RegExp(r'\s+')).map(int.parse).toList();
}
