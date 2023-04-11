// https://adventofcode.com/2019/day/10

import 'dart:math';

import 'package:aoc/aoc.dart';
import 'package:aoc/util/grid2.dart';
import 'package:aoc/util/math.dart';
import 'package:aoc/util/string.dart';
import 'package:aoc/util/vec.dart';
import 'package:collection/collection.dart';

main() => Day10().solve();

class Day10 extends AdventDay {
  Day10() : super(
    2019, 10, name: 'Monitoring Station',
    solution1: 309, solution2: 416,
  );

  @override
  dynamic part1(String input) {
    final asteroids = asteroidPositions(parseMap(input));
    return asteroids.map((p) => numAsteroidsDetectedFrom(p, asteroids)).max;
  }

  @override
  dynamic part2(String input) {
    Grid<String> map = parseMap(input);
    Iterable<Vec2> asteroids = asteroidPositions(map);
    int numVaporized = 0;
    final station = bestStationLocation(asteroids);
    List<Vec2> toVaporize = asteroidsDetectedFrom(station, asteroids).toList();
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

  Grid<String> parseMap(String input) {
    return Grid<String>.from(
      input
        .lines
        .map((l) => l.chars.toList())
        .toList(),
      '.'
    );
  }

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
    )
      .entries
      .sortedBy<num>((e) => e.key).map((e) => e.value);
  }

  Vec2 bestStationLocation(Iterable<Vec2> asteroids) {
    int maxDetected = 0;
    Vec2 maxLocation = Vec2.zero;
    for (final asteroid in asteroids) {
      final detected = numAsteroidsDetectedFrom(asteroid, asteroids);
      if (detected > maxDetected) {
        maxDetected = detected;
        maxLocation = asteroid;
      }
    }
    return maxLocation;
  }

  Iterable<Vec2> asteroidPositions(Grid<String> map) =>
    map.locationsWhere((c) => c == '#');
}
