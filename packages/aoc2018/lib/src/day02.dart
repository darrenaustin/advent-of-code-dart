// https://adventofcode.com/2018/day/2

import 'package:aoc/aoc.dart';
import 'package:aoc/util/collection.dart';
import 'package:aoc/util/string.dart';

main() => Day02().solve();

class Day02 extends AdventDay {
  Day02() : super(2018, 2, name: 'Inventory Management System');

  @override
  dynamic part1(String input) {
    int twoOfAnyLetter = 0;
    int threeOfAnyLetter = 0;
    for (final boxId in input.lines) {
      final charCounts = frequencies(boxId.chars);
      if (charCounts.values.contains(2)) {
        twoOfAnyLetter++;
      }
      if (charCounts.values.contains(3)) {
        threeOfAnyLetter++;
      }
    }
    return twoOfAnyLetter * threeOfAnyLetter;
  }

  @override
  dynamic part2(String input) {
    final boxIds = input.lines;
    for (int i = 0; i < boxIds.length - 1; i++) {
      for (int j = i; j < boxIds.length; j++) {
        final differentIndex = differentByOneIndex(boxIds[i], boxIds[j]);
        if (differentIndex != null) {
          return boxIds[i].replaceRange(differentIndex, differentIndex + 1, '');
        }
      }
    }
  }

  static int? differentByOneIndex(String boxId1, String boxId2) {
    int? differentIndex;
    if (boxId1.length == boxId2.length) {
      for (int i = 0; i < boxId1.length; i++) {
        if (boxId1[i] != boxId2[i]) {
          if (differentIndex != null) {
            // More than one difference
            return null;
          }
          differentIndex = i;
        }
      }
    }
    return differentIndex;
  }
}
