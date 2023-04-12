// https://adventofcode.com/2021/day/7

import 'package:aoc/aoc.dart';
import 'package:aoc/util/collection.dart';
import 'package:collection/collection.dart';

main() => Day07().solve();

class Day07 extends AdventDay {
  Day07() : super(2021, 7, name: 'The Treachery of Whales');

  @override
  dynamic part1(String input) {
    final List<int> crabs = parseCrabs(input);
    return range(crabs.min, crabs.max + 1)
      .map((t) => fuelUsed(crabs, t))
      .min;
  }

  @override
  dynamic part2(String input) {
    final crabs = parseCrabs(input);
    return range(crabs.min, crabs.max + 1)
      .map((t) => acceleratingFuelUsed(crabs, t))
      .min;
  }

  static List<int> parseCrabs(String input) =>
    input.split(',').map(int.parse).toList();

  static int fuelUsed(Iterable<int> crabs, int target) =>
    crabs.map((c) => (target - c).abs()).sum;

  static int acceleratingFuelUsed(Iterable<int> crabs, int target) => crabs
    .map((c) {
      final dist = (target - c).abs();
      return dist * (dist + 1) ~/ 2;
    })
    .sum;
}
