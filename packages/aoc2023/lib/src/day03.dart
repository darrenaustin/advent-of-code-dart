// ignore_for_file: public_member_api_docs, sort_constructors_first
// https://adventofcode.com/2023/day/3

import 'package:aoc/aoc.dart';
import 'package:aoc/util/collection.dart';
import 'package:aoc/util/grid2.dart';
import 'package:aoc/util/string.dart';
import 'package:aoc/util/vec.dart';
import 'package:collection/collection.dart';

main() => Day03().solve();

class Day03 extends AdventDay {
  Day03() : super(2023, 3, name: 'Gear Ratios');

  static RegExp symbolRegExp = RegExp(r'[^\.0-9]', multiLine: true);
  static RegExp gearRegExp = RegExp(r'\*', multiLine: true);

  @override
  dynamic part1(String input) {
    final grid = parseGrid(input);
    final numberMatches = RegExp(r'[\d]+', multiLine: true).allMatches(input);
    return numberMatches
        .map((m) => partNumber(grid, m))
        .where((n) => validPartNumber(grid, n))
        .map((n) => n.value)
        .sum;
  }

  @override
  dynamic part2(String input) {
    final grid = parseGrid(input);
    final numberMatches = RegExp(r'[\d]+', multiLine: true).allMatches(input);
    final validParts = numberMatches
        .map((m) => partNumber(grid, m))
        .where((n) => validPartNumber(grid, n, gearRegExp));

    final gearLocations = RegExp(r'\*', multiLine: true)
        .allMatches(input)
        .map((p) => gridPosFrom(grid, p.start));

    var sum = 0;
    for (final gear in gearLocations) {
      final adjacentNumbers = validParts
          .where((n) => grid.neighborLocations(gear).any((p) => n.inside(p)));
      if (adjacentNumbers.length == 2) {
        final ratio = adjacentNumbers.map((n) => n.value).product;
        sum += ratio;
      }
    }
    return sum;
  }

  Grid<String> parseGrid(String input) {
    List<List<String>> data = input.lines.map((s) => s.chars.toList()).toList();
    return Grid.from(data, '.');
  }

  Vec2 gridPosFrom(Grid grid, int stringStartIndex) => Vec2.int(
      stringStartIndex % (grid.width + 1),
      stringStartIndex ~/ (grid.height + 1));

  PartNumber partNumber(Grid grid, RegExpMatch match) {
    final numDigits = match.end - match.start;
    final Vec2 start = Vec2.int(
        match.start % (grid.width + 1), match.start ~/ (grid.height + 1));
    final Vec2 end = start + Vec2.int(numDigits - 1, 0);
    return PartNumber(match.group(0)!, start, end);
  }

  bool validPartNumber(Grid grid, PartNumber number, [RegExp? regexp]) {
    return number
        .neighborPositions()
        .where((p) => grid.validCell(p))
        .map((p) => grid.cell(p))
        .any((c) => (regexp ?? symbolRegExp).hasMatch(c));
  }
}

class PartNumber {
  PartNumber(this.text, this.start, this.end);

  final String text;
  final Vec2 start;
  final Vec2 end;

  int get value => int.parse(text);

  Iterable<Vec2> neighborPositions() {
    final numDigits = text.length;
    return [
      start + Vec2.upLeft,
      for (int x = 0; x <= numDigits; x++) start + Vec2.int(x, -1),
      start + Vec2.left,
      start + Vec2.right * numDigits,
      start + Vec2.downLeft,
      for (int x = 0; x <= numDigits; x++) start + Vec2.int(x, 1),
    ];
  }

  bool inside(Vec2 p) =>
      p.yInt == start.yInt && start.xInt <= p.xInt && p.xInt <= end.xInt;

  @override
  String toString() => 'PartNumber(value: $value, start: $start, end: $end)';
}
