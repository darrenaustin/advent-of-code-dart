// https://adventofcode.com/2016/day/6

import 'package:aoc/aoc.dart';

main() => Day06().solve();

class Day06 extends AdventDay {
  Day06() : super(
    2016, 6, name: '',
  );

  @override
  dynamic part1(String input) => 'Need to migrate';

  @override
  dynamic part2(String input) => 'Need to migrate';
}

// https://adventofcode.com/2016/day/6
// 
// import 'package:aoc/aoc.dart';
// import 'package:aoc/util/comparison.dart';
// 
// class Day06 extends AdventDay {
//   Day06() : super(2016, 6, solution1: 'kjxfwkdh', solution2: 'xrwcsnps');
// 
//   @override
//   dynamic part1() {
//     return errorCorrectedMessage(inputRecordedMessages(), numMaxComparator);
//   }
// 
//   @override
//   dynamic part2() {
//     return errorCorrectedMessage(inputRecordedMessages(), numMinComparator);
//   }
// 
//   Iterable<List<String>> inputRecordedMessages() => inputDataLines().map((s) => s.split('').toList());
// 
//   String errorCorrectedMessage(Iterable<List<String>> recorded, Comparator<int> freqCompare) {
//     final StringBuffer message = StringBuffer();
//     for (int i = 0; i < recorded.first.length; i++) {
//       final Map<String, int> charFrequency = <String, int>{};
//       for (var c in recorded) {
//         charFrequency[c[i]] = (charFrequency[c[i]] ?? 0) + 1;
//       }
//       final List<String> sortedChars = charFrequency.keys.toList()
//         ..sort((k1, k2) => freqCompare(charFrequency[k1]!, charFrequency[k2]!));
//       message.write(sortedChars.first);
//     }
//     return message.toString();
//   }
// 
// }
// 