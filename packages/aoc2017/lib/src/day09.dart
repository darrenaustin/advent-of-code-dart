// https://adventofcode.com/2017/day/9

import 'package:aoc/aoc.dart';
import 'package:aoc/util/string.dart';

main() => Day09().solve();

class Day09 extends AdventDay {
  Day09() : super(2017, 9, name: 'Stream Processing');

  @override
  dynamic part1(String input) => scoreStream(input);

  @override
  dynamic part2(String input) => garbageCount(input);

  int scoreStream(String input) {
    final stream = input.chars;
    int depth = 0;
    int score = 0;
    bool inGarbage = false;

    int c = 0;
    while (c < stream.length) {
      if (stream[c] == '!') {
        c += 1;
      } else {
        if (inGarbage) {
          if (stream[c] == '>') {
            inGarbage = false;
          }
        } else {
          if (stream[c] == '{') {
            depth += 1;
            score += depth;
          } else if (stream[c] == '}') {
            depth -= 1;
          } else if (stream[c] == '<') {
            inGarbage = true;
          }
        }
      }
      c += 1;
    }

    return score;
  }

  int garbageCount(String input) {
    final stream = input.chars;
    int count = 0;
    bool inGarbage = false;

    int c = 0;
    while (c < stream.length) {
      if (stream[c] == '!') {
        c += 1;
      } else {
        if (inGarbage) {
          if (stream[c] == '>') {
            inGarbage = false;
          } else {
            count += 1;
          }
        } else if (stream[c] == '<') {
          inGarbage = true;
        }
      }
      c += 1;
    }
    return count;
  }
}
