// https://adventofcode.com/2021/day/14

import 'package:aoc/aoc.dart';
import 'package:aoc/util/collection.dart';
import 'package:aoc/util/string.dart';

main() => Day14().solve();

class Day14 extends AdventDay {
  Day14() : super(
    2021, 14, name: 'Extended Polymerization',
    solution1: 2975, solution2: 3015383850689,
  );

  @override
  dynamic part1(String input) {
    final inputLines = input.lines;
    final template = inputTemplate(inputLines);
    final rules = inputRules(inputLines);
    return polymerStrength(template, rules, 10);
  }

  @override
  dynamic part2(String input) {
    final inputLines = input.lines;
    final template = inputTemplate(inputLines);
    final rules = inputRules(inputLines);
    return polymerStrength(template, rules, 40);
  }

  int polymerStrength(List<String> template, Map<String, String> rules, int steps) {
    // Compute a map of pairs to new pairs that will be created from
    // the insertion of a given rule. (I.e. CH -> B => {'CH': ['CB', 'BH']} if
    // 'CB' and 'BH' also have rules for them).
    final rulePairs = Map.fromEntries(rules.entries.map((rule) {
      final chars = rule.key.split('');
      return MapEntry(rule.key,
        [
          chars[0] + rule.value,
          rule.value + chars[1]
        ]
        .where(rules.keys.contains)
      );
    }));

    // Instead of doing list insertions, we just keep track of the current
    // counts for each character and the counts of pairs that will cause
    // insertions on the next step.
    Map<String, int> charCounts = frequencies(template);
    final initialPairs = range(0, template.length - 1)
        .map((i) => template[i] + template[i + 1])
        .where(rules.containsKey)
        .toList();
    Map<String, int> pairCounts = frequencies(initialPairs);

    for (final _ in range(steps)) {
      final newPairCounts = <String, int>{};
      for (final pairCount in pairCounts.entries) {
        final pair = pairCount.key;
        final count = pairCount.value;
        final newChar = rules[pair]!;
        charCounts[newChar] = (charCounts[newChar] ?? 0) + count;
        final newPairs = rulePairs[pair]!;
        for (final newPair in newPairs) {
          newPairCounts[newPair] = (newPairCounts[newPair] ?? 0) + count;
        }
      }
      pairCounts = newPairCounts;
    }

    final counts = charCounts.values.toList()..sort();
    return counts.last - counts.first;
  }

  List<String> inputTemplate(List<String> lines) => lines.first.split('');

  Map<String, String> inputRules(List<String> lines) =>
    Map.fromEntries(lines.skip(2).map((l)  {
      final parts = l.split(' -> ');
      return MapEntry(parts[0], parts[1]);
    }));
}
