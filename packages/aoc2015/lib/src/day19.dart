// https://adventofcode.com/2015/day/19

import 'package:aoc/aoc.dart';
import 'package:aoc/util/string.dart';
import 'package:collection/collection.dart';

main() => Day19().solve();

class Day19 extends AdventDay {
  Day19() : super(
    2015, 19, name: 'Medicine for Rudolph',
    solution1: 518, solution2: 200,
  );

  @override
  dynamic part1(String input) =>
    moleculesFrom(parseMolecule(input), parseReplacements(input)).length;

  @override
  dynamic part2(String input, [String? molecule]) {
    const String targetMolecule = 'e';
    final replacements = parseReplacements(input)
      .map((r) => r.reverse())
      .sorted((a, b) => b.pattern.length.compareTo(a.pattern.length));

    int? findShortestPath(String molecule) {
      if (molecule == targetMolecule) return 0;
      for (final r in replacements) {
        for (final match in r.pattern.allMatches(molecule)) {
          final nextMolecule = molecule.replaceRange(match.start, match.end, r.value);
          final path = findShortestPath(nextMolecule);
          if (path != null) {
            return path + 1;
          }
        }
      }
      return null;
    }

    return findShortestPath(molecule ?? parseMolecule(input));
  }

  Iterable<Replacement> parseReplacements(String input) {
    return input
      .split('\n\n')[0]
      .lines
      .map((line) => RegExp(r'^(.+) => (.*)$').firstMatch(line)!)
      .map((match) => Replacement(match.group(1)!, match.group(2)!));
  }

  String parseMolecule(String input) => input.lines.last;

  Set<String> moleculesFrom(String startMolecule, Iterable<Replacement> replacements) {
    return replacements
      .map((r) => r.pattern.allMatches(startMolecule)
        .map((match) => startMolecule.replaceRange(match.start, match.end, r.value)))
      .flattened
      .toSet();
  }
}

class Replacement {
  Replacement(this.pattern, this.value);

  final String pattern;
  final String value;

  Replacement reverse() => Replacement(value, pattern);
}
