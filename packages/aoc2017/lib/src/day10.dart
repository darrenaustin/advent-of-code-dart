// https://adventofcode.com/2017/day/10

import 'package:aoc/aoc.dart';
import 'package:aoc/util/range.dart';
import 'package:aoc/util/string.dart';

main() => Day10().solve();

class Day10 extends AdventDay {
  Day10() : super(2017, 10, name: 'Knot Hash');

  @override
  dynamic part1(String input, [int numElements = 256]) {
    final nums = range(numElements).toList();
    int current = 0;
    int skip = 0;

    for (final length in input.numbers()) {
      final selected =
          range(length).map((i) => (current + i) % numElements).toList();
      for (int i = 0; i < length ~/ 2; i++) {
        final temp = nums[selected[i]];
        nums[selected[i]] = nums[selected[length - i - 1]];
        nums[selected[length - i - 1]] = temp;
      }
      current += length + skip;
      skip++;
    }

    return nums[0] * nums[1];
  }

  @override
  dynamic part2(String input) {
    final nums = range(256).toList();
    int current = 0;
    int skip = 0;
    final lengths = [...input.codeUnits, 17, 31, 73, 47, 23];
    for (final _ in range(64)) {
      for (final length in lengths) {
        final selected = range(length).map((i) => (current + i) % 256).toList();
        for (int i = 0; i < length ~/ 2; i++) {
          final temp = nums[selected[i]];
          nums[selected[i]] = nums[selected[length - i - 1]];
          nums[selected[length - i - 1]] = temp;
        }
        current += length + skip;
        skip++;
      }
    }

    final denseHash = <int>[];
    for (int i = 0; i < 256; i += 16) {
      denseHash.add(nums.sublist(i, i + 16).reduce((n, e) => n ^ e));
    }

    return denseHash.map((n) => n.toRadixString(16).padLeft(2, '0')).join('');
  }
}
