// https://adventofcode.com/2016/day/6

import 'package:aoc/aoc.dart';
import 'package:aoc/util/comparison.dart';
import 'package:aoc/util/string.dart';
import 'package:collection/collection.dart';

main() => Day06().solve();

class Day06 extends AdventDay {
  Day06() : super(2016, 6, name: 'Signals and Noise');

  @override
  dynamic part1(String input) =>
    errorCorrectedMessage(input.lines, numMaxComparator);

  @override
  dynamic part2(String input) =>
    errorCorrectedMessage(input.lines, numMinComparator);

  String errorCorrectedMessage(Iterable<String> recorded, Comparator<int> freqCompare) {
    final message = StringBuffer();
    for (int i = 0; i < recorded.first.length; i++) {
      final charFrequency = <String, int>{};
      for (final c in recorded) {
        charFrequency[c[i]] = (charFrequency[c[i]] ?? 0) + 1;
      }
      final sortedChars = charFrequency
        .keys
        .sorted((k1, k2) => freqCompare(charFrequency[k1]!, charFrequency[k2]!));
      message.write(sortedChars.first);
    }
    return message.toString();
  }

}
