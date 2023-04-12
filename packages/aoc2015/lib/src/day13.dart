// https://adventofcode.com/2015/day/13

import 'package:aoc/aoc.dart';
import 'package:aoc/util/combinatorics.dart';
import 'package:aoc/util/string.dart';
import 'package:collection/collection.dart';

main() => Day13().solve();

typedef Rules = Map<String, Map<String, int>>;

class Day13 extends AdventDay {
  Day13() : super(2015, 13, name: 'Knights of the Dinner Table');

  @override
  dynamic part1(String input) {
    final rules = happinessRules(input);
    final guests = rules.keys.toSet();
    return permutations(guests)
      .map((seatingOrder) => happiness(seatingOrder, rules))
      .max;
  }

  @override
  dynamic part2(String input) {
    final rules = happinessRules(input);
    Set<String> guests = rules.keys.toSet();

    // Update rules to include ambivalent self
    for (final guest in rules.keys) {
      rules[guest]!['Me'] = 0;
    }
    rules['Me'] = Map<String, int>.fromEntries(guests.map((g) => MapEntry(g, 0)));
    guests.add('Me');

    return permutations(guests)
      .map((seatingOrder) => happiness(seatingOrder, rules))
      .max;
  }

  final RegExp _rulePattern = 
    RegExp(r'^(.+) would (gain|lose) (\d+) happiness units by sitting next to (.+).$');

  Rules happinessRules(String input) {
    final rules = <String, Map<String, int>>{};
    for (final line in input.lines) {
      final match = _rulePattern.firstMatch(line)!;
      final person1 = match.group(1)!;
      final person2 = match.group(4)!;
      final happiness =
        int.parse(match.group(3)!) *
        (match.group(2) == 'lose' ? -1 : 1);
      (rules[person1] ??= {})[person2] = happiness;
    }
    return rules;
  }

  int happiness(Iterable<String> seatingOrder, Rules rules) {
    final List<String> order = seatingOrder.toList();
    int totalHappiness = 0;
    for (int i = 0; i < order.length - 1; i++) {
      totalHappiness += rules[order[i]]![order[i + 1]]!;
      totalHappiness += rules[order[i + 1]]![order[i]]!;
    }
    totalHappiness += rules[order.first]![order.last]!;
    totalHappiness += rules[order.last]![order.first]!;
    return totalHappiness;
  }
}