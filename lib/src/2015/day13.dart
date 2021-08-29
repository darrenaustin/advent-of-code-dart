// https://adventofcode.com/2015/day/13

import 'package:collection/collection.dart';

import '../../day.dart';
import '../util/collection.dart';

class Day13 extends AdventDay {
  Day13() : super(2015, 13, solution1: 709, solution2: 668);

  @override
  dynamic part1() {
    final Map<String, Map<String, int>> rules = inputHappinessRules();
    return permutations(rules.keys.toSet())
        .map((Iterable<String> p) => happiness(p, rules))
        .max();
  }

  @override
  dynamic part2() {
    final Map<String, Map<String, int>> rules = inputHappinessRules();
    final Iterable<String> names = rules.keys;
    for (final String n in names) {
      rules[n]!['Me'] = 0;
    }
    rules['Me'] = Map<String, int>.fromEntries(
        names.map((String n) => MapEntry<String, int>(n, 0)));
    return permutations(rules.keys.toSet())
        .map((Iterable<String> p) => happiness(p, rules))
        .max();
  }

  final RegExp ruleRegex = RegExp(r'^(.+) would (gain|lose) (\d+) happiness units by sitting next to (.+).$');

  Map<String, Map<String, int>> inputHappinessRules() {
    final Map<String, Map<String, int>> rules = <String, Map<String, int>>{};
    inputDataLines().forEach((String l) {
      final RegExpMatch parse = ruleRegex.firstMatch(l)!;
      final String person1 = parse.group(1)!;
      final String person2 = parse.group(4)!;
      final int happiness = int.parse(parse.group(3)!) * (parse.group(2) == 'lose' ? -1 : 1);
      rules[person1] = (rules[person1] ?? <String, int>{})..[person2] = happiness;
    });
    return rules;
  }

  int happiness(Iterable<String> seatingOrder, Map<String, Map<String, int>> rules) {
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

  Iterable<Iterable<String>> permutations(Set<String> elements) {
    if (elements.isEmpty) {
      return <Iterable<String>>[<String>[]];
    }
    Iterable<Iterable<String>> permsWithoutElement(String element) {
      return permutations(elements.difference(<String>{element}));
    }

    return elements
        .map((String e) => permsWithoutElement(e)
            .map((Iterable<String> p) => <String>[e, ...p]))
        .flattened;
  }
}
