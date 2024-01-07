// https://adventofcode.com/2016/day/18

import 'package:aoc/aoc.dart';

main() => Day18().solve();

class Day18 extends AdventDay {
  Day18() : super(2016, 18, name: 'Like a Rogue');

  @override
  dynamic part1(String input, [int rows = 40]) => safeTiles(input, rows);

  @override
  dynamic part2(String input, [int rows = 400000]) => safeTiles(input, rows);

  int safeTiles(String text, int rows) {
    final safeRegExp = RegExp(r'\.');
    int safeTiles = safeRegExp.allMatches(text).length;
    for (int row = 1; row < rows; row++) {
      text = nextRow(text);
      safeTiles += safeRegExp.allMatches(text).length;
    }
    return safeTiles;
  }

  String nextRow(String row) {
    StringBuffer buf = StringBuffer();
    for (int i = 0; i < row.length; i++) {
      final left = i == 0 ? '.' : row[i - 1];
      final center = row[i];
      final right = i == row.length - 1 ? '.' : row[i + 1];
      final trap = (left == '^' && center == '^' && right == '.') ||
          (left == '.' && center == '^' && right == '^') ||
          (left == '^' && center == '.' && right == '.') ||
          (left == '.' && center == '.' && right == '^');
      buf.write(trap ? '^' : '.');
    }
    return buf.toString();
  }
}
