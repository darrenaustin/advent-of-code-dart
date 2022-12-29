// https://adventofcode.com/2015/day/25

import 'package:aoc/aoc.dart';

class Day25 extends AdventDay {
  Day25() : super(2015, 25, solution1: 2650453, solution2: '🎄 Got em all! 🎉');

  @override
  dynamic part1() {
    final String input = inputData();
    return codeAt(20151125, inputRow(input), inputColumn(input));
  }

  @override
  dynamic part2() => '🎄 Got em all! 🎉';

  int inputRow(String input) {
    final RegExpMatch match = RegExp(r'\brow (\d+)').firstMatch(input)!;
    return int.parse(match.group(1)!);
  }

  int inputColumn(String input) {
    final RegExpMatch match = RegExp(r'\bcolumn (\d+)').firstMatch(input)!;
    return int.parse(match.group(1)!);
  }

  int nextCode(int previousCode) => previousCode * 252533 % 33554393;

  // Total brute force for this. I am sure there is a way to calculate this
  // directly from the row and col, but this works and isn't too slow.
  int codeAt(int startingCode, int row, int col) {
    int i = startingCode;
    int r = 1;
    int c = 1;
    while (!(row == r && col == c)) {
      if (r == 1) {
        r = c + 1;
        c = 1;
      } else {
        c++;
        r--;
      }
      i = nextCode(i);
    }
    return i;
  }
}
