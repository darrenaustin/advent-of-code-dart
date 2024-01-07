// https://adventofcode.com/2017/day/1

import 'package:aoc/aoc.dart';
import 'package:collection/collection.dart';

main() => Day01().solve();

class Day01 extends AdventDay {
  Day01() : super(2017, 1, name: 'Inverse Captcha');

  @override
  dynamic part1(String input) {
    final captcha = input.split('').map(int.parse).toList();
    final length = captcha.length;
    return captcha
        .whereIndexed((i, d) => captcha[i] == captcha[(i + 1) % length])
        .sum;
  }

  @override
  dynamic part2(String input) {
    final captcha = input.split('').map(int.parse).toList();
    final length = captcha.length;
    final halfway = length ~/ 2;
    return captcha
        .whereIndexed((i, d) => captcha[i] == captcha[(i + halfway) % length])
        .sum;
  }
}
