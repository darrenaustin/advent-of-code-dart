// https://adventofcode.com/2016/day/15

import 'package:aoc/aoc.dart';
import 'package:aoc/util/string.dart';

main() => Day15().solve();

class Day15 extends AdventDay {
  Day15() : super(2016, 15, name: 'Timing is Everything');

  @override
  dynamic part1(String input) => buttonPressTime(parseDiscs(input));

  @override
  dynamic part2(String input) {
    final discs = parseDiscs(input).toList();
    discs.add(Disc(discs.length + 1, 11, 0));
    return buttonPressTime(discs);
  }

  Iterable<Disc> parseDiscs(String input) => input.lines.map((line) {
        final match =
            RegExp(r'Disc \#(\d+) has (\d+) positions; .* at position (\d+)')
                .firstMatch(line);
        if (match == null) {
          throw Exception('Unable to parse disc info: $line');
        }
        final depth = int.parse(match.group(1)!);
        return Disc(
            depth, int.parse(match.group(2)!), int.parse(match.group(3)!));
      });

  int buttonPressTime(Iterable<Disc> discs) {
    int time = 0;
    while (!discs.every((d) => d.openFor(time))) {
      time++;
    }
    return time;
  }
}

class Disc {
  Disc(this.depth, this.numPositions, this.offset);

  final int depth;
  final int numPositions;
  final int offset;

  bool openFor(int dropTime) => (dropTime + depth + offset) % numPositions == 0;
}
