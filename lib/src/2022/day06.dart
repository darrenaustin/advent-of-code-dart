// https://adventofcode.com/2022/day/6

import '../../day.dart';

class Day06 extends AdventDay {
  Day06() : super(2022, 6, solution1: 1658, solution2: 2260);

  @override
  dynamic part1() {
    return firstMarker(inputData(), 4);
  }

  @override
  dynamic part2() {
    return firstMarker(inputData(), 14);
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
