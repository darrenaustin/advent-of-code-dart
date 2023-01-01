// https://adventofcode.com/2015/day/19

import 'package:collection/collection.dart';

import 'package:aoc/aoc.dart';

class Day19 extends AdventDay {
  Day19() : super(2015, 19, solution1: 518, solution2: 200);

  @override
  dynamic part1(String input) {
    return moleculesFrom(inputMolecule(), inputReplacements()).length;
  }

  @override
  dynamic part2(String input) {
    final List<Replacement> replacements = inputReplacements()
      .map((Replacement r) => r.reverse())
      .sorted((Replacement a, Replacement b) => b.pattern.length.compareTo(a.pattern.length));
    const String targetMolecule = 'e';

    int? findShortestPath(String molecule) {
      if (molecule == targetMolecule) {
        return 0;
      }
      for (final Replacement r in replacements) {
        final Iterable<Match> matches = r.pattern.allMatches(molecule);
        for (final Match match in matches) {
          final String nextMolecule = molecule.replaceRange(match.start, match.end, r.value);
          final int? path = findShortestPath(nextMolecule);
          if (path != null) {
            return path + 1;
          }
        }
      }
      return null;
    }

    return findShortestPath(inputMolecule());
  }

  Iterable<Replacement> inputReplacements() {
    return inputDataLines()
      .map((String l) => RegExp(r'^(.+) => (.*)$').firstMatch(l))
      .whereNotNull()
      .map((RegExpMatch m) => Replacement(m.group(1)!, m.group(2)!));
  }

  String inputMolecule() {
    return inputDataLines().last;
  }

  Set<String> moleculesFrom(String startMolecule, Iterable<Replacement> replacements) {
    final Set<String> molecules = <String>{};
    for (final Replacement r in replacements) {
      final Iterable<Match> matches = r.pattern.allMatches(startMolecule);
      for (final Match match in matches) {
        molecules.add(startMolecule.replaceRange(match.start, match.end, r.value));
      }
    }
    return molecules;
  }
}

class Replacement {
  Replacement(this.pattern, this.value);

  final String pattern;
  final String value;

  Replacement reverse() => Replacement(value, pattern);

  @override
  String toString() {
    return '$pattern -> $value';
  }
}
