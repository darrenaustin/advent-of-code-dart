// https://adventofcode.com/2021/day/1

import 'package:aoc/aoc.dart';

main() => Day01().solve();

class Day01 extends AdventDay {
  Day01() : super(
    2021, 1, name: '',
  );

  @override
  dynamic part1(String input) => 'Need to migrate';

  @override
  dynamic part2(String input) => 'Need to migrate';
}

// https://adventofcode.com/2021/day/1
// 
// import 'package:aoc/aoc.dart';
// 
// class Day01 extends AdventDay {
//   Day01() : super(2021, 1, solution1: 1791, solution2: 1822);
// 
//   @override
//   dynamic part1() {
//     return increases(inputMeasurements());
//   }
// 
//   @override
//   dynamic part2() {
//     final measurements = inputMeasurements();
//     List<int> sums = [];
//     for (int i = 0; i < (measurements.length - 2); i++) {
//       sums.add(measurements[i] + measurements[i + 1] + measurements[i + 2]);
//     }
//     return increases(sums);
//   }
// 
//   List<int> inputMeasurements() {
//     return inputDataLines().map((s) => int.parse(s)).toList();
//   }
// 
//   int increases(Iterable<int> measurements) {
//     int? previous;
//     int increases = 0;
//     for (final int measurement in measurements) {
//       if (previous != null && measurement > previous) {
//         increases++;
//       }
//       previous = measurement;
//     }
//     return increases;
//   }
// }
// 