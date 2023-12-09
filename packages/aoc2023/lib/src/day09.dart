// https://adventofcode.com/2023/day/9

import 'package:aoc/aoc.dart';
import 'package:aoc/util/string.dart';
import 'package:collection/collection.dart';

main() => Day09().solve();

class Day09 extends AdventDay {
  Day09() : super(2023, 9, name: 'Mirage Maintenance');

  @override
  dynamic part1(String input) => parseHistories(input).map(extrapolateNext).sum;

  @override
  dynamic part2(String input) =>
      parseHistories(input).map(extrapolatePrevious).sum;

  Iterable<List<int>> parseHistories(String input) =>
      input.lines.map((l) => l.numbers());

  List<List<int>> diffSequences(List<int> numbers) {
    final seqs = [numbers];
    while (seqs.last.any((n) => n != 0)) {
      final source = seqs.last;
      final next = <int>[];
      for (int i = 0; i < source.length - 1; i++) {
        next.add(source[i + 1] - source[i]);
      }
      seqs.add(next);
    }
    return seqs;
  }

  int extrapolateNext(List<int> numbers) =>
      diffSequences(numbers).map((s) => s.last).sum;

  int extrapolatePrevious(List<int> numbers) {
    final seqs = diffSequences(numbers);
    int nextStart = 0;
    for (int i = seqs.length - 2; i >= 0; i--) {
      nextStart = seqs[i].first - nextStart;
    }
    return nextStart;
  }
}
