// https://adventofcode.com/2016/day/16

import 'package:aoc/aoc.dart';

main() => Day16().solve();

class Day16 extends AdventDay {
  Day16() : super(2016, 16, name: 'Dragon Checksum');

  @override
  dynamic part1(String input, [int length = 272]) => checksum(fill(input, length));

  @override
  dynamic part2(String input, [int length = 35651584]) => checksum(fill(input, length));

  String next(String a) {
    StringBuffer buf = StringBuffer(a);
    buf.write('0');
    for (int i = a.length -1; i >= 0; i--) {
      buf.write(a[i] == '0' ? '1' : '0');
    }
    return buf.toString();
  }

  String checksum(String text) {
    final StringBuffer buf = StringBuffer();
    do {
      buf.clear();
      for (int i = 0; i < text.length; i += 2) {
        buf.write(text[i] == text[i + 1] ? '1' : '0');
      }
      text = buf.toString();
    } while (text.length.isEven);
    return text;
  }

  String fill(String text, int length) {
    while (text.length < length) {
      text = next(text);
    }
    return text.substring(0, length);
  }
}
