// https://adventofcode.com/2019/day/4

import 'package:aoc/aoc.dart';

main() => Day04().solve();

class Day04 extends AdventDay {
  Day04() : super(
    2019, 4, name: '',
  );

  @override
  dynamic part1(String input) => 'Need to migrate';

  @override
  dynamic part2(String input) => 'Need to migrate';
}

// https://adventofcode.com/2019/day/4
// 
// import 'package:aoc/aoc.dart';
// import 'package:aoc/util/collection.dart';
// import 'package:aoc/util/comparison.dart';
// 
// class Day04 extends AdventDay {
//   Day04() : super(2019, 4, solution1: 530, solution2: 324);
// 
//   @override
//   dynamic part1() {
//     bool possiblePassword(int n) {
//       final digits = n.toString().split('');
//       return
//         digits.slicesWhere(isNotEqual).any((l) => l.length > 1) &&
//         digits.slicesWhere(isGreaterThan).length == 1;
//     }
// 
//     return range(357253, 892942).where(possiblePassword).length;
//   }
// 
//   @override
//   dynamic part2() {
//     bool possiblePassword(int n) {
//       final digits = n.toString().split('');
//       return
//         digits.slicesWhere(isNotEqual).any((l) => l.length == 2) &&
//         digits.slicesWhere(isGreaterThan).length == 1;
//     }
// 
//     return range(357253, 892942).where(possiblePassword).length;
//   }
// }
// 