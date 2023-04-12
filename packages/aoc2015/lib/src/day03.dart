// https://adventofcode.com/2015/day/3

import 'package:aoc/aoc.dart';
import 'package:aoc/util/string.dart';
import 'package:aoc/util/vec.dart';

main() => Day03().solve();

class Day03 extends AdventDay {
  Day03() : super(2015, 3, name: 'Perfectly Spherical Houses in a Vacuum');

  @override
  dynamic part1(String input) {
    Vec2 current = Vec2.zero;
    final housesVisited = <Vec2>{ current };
    for (final dir in input.chars.map((c) => _directionOffset[c]!)) {
      current += dir;
      housesVisited.add(current);
    }
    return housesVisited.length;
  }

  @override
  dynamic part2(String input) {
    Vec2 santa = Vec2.zero;
    Vec2 robotSanta = Vec2.zero;
    bool santaTurn = true;
    final housesVisited = <Vec2>{ santa };

    for (final dir in input.chars.map((c) => _directionOffset[c]!)) {
      if (santaTurn) {
        santa += dir;
        housesVisited.add(santa);
      } else {
        robotSanta += dir;
        housesVisited.add(robotSanta);
      }
      santaTurn = !santaTurn;
    }
    return housesVisited.length;
  }

  static const _directionOffset = <String, Vec2>{
    '^': Vec2.up,
    '>': Vec2.right,
    'v': Vec2.down,
    '<': Vec2.left,
  };
}
