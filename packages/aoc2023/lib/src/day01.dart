// https://adventofcode.com/2023/day/1

import 'package:aoc/aoc.dart';
import 'package:aoc/util/string.dart';
import 'package:collection/collection.dart';

main() => Day01().solve();

class Day01 extends AdventDay {
  Day01() : super(2023, 1, name: 'Trebuchet?!');

  @override
  dynamic part1(String input) => input.lines.map(calibrationValue).sum;

  @override
  dynamic part2(String input) =>
      input.lines.map(spelledOutCalibrationValue).sum;

  int calibrationValue(String entry) {
    final digits = RegExp(r'[\d]').allStringMatches(entry);
    return int.parse('${digits.first}${digits.last}');
  }

  int spelledOutCalibrationValue(String entry) {
    final digits =
        RegExp(r'[\d]|zero|one|two|three|four|five|six|seven|eight|nine')
            .allOverlappingStringMatches(entry);
    final digitValue = {
      "0": 0,
      "1": 1,
      "2": 2,
      "3": 3,
      "4": 4,
      "5": 5,
      "6": 6,
      "7": 7,
      "8": 8,
      "9": 9,
      "zero": 0,
      "one": 1,
      "two": 2,
      "three": 3,
      "four": 4,
      "five": 5,
      "six": 6,
      "seven": 7,
      "eight": 8,
      "nine": 9,
    };
    return int.parse('${digitValue[digits.first]}${digitValue[digits.last]}');
  }
}
