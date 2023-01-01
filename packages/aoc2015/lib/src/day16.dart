// https://adventofcode.com/2015/day/16

import 'package:aoc/aoc.dart';

class Day16 extends AdventDay {
  Day16() : super(2015, 16, solution1: 103, solution2: 405);

  @override
  dynamic part1(String input) {
    return inputAunts().firstWhere(auntMatchesCompounds)['Sue'];
  }

  @override
  dynamic part2(String input) {
    final Set<String> greaterThan = <String>{'cats', 'trees'};
    final Set<String> lessThan = <String>{'pomeranians', 'goldfish'};
    return inputAunts().firstWhere((Map<String, int> a) =>
      auntMatchesCompounds(a, greaterThan, lessThan))['Sue']!;
  }

  final Map<String, int> compounds = <String, int>{
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

  Iterable<Map<String, int>> inputAunts() {
    final List<Map<String, int>> aunts = <Map<String, int>>[];
    inputDataLines().forEach((String l) {
      final RegExpMatch parse = RegExp(r'^Sue (\d+): (.+)$').firstMatch(l)!;
      final Map<String, int> aunt = <String, int>{ 'Sue': int.parse(parse.group(1)!) };
      parse.group(2)!.split(', ').forEach((String c) {
        final List<String> nameValue = c.split(': ');
        aunt[nameValue.first] = int.parse(nameValue.last);
      });
      aunts.add(aunt);
    });
    return aunts;
  }

  bool auntMatchesCompounds(Map<String, int> aunt, [Set<String>? greaterThan, Set<String>? lessThan]) {
    return aunt.entries
      .where((MapEntry<String, int> e) => e.key != 'Sue')
      .every((MapEntry<String, int> e) {
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
