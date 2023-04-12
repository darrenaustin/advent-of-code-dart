// https://adventofcode.com/2021/day/3

import 'package:aoc/aoc.dart';
import 'package:aoc/util/string.dart';

main() => Day03().solve();

class Day03 extends AdventDay {
  Day03() : super(2021, 3, name: 'Binary Diagnostic');

  @override
  dynamic part1(String input) {
    final diagnostics = parseDiagnostics(input);
    final numBits = diagnostics.first.length;
    final gammaBits = <String>[];
    final epsilonBits = <String>[];

    for (int i = 0; i < numBits; i++) {
      final bits = diagnostics.map((e) => e[i]);
      final ones = bits.where((e) => e == '1').length;
      final zeros = diagnostics.length - ones;
      gammaBits.add(zeros < ones ? '1' : '0');
      epsilonBits.add(zeros < ones ? '0' : '1');
    }

    return int.parse(gammaBits.join(), radix: 2) *
           int.parse(epsilonBits.join(), radix: 2);
  }

  @override
  dynamic part2(String input) {
    final diagnostics = parseDiagnostics(input);

    int findRating(String filterMoreOnesOrEqual, String filterLessOnes) {
      Iterable<List<String>> candidates = diagnostics;
      final numBits = diagnostics.first.length;
      for (int i = 0; i < numBits; i++) {
        if (candidates.length == 1) {
          break;
        }
        final bits = candidates.map((e) => e[i]);
        final zeros = bits.where((e) => e == '0').length;
        final ones = candidates.length - zeros;
        final filter = zeros <= ones ? filterMoreOnesOrEqual : filterLessOnes;
        candidates = candidates.where((e) => e[i] == filter);
      }
      return int.parse(candidates.first.join(), radix: 2);
    }

    return findRating('1', '0') * findRating('0', '1');
  }

  Iterable<List<String>> parseDiagnostics(String input) =>
    input.lines.map((l) => l.chars);
}
