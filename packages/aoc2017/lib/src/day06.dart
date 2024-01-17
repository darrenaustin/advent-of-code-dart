// https://adventofcode.com/2017/day/6

import 'package:aoc/aoc.dart';
import 'package:aoc/util/collection.dart';
import 'package:aoc/util/string.dart';
import 'package:collection/collection.dart';

main() => Day06().solve();

class Day06 extends AdventDay {
  Day06() : super(2017, 6, name: 'Memory Reallocation');

  @override
  dynamic part1(String input) {
    var blocks = Blocks(input);
    final seen = <Blocks>{};
    while (seen.add(blocks)) {
      blocks = blocks.redistribute();
    }
    return seen.length;
  }

  @override
  dynamic part2(String input) {
    var blocks = Blocks(input);
    final seen = <Blocks>{};
    final blockList = <Blocks>[];
    while (seen.add(blocks)) {
      blockList.add(blocks);
      blocks = blocks.redistribute();
    }
    return blockList.length - blockList.indexOf(blocks);
  }
}

class Blocks {
  Blocks._(this.memory);

  factory Blocks(String input) {
    return Blocks._(input.numbers());
  }

  final List<int> memory;

  Blocks redistribute() {
    final result = [...memory];
    final biggestBlock = result.maxIndex();
    int blocks = result[biggestBlock];
    result[biggestBlock] = 0;
    for (int i = 1; i <= blocks; i++) {
      result[(biggestBlock + i) % result.length]++;
    }
    return Blocks._(result);
  }

  @override
  bool operator ==(covariant Blocks other) {
    if (identical(this, other)) return true;

    return const DeepCollectionEquality().equals(other.memory, memory);
  }

  @override
  int get hashCode => const DeepCollectionEquality().hash(memory);
}
