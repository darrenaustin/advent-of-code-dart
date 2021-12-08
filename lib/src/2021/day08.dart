// https://adventofcode.com/2021/day/8

import '../../day.dart';

class Day08 extends AdventDay {
  Day08() : super(2021, 8, solution1: 539, solution2: 1084606);

  @override
  dynamic part1() {
    final entries = inputEntries();
    int easyCount = 0;
    for (final entry in entries) {
      final easy = {
        entry.signals.firstWhere((s) => s.length == 2), // 1
        entry.signals.firstWhere((s) => s.length == 4), // 4
        entry.signals.firstWhere((s) => s.length == 3), // 7
        entry.signals.firstWhere((s) => s.length == 7), // 8
      };
      easyCount += (entry.outputs.where((o) => easy.contains(o))).length;
    }
    return easyCount;
  }

  @override
  dynamic part2() {
    final entries = inputEntries();
    var sum = 0;
    for (final entry in entries) {
      final codes = List<String>.filled(10, '');
      codes[1] = entry.signals.firstWhere((s) => s.length == 2);
      codes[4] = entry.signals.firstWhere((s) => s.length == 4);
      codes[7] = entry.signals.firstWhere((s) => s.length == 3);
      codes[8] = entry.signals.firstWhere((s) => s.length == 7);

      var d5 = Set.of(entry.signals.where((s) => s.length == 5));
      codes[3] = d5.firstWhere((s) => codes[1].split('').every((c) => s.contains(c)));
      d5.remove(codes[3]);

      var left4 = codes[4].split('').where((s) => !codes[1].contains(s));
      codes[5] = d5.firstWhere((s) => left4.every((c) => s.contains(c)));
      d5.remove(codes[5]);
      codes[2] = d5.first;

      var d6 = Set.of(entry.signals.where((s) => s.length == 6));
      codes[6] = d6.firstWhere((s) => !codes[1].split('').every((c) => s.contains(c)));
      d6.remove(codes[6]);

      codes[9] = d6.firstWhere((s) => codes[4].split('').every((c) => s.contains(c)));
      d6.remove(codes[9]);
      codes[0] = d6.first;

      final digits = Map.fromEntries(codes.asMap().entries.map((e) => MapEntry(e.value, e.key)));
      sum += int.parse(entry.outputs.map((o) => digits[o]!).join());
    }
    return sum;
  }

  Iterable<Entry> inputEntries() {
    return inputDataLines().map((l) {
      final parts = l.split('|');
      final signals = parts[0].trim().split(' ').map((w) => (w.split('')..sort()).join()).toList();
      final outputs = parts[1].trim().split(' ').map((w) => (w.split('')..sort()).join()).toList();
      return Entry(signals, outputs);
    });
  }
}

class Entry {
  Entry(this.signals, this.outputs);

  final List<String> signals;
  final List<String> outputs;

  @override
  String toString() {
    return '$signals, $outputs';
  }
}
