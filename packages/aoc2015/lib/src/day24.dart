// https://adventofcode.com/2015/day/24

import 'package:aoc/aoc.dart';

main() => Day24().solve();

class Day24 extends AdventDay {
  Day24() : super(
    2015, 24, name: '',
  );

  @override
  dynamic part1(String input) => 'Need to migrate';

  @override
  dynamic part2(String input) => 'Need to migrate';
}

// https://adventofcode.com/2015/day/24
// 
// 
// import 'package:aoc/aoc.dart';
// import 'package:aoc/util/collection.dart';
// import 'package:aoc/util/combinatorics.dart';
// import 'package:aoc/util/comparison.dart';
// import 'package:collection/collection.dart';
// 
// class Day24 extends AdventDay {
//   Day24() : super(2015, 24, solution1: 11846773891, solution2: 80393059);
// 
//   @override
//   dynamic part1(String input) {
//     return smallestFirstGroupProduct(inputPackages(), 3);
//   }
// 
//   @override
//   dynamic part2(String input) {
//     return smallestFirstGroupProduct(inputPackages(), 4);
//   }
// 
//   List<int> inputPackages() =>
//       inputDataLines().map(int.parse).toList()..sort(numMaxComparator);
// 
//   int smallestFirstGroupProduct(List<int> packages, int numGroups) {
//     final int weight = packages.sum ~/ numGroups;
//     for (int n = 0; n < packages.length; n++) {
//       final Iterable<int> shortestProducts = combinations<int>(packages, n)
//           .where((Iterable<int> ps) => ps.sum == weight)
//           .map((Iterable<int> ps) => ps.product);
//       if (shortestProducts.isNotEmpty) {
//         return shortestProducts.min;
//       }
//     }
//     throw Exception('No solution found');
//   }
// }
// 