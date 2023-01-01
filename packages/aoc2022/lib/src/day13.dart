// https://adventofcode.com/2022/day/13

import 'package:aoc/aoc.dart';

main() => Day13().solve();

class Day13 extends AdventDay {
  Day13() : super(
    2022, 13, name: '',
  );

  @override
  dynamic part1(String input) => 'Need to migrate';

  @override
  dynamic part2(String input) => 'Need to migrate';
}

// https://adventofcode.com/2022/day/13
// 
// import 'dart:convert';
// 
// import 'package:aoc/aoc.dart';
// import 'package:collection/collection.dart';
// 
// class Day13 extends AdventDay {
//   Day13() : super(2022, 13, solution1: 6568, solution2: 19493);
// 
//   @override
//   dynamic part1() {
//     return inputDataLines()
//       .slices(2)
//       .map((pair) => pair.map(parsePacket))
//       .mapIndexed((index, pair) =>
//         comparePackets(pair.first, pair.last) == -1
//           ? index + 1
//           : null)
//       .whereNotNull()
//       .sum;
//   }
// 
//   @override
//   dynamic part2() {
//     final div1 = [[2]];
//     final div2 = [[6]];
//     final packets = inputDataLines()
//       .map(parsePacket)
//       .toList()
//       ..add(div1)
//       ..add(div2)
//       ..sort(comparePackets);
//     return (packets.indexOf(div1) + 1) * (packets.indexOf(div2) + 1);
//   }
// 
//   dynamic parsePacket(String s) => jsonDecode(s);
// 
//   int comparePackets(dynamic p1, dynamic p2) {
//     if (p1 is num && p2 is List) {
//       return comparePackets([p1], p2);
//     }
//     if (p1 is List && p2 is num) {
//       return comparePackets(p1, [p2]);
//     }
//     if (p1 is num && p2 is num) {
//       return p1.compareTo(p2);
//     }
// 
//     // Compare two lists
//     final l1 = p1 as List;
//     final l2 = p2 as List;
//     for (int i = 0; i < l1.length; i++) {
//       if (i >= l2.length) {
//         return 1;
//       }
//       final childCompare = comparePackets(l1[i], l2[i]);
//       if (childCompare != 0) {
//         return childCompare;
//       }
//     }
//     if (l2.length > l1.length) {
//       return -1;
//     }
//     return 0;
//   }
// }
// 