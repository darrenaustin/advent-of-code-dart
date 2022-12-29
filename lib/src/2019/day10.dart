// https://adventofcode.com/2019/day/10

import 'dart:math';

import 'package:aoc/aoc.dart';
import 'package:aoc/util/grid2.dart';
import 'package:aoc/util/math.dart';
import 'package:aoc/util/vec2.dart';
import 'package:collection/collection.dart';

class Day10 extends AdventDay {
  Day10() : super(2019, 10, solution1: 309, solution2: 416);

  @override
  dynamic part1() {
    final asteroids = asteroidPositions(inputMap());
    return asteroids.map((p) => numAsteroidsDetectedFrom(p, asteroids)).max;
  }

  @override
  dynamic part2() {
    var map = inputMap();
    var asteroids = asteroidPositions(map);
    var numVaporized = 0;
    final station = bestStationLocation(asteroids);
    var toVaporize = asteroidsDetectedFrom(station, asteroids).toList();
    while (numVaporized < 199) {
      if (toVaporize.isEmpty) {
        asteroids = asteroidPositions(map);
        toVaporize = asteroidsDetectedFrom(station, asteroids).toList();
      }
      map.setCell(toVaporize.removeAt(0), '.');
      numVaporized++;
    }
    final finalAsteroidToNuke = toVaporize.first;
    return finalAsteroidToNuke.xInt * 100 + finalAsteroidToNuke.yInt;
  }

  Grid<String> inputMap() {
    return Grid<String>.from(
      inputDataLines()
        .map((l) => l.split('').toList())
        .toList(),
      '.'
    );
  }

  bool isAsteroid(String cell) => cell == '#';

  int numAsteroidsDetectedFrom(Vec2 p, Iterable<Vec2> asteroids) =>
    asteroids
      .whereNot((a) => a == p)
      .map((a) => p.angle(a))
      .toSet()
      .length;

  Iterable<Vec2> asteroidsDetectedFrom(Vec2 p, Iterable<Vec2> asteroids) {
    // Convert angle to clockwise with 0 pointing up
    double convertAngle(double a) => (a + 5 * pi / 2) % twoPi;

    return Map.fromEntries(
      asteroids
        .whereNot((a) => a == p)
        .map((a) => MapEntry(convertAngle(p.angle(a)), a))
    ).entries.sortedBy<num>((e) => e.key).map((e) => e.value);
  }

  Vec2 bestStationLocation(Iterable<Vec2> asteroids) {
    var maxDetected = 0;
    var maxLocation = Vec2.zero;
    for (final asteroid in asteroids) {
      final detected = numAsteroidsDetectedFrom(asteroid, asteroids);
      if (detected > maxDetected) {
        maxDetected = detected;
        maxLocation = asteroid;
      }
    }
    return maxLocation;
  }

  Iterable<Vec2> asteroidPositions(Grid<String> map) sync* {
    for (var y = 0; y < map.height; y++) {
      for (var x = 0; x < map.width; x++) {
        final p = Vec2.int(x, y);
        if (isAsteroid(map.cell(p))) {
          yield p;
        }
      }
    }
  }
}
