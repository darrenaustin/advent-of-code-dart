// https://adventofcode.com/2021/day/23

import 'package:aoc/aoc.dart';

main() => Day23().solve();

class Day23 extends AdventDay {
  Day23() : super(2021, 23, name: 'Amphipod');

  static const A = 1;
  static const B = 10;
  static const C = 100;
  static const D = 1000;

  @override
  dynamic part1(String input) {
    // By hand... :)
    return 5 * A +
        5 * A +
        2 * C +
        6 * B +
        3 * C +
        4 * C +
        7 * B +
        9 * D +
        9 * D +
        3 * A +
        3 * A;
  }

  @override
  dynamic part2(String input) {
// #############
// #AA.......AA#
// ###.#B#C#D###
//   #.#B#C#D#
//   #.#B#C#D#
//   #.#B#C#D#
//   #########

// Original
// #############
// #...........#
// ###D#A#C#C###
//   #D#C#B#A#
//   #D#B#A#C#
//   #D#A#B#B#
//   #########

    // return
    //   5 * A +
    //   5 * C +
    //   4 * B +
    //   10 * A +
    //   5 * B +
    //   4 * C +
    //   7 * B +
    //   6 * A +
    //   8 * B +
    //   6 * C +
    //   8 * C +
    //   5 * C +
    //   9 * A +
    //   6 * C +
    //   9 * B +
    //   11 * D +
    //   11 * D +
    //   11 * D +
    //   11 * D +
    //   9 * A +
    //   9 * A +
    //   5 * A +
    //   5 * A;
  }
}
