// https://adventofcode.com/2021/day/14

import 'package:advent_of_code_dart/src/util/collection.dart';

import '../../day.dart';

class Day14 extends AdventDay {
  Day14() : super(2021, 14, solution1: 2975, solution2: 3015383850689);

  @override
  dynamic part1() {
    String applyPairs(String template, Map<String, String> pairs) {
      var result = template.split('');
      for (final pattern in pairs.keys) {
        var start = 0;
        var index = template.indexOf(pattern, start);
        while (index != -1) {
          result[index] = result[index] + pairs[pattern]!;
          start = index + 1;
          index = template.indexOf(pattern, start);
        }
      }
      return result.join('');
    }

    var template = inputDataLines().first;
    final pairs = Map.fromEntries(inputDataLines().skip(1).map((l)  {
      final parts = l.split(' -> ');
      return MapEntry(parts[0], parts[1]);
    }));
    for (int i = 0; i < 10; i++) {
      template = applyPairs(template, pairs);
    }
    final values = template.split('').toList()..sort();
    final freqs = values.partitionWhere((a, b) => a != b).map((l) => l.length).toList()..sort();
    return freqs.last - freqs.first;
  }

  @override
  dynamic part2() {
    final template = inputDataLines().first.split('');
    final rules = Map.fromEntries(inputDataLines().skip(1).map((l)  {
      final parts = l.split(' -> ');
      return MapEntry(parts[0], parts[1]);
    }));
    final rulePairs = Map.fromEntries(rules.entries.map((e) {
      final chars = e.key.split('');
      return MapEntry(e.key, [chars[0] + e.value, e.value + chars[1]].where(rules.keys.contains));
    }));

    final charCounts = <String, int>{};
    for (final ch in template) {
      charCounts[ch] = (charCounts[ch] ?? 0) + 1;
    }
    final initialPairs = range(0, template.length - 1)
        .map((i) => template[i] + template[i + 1])
        .where(rules.containsKey)
        .toList();
    var pairCounts = <String, int>{};
    for (final pair in initialPairs) {
      pairCounts[pair] = (pairCounts[pair] ?? 0) + 1;
    }

    for (int step = 0; step < 40; step++) {
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
}
