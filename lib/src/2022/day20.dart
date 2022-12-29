// https://adventofcode.com/2022/day/20

import 'package:aoc/aoc.dart';
import 'package:collection/collection.dart';

class Day20 extends AdventDay {
  Day20() : super(2022, 20, solution1: 11037, solution2: 3033720253914);

  @override
  dynamic part1() => coordinateSum(mix(inputNumbers()));

  @override
  dynamic part2() => coordinateSum(mix(inputNumbers(811589153), 10));

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

  List<IndexedInt> inputNumbers([int decryptKey = 1]) {
    return inputDataLines()
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
    return other is IndexedInt
        && other.value == value
        && other.index == index;
  }

  @override
  int get hashCode => value.hashCode ^ index.hashCode;
}
