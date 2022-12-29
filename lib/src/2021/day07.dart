// https://adventofcode.com/2021/day/7

import 'package:advent_of_code_dart/src/util/collection.dart';
import 'package:advent_of_code_dart/src/util/math.dart';

import '../../day.dart';

class Day07 extends AdventDay {
  Day07() : super(2021, 7, solution1: 343441, solution2: 98925151);

  @override
  dynamic part1() {
    final List<int> crabs = inputCrabs()..sort();
    return range(crabs.first, crabs.last + 1)
      .map((t) => fuelUsed(crabs, t))
      .min;
  }

  @override
  dynamic part2() {
    final List<int> crabs = inputCrabs()..sort();
    return range(crabs.first, crabs.last + 1)
      .map((t) => acceleratingFuelUsed(crabs, t))
      .min;
  }

  List<int> inputCrabs() {
    return inputData().split(',').map((n) => int.parse(n)).toList();
  }

  int fuelUsed(Iterable<int> crabs, int target) {
    return crabs.map((c) => (target - c).abs().toInt()).sum;
  }

  int acceleratingFuelUsed(Iterable<int> crabs, int target) {
    return crabs.map((c) {
      final dist = (target - c).abs();
      return dist * (dist + 1) ~/ 2;
    }).sum;
  }
}
