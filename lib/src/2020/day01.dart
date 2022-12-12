// https://adventofcode.com/2020/day/1

import '../../day.dart';
import '../util/collection.dart';

class Day01 extends AdventDay {
  Day01() : super(2020, 1, solution1: 1015476, solution2: 200878544);

  @override
  dynamic part1() {
    return pairs(expenseReport())
      .where((pair) => pair.sum() == 2020)
      .first
      .product();
  }

  @override
  dynamic part2() {
    return triples(expenseReport())
      .where((triple) => triple.sum() == 2020)
      .first
      .product();
  }

  List<int> expenseReport() {
    return inputDataLines()
      .map(int.parse)
      .toList();
  }

  Iterable<List<int>> pairs(List<int> l) sync* {
    for (int i = 0; i < l.length - 1; i++) {
      for (int j = i + 1; j < l.length; j++) {
        yield [l[i], l[j]];
      }
    }
  }

  Iterable<List<int>> triples(List<int> l) sync* {
    for (var i = 0; i < l.length - 2; i++) {
      for (var j = i + 1; j < l.length - 1; j++) {
        for (var k = j + 1; k < l.length; k++) {
          yield [l[i], l[j], l[k]];
        }
      }
    }
  }
}
