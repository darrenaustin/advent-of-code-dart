// https://adventofcode.com/2020/day/1

import 'package:aoc/aoc.dart';
import 'package:aoc/util/collection.dart';
import 'package:aoc/util/string.dart';
import 'package:collection/collection.dart';

main() => Day01().solve();

class Day01 extends AdventDay {
  Day01() : super(2020, 1, name: 'Report Repair');

  @override
  dynamic part1(String input) => pairs(expenseReport(input))
      .where((pair) => pair.sum == 2020)
      .first
      .product;

  @override
  dynamic part2(String input) => triples(expenseReport(input))
      .where((triple) => triple.sum == 2020)
      .first
      .product;

  List<int> expenseReport(String input) => input.lines.map(int.parse).toList();

  Iterable<List<int>> pairs(List<int> l) sync* {
    for (int i = 0; i < l.length - 1; i++) {
      for (int j = i + 1; j < l.length; j++) {
        yield [l[i], l[j]];
      }
    }
  }

  Iterable<List<int>> triples(List<int> l) sync* {
    for (int i = 0; i < l.length - 2; i++) {
      for (int j = i + 1; j < l.length - 1; j++) {
        for (int k = j + 1; k < l.length; k++) {
          yield [l[i], l[j], l[k]];
        }
      }
    }
  }
}
