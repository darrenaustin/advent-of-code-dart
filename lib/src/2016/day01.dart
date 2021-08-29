// https://adventofcode.com/2016/day/1

import '../../day.dart';
import '../util/vec2.dart';

class Day01 extends AdventDay {
  Day01() : super(2016, 1, solution1: 243, solution2: 142);

  @override
  dynamic part1() {
    Vector position = Vector.zero;
    Direction direction = Direction.north;
    for (Move move in inputMoves()) {
      direction = directionAfterTurn(direction, move.turn);
      position += directions[direction]! * move.length;
    }
    return position.manhattanDistanceTo(Vector.zero).toInt();
  }

  @override
  dynamic part2() {
    Vector position = Vector.zero;
    Direction direction = Direction.north;
    Set<Vector> visited = {position};
    for (Move move in inputMoves()) {
      direction = directionAfterTurn(direction, move.turn);
      for (int i = 0; i < move.length; i++) {
        position += directions[direction]!;
        if (visited.contains(position)) {
          return position.manhattanDistanceTo(Vector.zero).toInt();
        }
        visited.add(position);
      }
    }
  }

  Iterable<Move> inputMoves() {
    return inputData().split(', ').map((String s) {
      return Move(s.startsWith('R') ? Turn.right : Turn.left, int.parse(s.substring(1)));
    });
  }

  Direction directionAfterTurn(Direction direction, Turn turn) {
    switch (turn) {
      case Turn.left: return Direction.values[(direction.index - 1) % Direction.values.length];
      case Turn.right: return Direction.values[(direction.index + 1) % Direction.values.length];
    }
  }
}

enum Turn { left, right }
enum Direction { north, east, south, west }

const Map<Direction, Vector> directions = {
  Direction.north: Vector( 0, -1),
  Direction.east:  Vector( 1,  0),
  Direction.south: Vector( 0,  1),
  Direction.west:  Vector(-1,  0),
};

class Move {
  Move(this.turn, this.length);

  final Turn turn;
  final int length;
}
