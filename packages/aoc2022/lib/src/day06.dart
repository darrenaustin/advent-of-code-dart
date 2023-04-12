// https://adventofcode.com/2022/day/6

import 'package:aoc/aoc.dart';

main() => Day06().solve();

class Day06 extends AdventDay {
  Day06() : super(2022, 6, name: 'Tuning Trouble');

  @override
  dynamic part1(String input) {
    return firstMarker(input, 4);
  }

  @override
  dynamic part2(String input) {
    return firstMarker(input, 14);
  }

  int? firstMarker(String s, int markerLength) {
    for (int i = markerLength; i <  s.length; i++) {
      final marker = s.substring(i - markerLength, i).split('').toSet();
      if (marker.length == markerLength) {
        return i;
      }
    }
    return null;
  }
}
