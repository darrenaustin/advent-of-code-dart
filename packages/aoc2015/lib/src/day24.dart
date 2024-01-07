// https://adventofcode.com/2015/day/24

import 'package:aoc/aoc.dart';
import 'package:aoc/util/collection.dart';
import 'package:aoc/util/combinatorics.dart';
import 'package:aoc/util/comparison.dart';
import 'package:aoc/util/string.dart';
import 'package:collection/collection.dart';

main() => Day24().solve();

class Day24 extends AdventDay {
  Day24() : super(2015, 24, name: 'Hangs in the Balance');

  @override
  dynamic part1(String input) =>
      smallestFirstGroupEntanglement(packages(input), 3);

  @override
  dynamic part2(String input) =>
      smallestFirstGroupEntanglement(packages(input), 4);

  List<int> packages(String input) =>
      input.lines.map(int.parse).toList()..sort(numMaxComparator);

  int smallestFirstGroupEntanglement(List<int> packages, int numGroups) {
    final weight = packages.sum ~/ numGroups;
    for (int n = 0; n < packages.length; n++) {
      final Iterable<int> shortestProducts = combinations<int>(packages, n)
          .where((packageGroup) => packageGroup.sum == weight)
          .map((packageGroup) => packageGroup.product);
      if (shortestProducts.isNotEmpty) {
        return shortestProducts.min;
      }
    }
    throw Exception('No solution found');
  }
}
