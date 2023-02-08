// https://adventofcode.com/2021/day/8

import 'package:aoc/aoc.dart';
import 'package:aoc/util/collection.dart';
import 'package:aoc/util/string.dart';
import 'package:collection/collection.dart';

main() => Day08().solve();

class Day08 extends AdventDay {
  Day08() : super(
    2021, 8, name: 'Seven Segment Search',
    solution1: 539, solution2: 1084606,
  );

  @override
  dynamic part1(String input) => input
    .lines
    .map(Entry.parse)
    .map((entry) {
      final easy = {
        entry.signals.firstWhere((s) => s.length == 2), // 1
        entry.signals.firstWhere((s) => s.length == 4), // 4
        entry.signals.firstWhere((s) => s.length == 3), // 7
        entry.signals.firstWhere((s) => s.length == 7), // 8
      };
      return entry.outputs.quantify((o) => easy.contains(o));
    })
    .sum;

  @override
  dynamic part2(String input) => input
    .lines
    .map(Entry.parse)
    .map((entry) {
      final codes = List<String>.filled(10, '');
      // Determine the ones that only have one choice.
      codes[1] = entry.signals.firstWhere((s) => s.length == 2);
      codes[4] = entry.signals.firstWhere((s) => s.length == 4);
      codes[7] = entry.signals.firstWhere((s) => s.length == 3);
      codes[8] = entry.signals.firstWhere((s) => s.length == 7);

      // Handle the five segment signals.
      final d5 = Set.of(entry.signals.where((s) => s.length == 5));

      // The 3 is the five segment signal with all of the 1 segments
      codes[3] = d5.firstWhere((s) => codes[1].chars.every((c) => s.contains(c)));
      d5.remove(codes[3]);

      // The 5 is the five segment signal with the left half of the 4 in it.
      final left4 = codes[4].chars.where((s) => !codes[1].contains(s));
      codes[5] = d5.firstWhere((s) => left4.every((c) => s.contains(c)));
      d5.remove(codes[5]);

      // The only remaining five segment must be the 2.
      codes[2] = d5.first;

      // Handle the six segment signals.
      final d6 = Set.of(entry.signals.where((s) => s.length == 6));

      // The 6 is the only six segment signal that doesn't have all the 1 segments.
      codes[6] = d6.firstWhere((s) => !codes[1].chars.every((c) => s.contains(c)));
      d6.remove(codes[6]);

      // The 9 contains all of the 4 segments.
      codes[9] = d6.firstWhere((s) => codes[4].chars.every((c) => s.contains(c)));
      d6.remove(codes[9]);

      // The left over six segment must be the 0.
      codes[0] = d6.first;

      final digits = Map.fromEntries(codes.asMap().entries.map((e) => MapEntry(e.value, e.key)));
      return int.parse(entry.outputs.map((o) => digits[o]!).join());
    })
    .sum;
}

class Entry {
  Entry(this.signals, this.outputs);

  static Entry parse(String input) {
    List<String> parseWords(String input) =>
      input.trim().split(' ').map((w) => (w.chars..sort()).join()).toList();

    final parts = input.split('|');
    return Entry(parseWords(parts[0]), parseWords(parts[1]));
  }

  final List<String> signals;
  final List<String> outputs;
}
