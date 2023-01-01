// https://adventofcode.com/2018/day/1

import 'package:aoc/aoc.dart';

main() => Day01().solve();

class Day01 extends AdventDay {
  Day01() : super(
    2018, 1, name: '',
  );

  @override
  dynamic part1(String input) => 'Need to migrate';

  @override
  dynamic part2(String input) => 'Need to migrate';
}

// https://adventofcode.com/2018/day/1
// 
// import 'package:aoc/aoc.dart';
// import 'package:collection/collection.dart';
// 
// class Day01 extends AdventDay {
//   Day01() : super(2018, 1, solution1: 585, solution2: 83173);
// 
//   @override
//   dynamic part1() {
//     return inputFrequencies().sum;
//   }
// 
//   @override
//   dynamic part2() {
//     final nums = inputFrequencies();
//     final seen = <int>{};
//     int freq = 0;
// 
//     int index = 0;
//     while (!seen.contains(freq)) {
//       seen.add(freq);
//       freq += nums[index];
//       index = (index + 1) % nums.length;
//     }
//     return freq;
//   }
// 
//   List<int> inputFrequencies() =>
//     inputDataLines().map(int.parse).toList();
// }
// 