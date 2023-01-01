// https://adventofcode.com/2021/day/3

import 'package:aoc/aoc.dart';

class Day03 extends AdventDay {
  Day03() : super(2021, 3, solution1: 3309596, solution2: 2981085);

  @override
  dynamic part1() {
    final diagnostics = inputDiagnostics();
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
  dynamic part2() {
    final diagnostics = inputDiagnostics();

    int findRating(String filterMoreOnesOrEqual, String filterLessOnes) {
      var ratingsPossible = diagnostics;
      final numBits = diagnostics.first.length;
      for (int i = 0; i < numBits; i++) {
        if (ratingsPossible.length == 1) {
          break;
        }
        final bits = ratingsPossible.map((e) => e[i]);
        final zeros = bits.where((e) => e == '0').length;
        final ones = ratingsPossible.length - zeros;
        final filter = zeros <= ones ? filterMoreOnesOrEqual : filterLessOnes;
        ratingsPossible = ratingsPossible.where((e) => e[i] == filter);
      }
      return int.parse(ratingsPossible.first.join(), radix: 2);
    }

    return findRating('1', '0') * findRating('0', '1');
  }

  Iterable<List<String>> inputDiagnostics() {
    return inputDataLines().map((l) => l.split(''));
  }
}
