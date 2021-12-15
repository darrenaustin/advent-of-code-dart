// https://adventofcode.com/2021/day/14

import 'package:advent_of_code_dart/src/util/collection.dart';

import '../../day.dart';

class Day14 extends AdventDay {
  Day14() : super(2021, 14, solution1: 2975);

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
  }

}
