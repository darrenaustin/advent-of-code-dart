// https://adventofcode.com/2021/day/6

import 'package:advent_of_code_dart/src/util/collection.dart';

import '../../day.dart';

class Day06 extends AdventDay {
  Day06() : super(2021, 6, solution1:349549, solution2: 1589590444365);

  @override
  dynamic part1() {
    return populationAfterDay(80);
  }

  @override
  dynamic part2() {
    return populationAfterDay(256);
  }

  int populationAfterDay(int numDays) {
    final List<int> fish = inputFish();

    // Compute an array where the value at a given index is the number of fish that
    // have index as their internal timer. This way we just keep track of the
    // fish counts for each internal timer setting.
    var fishCounts = List<int>.generate(9, (i) => fish.where((n) => i == n).length);
    var newCounts = List<int>.filled(9, 0);
    for (int day = 0; day < numDays; day++) {
      newCounts[8] = fishCounts[0];
      newCounts[7] = fishCounts[8];
      newCounts[6] = fishCounts[7] + fishCounts[0];
      newCounts[5] = fishCounts[6];
      newCounts[4] = fishCounts[5];
      newCounts[3] = fishCounts[4];
      newCounts[2] = fishCounts[3];
      newCounts[1] = fishCounts[2];
      newCounts[0] = fishCounts[1];
      final tmp = fishCounts;
      fishCounts = newCounts;
      newCounts = tmp;
    }
    return fishCounts.sum;
  }

  List<int> inputFish() {
    return inputData().split(',').map((s) => int.parse(s)).toList();
  }
}
