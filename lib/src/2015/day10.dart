// https://adventofcode.com/2015/day/10

import '../../day.dart';

class Day10 extends AdventDay {
  Day10() : super(2015, 10, solution1: 329356, solution2: 4666278);

  @override
  dynamic part1() {
    return lookAndSay('3113322113', 40).length;
  }

  @override
  dynamic part2() {
    return lookAndSay('3113322113', 50).length;
  }

  String lookAndSay(String text, int iterations) {
    for (int i = 0; i < iterations; i++) {
      text = groupsOf(text).join();
    }
    return text;
  }

  Iterable<String> groupsOf(String s) sync* {
    if (s.isNotEmpty) {
      String chr = s[0];
      int start = 0;
      int index = 1;
      while (index < s.length) {
        if (s[index] != chr) {
          yield (index - start).toString(); // count
          yield chr; // character
          chr = s[index];
          start = index;
        }
        index++;
      }
      yield (index - start).toString();
      yield chr;
    }
  }
}
