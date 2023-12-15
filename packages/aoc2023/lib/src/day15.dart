// https://adventofcode.com/2023/day/15

import 'package:aoc/aoc.dart';
import 'package:collection/collection.dart';

main() => Day15().solve();

class Day15 extends AdventDay {
  Day15() : super(2023, 15, name: 'Lens Library');

  @override
  dynamic part1(String input) => input.split(',').map(hash).sum;

  @override
  dynamic part2(String input) {
    final boxes = List.generate(256, (_) => <(String, int)>[]);
    final steps = input.split(',');
    for (final s in steps) {
      final parts = RegExp(r'([^\d-=]+)(-|=)([\d]*)').firstMatch(s)!;
      final label = parts.group(1)!;
      final box = hash(label);
      final op = parts.group(2);
      final index = boxes[box].indexWhere((e) => e.$1 == label);
      if (op == '-') {
        if (index != -1) {
          boxes[box].removeAt(index);
        }
      } else {
        final length = int.parse(parts.group(3)!);
        if (index == -1) {
          boxes[box].add((label, length));
        } else {
          boxes[box][index] = (label, length);
        }
      }
    }

    var focus = 0;
    for (int i = 0; i < boxes.length; i++) {
      for (int j = 0; j < boxes[i].length; j++) {
        final (_, focal) = boxes[i][j];
        focus += (i + 1) * (j + 1) * focal;
      }
    }
    return focus;
  }

  int hash(String s) {
    var value = 0;
    for (final c in s.codeUnits) {
      value = (value + c) * 17 % 256;
    }
    return value;
  }
}
