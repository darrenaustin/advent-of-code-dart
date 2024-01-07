// https://adventofcode.com/2021/day/6

import 'package:aoc/aoc.dart';
import 'package:aoc/util/collection.dart';
import 'package:aoc/util/range.dart';
import 'package:collection/collection.dart';

main() => Day06().solve();

class Day06 extends AdventDay {
  Day06() : super(2021, 6, name: 'Lanternfish');

  @override
  dynamic part1(String input) => populationAfterDay(input, 80);

  @override
  dynamic part2(String input) => populationAfterDay(input, 256);

  int populationAfterDay(String input, int numDays) {
    final List<int> fish = parseFish(input);

    // Compute an array where the value at a given index is the number
    // of fish that have index as their internal timer. This way we
    // just keep track of the fish counts for each internal timer setting.
    List<int> fishCounts =
        List.generate(9, (i) => fish.quantify((n) => i == n));
    List<int> newCounts = List.filled(9, 0);
    for (final _ in range(numDays)) {
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

  List<int> parseFish(String input) => input.split(',').map(int.parse).toList();
}
