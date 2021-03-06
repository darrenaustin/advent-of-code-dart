// https://adventofcode.com/2015/day/24


import '../../day.dart';
import '../util/collection.dart';
import '../util/combinatorics.dart';
import '../util/comparison.dart';

class Day24 extends AdventDay {
  Day24() : super(2015, 24, solution1: 11846773891, solution2: 80393059);

  @override
  dynamic part1() {
    return smallestFirstGroupProduct(inputPackages(), 3);
  }

  @override
  dynamic part2() {
    return smallestFirstGroupProduct(inputPackages(), 4);
  }

  List<int> inputPackages() =>
      inputDataLines().map(int.parse).toList()..sort(numMaxComparator);

  int smallestFirstGroupProduct(List<int> packages, int numGroups) {
    final int weight = packages.sum() ~/ numGroups;
    for (int n = 0; n < packages.length; n++) {
      final Iterable<int> shortestProducts = combinations<int>(packages, n)
          .where((Iterable<int> ps) => ps.sum() == weight)
          .map((Iterable<int> ps) => ps.product());
      if (shortestProducts.isNotEmpty) {
        return shortestProducts.min();
      }
    }
    throw Exception('No solution found');
  }
}
