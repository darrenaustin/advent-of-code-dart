// https://adventofcode.com/2021/day/2

import 'package:advent_of_code_dart/src/util/vec2.dart';

import '../../day.dart';

class Day02 extends AdventDay {
  Day02() : super(2021, 2, solution1: 1484118, solution2: 1463827010);

  @override
  dynamic part1() {
    final destination = inputDirections().reduce((a, b) => a + b);
    return destination.x * destination.y;
  }

  @override
  dynamic part2() {
    final directions = inputDirections();
    Vector destination = Vector.zero;
    double aim = 0;
    for (final direction in directions) {
      destination += Vector(direction.x, aim * direction.x);
      aim += direction.y;
    }
    return destination.x * destination.y;
  }

  List<Vector> inputDirections() {
    const directionsVector = {
      'forward': Vector(1, 0),
      'up': Vector(0, -1),
      'down': Vector(0, 1),
    };
    final lines = inputDataLines();
    final directions = <Vector>[];
    for (final line in lines) {
      final parts = line.split(' ');
      final direction = parts[0];
      final units = int.parse(parts[1]);
      directions.add(directionsVector[direction]! * units);
    }
    return directions;
  }
}
