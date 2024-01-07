// https://adventofcode.com/2022/day/20

import 'package:aoc/aoc.dart';
import 'package:aoc/util/string.dart';
import 'package:collection/collection.dart';

main() => Day20().solve();

class Day20 extends AdventDay {
  Day20() : super(2022, 20, name: 'Grove Positioning System');

  @override
  dynamic part1(String input) => coordinateSum(mix(parseNumbers(input)));

  @override
  dynamic part2(String input) =>
      coordinateSum(mix(parseNumbers(input, 811589153), 10));

  List<IndexedInt> mix(List<IndexedInt> numbers, [int numTimes = 1]) {
    final length = numbers.length;
    final mixed = List<IndexedInt>.from(numbers);
    for (int i = 0; i < numTimes; i++) {
      for (final n in numbers) {
        final pos = mixed.indexOf(n);
        final newPos = (pos + n.value - 1) % (length - 1) + 1;
        mixed.removeAt(pos);
        mixed.insert(newPos, n);
      }
    }
    return mixed;
  }

  int coordinateSum(List<IndexedInt> numbers) {
    final length = numbers.length;
    final zeroIndex = numbers.indexWhere((n) => n.value == 0);
    return [1000, 2000, 3000]
        .map((e) => numbers[(e + zeroIndex) % length].value)
        .sum;
  }

  List<IndexedInt> parseNumbers(String input, [int decryptKey = 1]) {
    return input.lines
        .map(int.parse)
        .mapIndexed((i, value) => IndexedInt(value * decryptKey, i))
        .toList();
  }
}

class IndexedInt {
  IndexedInt(this.value, this.index);

  final int value;
  final int index;

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is IndexedInt && other.value == value && other.index == index;
  }

  @override
  int get hashCode => value.hashCode ^ index.hashCode;
}
