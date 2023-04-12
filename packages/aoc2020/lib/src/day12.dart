// https://adventofcode.com/2020/day/12

import 'dart:math';

import 'package:aoc/aoc.dart';
import 'package:aoc/util/string.dart';
import 'package:aoc/util/vec.dart';

main() => Day12().solve();

class Day12 extends AdventDay {
  Day12() : super(2020, 12, name: 'Rain Risk');

  @override
  dynamic part1(String input) {
    final ship = Ship();
    ship.navigate(parseInstructions(input));
    return ship.manhattanDistance;
  }

  @override
  dynamic part2(String input) {
    final ship = WaypointShip();
    ship.navigate(parseInstructions(input));
    return ship.manhattanDistance;
  }

  List<NavInstruction> parseInstructions(String input) => input
      .lines
      .map(NavInstruction.from)
      .toList();
}

// Ensure the order is in clockwise so the values can be used for rotation
enum Direction { north, east, south, west }

enum NavAction { north, south, east, west, left, right, forward }

class NavInstruction {

  NavInstruction(this.action, this.value);

  static final _actions = <String, NavAction>{
    'N': NavAction.north,
    'S': NavAction.south,
    'E': NavAction.east,
    'W': NavAction.west,
    'L': NavAction.left,
    'R': NavAction.right,
    'F': NavAction.forward,
  };

  static NavInstruction from(String text) =>
    NavInstruction(_actions[text.substring(0, 1)]!, int.parse(text.substring(1)));

  final NavAction action;
  final int value;

  @override
  String toString() =>
    '${action.toString().split('.').last.substring(0, 1)} ${value.toString()}';
}

class Ship {
  Ship() : position = Vec2.zero, direction = Direction.east;

  Vec2 position;
  Direction direction;

  double get manhattanDistance => position.manhattanDistanceTo(Vec2.zero);

  static final _directionOffsets = <Direction, Vec2>{
    Direction.north: Vec2.down,
    Direction.south: Vec2.up,
    Direction.east: Vec2.right,
    Direction.west: Vec2.left,
  };

  void navigate(Iterable<NavInstruction> instructions) {
    instructions.forEach(followInstruction);
  }

  void followInstruction(NavInstruction instruction) {
    switch (instruction.action) {
      case NavAction.north:
        move(Direction.north, instruction.value);
        break;
      case NavAction.south:
        move(Direction.south, instruction.value);
        break;
      case NavAction.east:
        move(Direction.east, instruction.value);
        break;
      case NavAction.west:
        move(Direction.west, instruction.value);
        break;
      case NavAction.left:
        rotate(instruction.value, false);
        break;
      case NavAction.right:
        rotate(instruction.value);
        break;
      case NavAction.forward:
        forward(instruction.value);
        break;
    }
  }

  void move(Direction dir, int distance) {
    position += _directionOffsets[dir]! * distance;
  }

  void forward(int distance) {
    move(direction, distance);
  }

  void rotate(int angle, [bool clockwise = true]) {
    assert(angle % 90 == 0);
    final rotations = (clockwise ? angle : -angle) ~/ 90;
    final directions = Direction.values;
    direction = directions[(directions.indexOf(direction) + rotations) % directions.length];
  }
}

class WaypointShip extends Ship {

  WaypointShip() : waypoint = Vec2(10, 1), super();

  Vec2 waypoint;

  @override
  void move(Direction dir, int distance) {
    waypoint += Ship._directionOffsets[dir]! * distance;
  }

  @override
  void forward(int distance) {
    position += waypoint * distance;
  }

  @override
  void rotate(int angle, [bool clockwise = true]) {
    final rotation = (clockwise ? -angle : angle) * pi / 180;
    final newAngle = atan2(waypoint.y, waypoint.x) + rotation;
    final magnitude = waypoint.magnitude;
    final newX = cos(newAngle) * magnitude;
    final newY = sin(newAngle) * magnitude;
    waypoint = Vec2.int(newX.round(), newY.round());
  }
}
