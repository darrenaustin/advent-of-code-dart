// https://adventofcode.com/2015/day/17

import 'package:aoc/aoc.dart';

main() => Day17().solve();

class Day17 extends AdventDay {
  Day17() : super(
    2015, 17, name: '',
  );

  @override
  dynamic part1(String input) => 'Need to migrate';

  @override
  dynamic part2(String input) => 'Need to migrate';
}

// https://adventofcode.com/2015/day/17
// 
// import 'package:aoc/aoc.dart';
// import 'package:collection/collection.dart';
// 
// class Day17 extends AdventDay {
//   Day17() : super(2015, 17, solution1: 1304, solution2: 18);
// 
//   @override
//   dynamic part1(String input) {
//     return sumTo(inputContainers(), 150).length;
//   }
// 
//   @override
//   dynamic part2(String input) {
//     final Iterable<Iterable<int>> allCombinations = sumTo(inputContainers(), 150);
//     final int minContainersUsed = allCombinations.map((Iterable<int> c) => c.length).min;
//     return allCombinations.where((Iterable<int> c) => c.length == minContainersUsed).length;
//   }
// 
//   Iterable<int> inputContainers() {
//     return inputDataLines().map(int.parse).toList()..sort();
//   }
// 
//   Iterable<Iterable<int>> sumTo(Iterable<int> sortedValues, int sum) sync* {
//     if (sum == 0) {
//       yield <int>[];
//     } else if (sortedValues.isNotEmpty) {
//       final int n = sortedValues.first;
//       final Iterable<int> rest = sortedValues.skip(1);
//       if (n <= sum) {
//         for (final Iterable<int> s in sumTo(rest, sum - n)) {
//           yield <int>[n, ...s];
//         }
//       }
//       for (final Iterable<int> s in sumTo(rest, sum)) {
//         yield s;
//       }
//     }
//   }
// }
// 