// https://adventofcode.com/2015/day/16

import 'package:aoc/aoc.dart';
import 'package:aoc/util/string.dart';
import 'package:collection/collection.dart';

main() => Day16().solve();

class Day16 extends AdventDay {
  Day16() : super(
    2015, 16, name: 'Aunt Sue', 
    solution1: 103, solution2: 405,
  );

  @override
  dynamic part1(String input) {
    return input
      .lines
      .map(parseAuntItems)
      .mapIndexed((i, auntItems) => auntHasCompounds(auntItems) ? i + 1 : null)
      .whereNotNull()
      .first;
  }

  @override
  dynamic part2(String input) {
    final greaterThan = {'cats', 'trees'};
    final lessThan = {'pomeranians', 'goldfish'};
    return input
      .lines
      .map(parseAuntItems)
      .mapIndexed((i, auntItems) =>
        auntHasCompounds(auntItems, greaterThan, lessThan) ? i + 1 : null)
      .whereNotNull()
      .first;
  }

  final compounds = <String, int>{
    'children': 3,
    'cats': 7,
    'samoyeds': 2,
    'pomeranians': 3,
    'akitas': 0,
    'vizslas': 0,
    'goldfish': 5,
    'trees': 3,
    'cars': 2,
    'perfumes': 1,
  };

  static Map<String, int> parseAuntItems(String input) {
      final match = RegExp(r'^Sue \d+: (.+)$').firstMatch(input)!;
      final aunt = <String, int>{};
      match.group(1)!.split(', ').forEach((String c) {
        final nameValue = c.split(': ');
        aunt[nameValue.first] = int.parse(nameValue.last);
      });
      return aunt;
  }

  bool auntHasCompounds(Map<String, int> aunt,
   [Set<String>? greaterThan, Set<String>? lessThan]
  ) {
    return aunt.entries
      .every((e) {
        if (greaterThan != null && greaterThan.contains(e.key)) {
          return compounds[e.key]! < e.value;
        }
        if (lessThan != null && lessThan.contains(e.key)) {
          return compounds[e.key]! > e.value;
        }
        return compounds[e.key] == e.value;
      });
  }
}
