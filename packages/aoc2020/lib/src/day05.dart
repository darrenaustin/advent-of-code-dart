// https://adventofcode.com/2020/day/5

import 'package:aoc/aoc.dart';
import 'package:aoc/util/string.dart';
import 'package:collection/collection.dart';

main() => Day05().solve();

class Day05 extends AdventDay {
  Day05() : super(2020, 5, name: 'Binary Boarding');

  @override
  dynamic part1(String input) => input.lines.map(seatId).max;

  @override
  dynamic part2(String input) {
    final seatsTaken = input.lines.map(seatId).toList()..sort();
    for (int s = 0; s < seatsTaken.length - 1; s++) {
      final nextSeat = seatsTaken[s] + 1;
      if (nextSeat != seatsTaken[s + 1]) {
        return nextSeat;
      }
    }
  }

  static int partitionValue<T>(List<T> codes, T lowerCode, T upperCode, int size) {
    var lowerBound = 0;
    var upperBound = size - 1;

    for (final code in codes) {
      final half = (upperBound - lowerBound + 1) ~/ 2;
      if (code == lowerCode) {
        upperBound -= half;
      } else if (code == upperCode) {
        lowerBound += half;
      } else {
        throw Exception('Unknown partition code $code');
      }
    }
    return lowerBound;
  }

  static int seatId(String seatCodes) {
    final codes = seatCodes.chars;
    var row = partitionValue(codes.sublist(0, 7), 'F', 'B', 128);
    var column = partitionValue(codes.sublist(7), 'L', 'R', 8);
    return row * 8 + column;
  }
}
