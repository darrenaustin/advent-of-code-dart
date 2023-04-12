// https://adventofcode.com/2017/day/4

import 'package:aoc/aoc.dart';
import 'package:aoc/util/string.dart';
import 'package:collection/collection.dart';

main() => Day04().solve();

class Day04 extends AdventDay {
  Day04() : super(2017, 4, name: 'High-Entropy Passphrases');

  @override
  dynamic part1(String input) {
    return input
      .lines
      .where(validPassphrase)
      .length;
  }

  @override
  dynamic part2(String input) {
    return input
      .lines
      .where(validAnagramPassphrase)
      .length;
  }

  static bool validPassphrase(String phrase) {
    final words = phrase.split(' ');
    return words.length == words.toSet().length;
  }

  static bool validAnagramPassphrase(String phrase) {
    final words = phrase.split(' ').map((w) => w.chars.sorted().join());
    return words.length == words.toSet().length;
  }
}
