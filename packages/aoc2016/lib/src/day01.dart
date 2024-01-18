// https://adventofcode.com/2016/day/1

import 'package:aoc/aoc.dart';
import 'package:aoc/util/vec.dart';

main() => Day01().solve();

class Day01 extends AdventDay {
  Day01() : super(2016, 1, name: 'No Time for a Taxicab');

  @override
  dynamic part1(String input) {
    Vec position = Vec.zero;
    Direction direction = Direction.north;
    for (final move in input.split(', ').map(Move.parse)) {
      direction = direction.turn(move.turn);
      position += directions[direction]! * move.length;
    }
    return position.manhattanDistanceTo(Vec.zero).toInt();
  }

  @override
  dynamic part2(String input) {
    Vec position = Vec.zero;
    Direction direction = Direction.north;
    final visited = {position};
    for (final move in input.split(', ').map(Move.parse)) {
      direction = direction.turn(move.turn);
      for (int i = 0; i < move.length; i++) {
        position += directions[direction]!;
        if (visited.contains(position)) {
          return position.manhattanDistanceTo(Vec.zero).toInt();
        }
        visited.add(position);
      }
    }
  }
}

enum Turn { left, right }

enum Direction {
  // Ensure they are in clockwise order.
  north,
  east,
  south,
  west;

  Direction turn(Turn turn) {
    switch (turn) {
      case Turn.left:
        return values[(index - 1) % values.length];
      case Turn.right:
        return values[(index + 1) % values.length];
    }
  }
}

const Map<Direction, Vec> directions = {
  Direction.north: Vec.up,
  Direction.east: Vec.right,
  Direction.south: Vec.down,
  Direction.west: Vec.left,
};

class Move {
  Move(this.turn, this.length);

  final Turn turn;
  final int length;

  static Move parse(String input) => Move(
        input.startsWith('R') ? Turn.right : Turn.left,
        int.parse(input.substring(1)),
      );
}
