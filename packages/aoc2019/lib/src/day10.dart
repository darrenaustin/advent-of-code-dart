// https://adventofcode.com/2019/day/10

import 'dart:math';

import 'package:aoc/aoc.dart';
import 'package:aoc/util/grid.dart';
import 'package:aoc/util/math.dart';
import 'package:aoc/util/string.dart';
import 'package:aoc/util/vec.dart';
import 'package:collection/collection.dart';

main() => Day10().solve();

class Day10 extends AdventDay {
  Day10() : super(2019, 10, name: 'Monitoring Station');

  @override
  dynamic part1(String input) {
    final asteroids = asteroidPositions(parseMap(input));
    return asteroids.map((p) => numAsteroidsDetectedFrom(p, asteroids)).max;
  }

  @override
  dynamic part2(String input) {
    Grid<String> map = parseMap(input);
    Iterable<Vec> asteroids = asteroidPositions(map);
    int numVaporized = 0;
    final station = bestStationLocation(asteroids);
    List<Vec> toVaporize = asteroidsDetectedFrom(station, asteroids).toList();
    while (numVaporized < 199) {
      if (toVaporize.isEmpty) {
        asteroids = asteroidPositions(map);
        toVaporize = asteroidsDetectedFrom(station, asteroids).toList();
      }
      map.setValue(toVaporize.removeAt(0), '.');
      numVaporized++;
    }
    final finalAsteroidToNuke = toVaporize.first;
    return finalAsteroidToNuke.xInt * 100 + finalAsteroidToNuke.yInt;
  }

  Grid<String> parseMap(String input) {
    return Grid<String>.from(
        input.lines.map((l) => l.chars.toList()).toList(), '.');
  }

  int numAsteroidsDetectedFrom(Vec p, Iterable<Vec> asteroids) =>
      asteroids.whereNot((a) => a == p).map((a) => p.angle(a)).toSet().length;

  Iterable<Vec> asteroidsDetectedFrom(Vec p, Iterable<Vec> asteroids) {
    // Convert angle to clockwise with 0 pointing up
    num convertAngle(num a) => (a + 5 * pi / 2) % twoPi;

    return Map.fromEntries(asteroids
            .whereNot((a) => a == p)
            .map((a) => MapEntry(convertAngle(p.angle(a)), a)))
        .entries
        .sortedBy<num>((e) => e.key)
        .map((e) => e.value);
  }

  Vec bestStationLocation(Iterable<Vec> asteroids) {
    int maxDetected = 0;
    Vec maxLocation = Vec.zero;
    for (final asteroid in asteroids) {
      final detected = numAsteroidsDetectedFrom(asteroid, asteroids);
      if (detected > maxDetected) {
        maxDetected = detected;
        maxLocation = asteroid;
      }
    }
    return maxLocation;
  }

  Iterable<Vec> asteroidPositions(Grid<String> map) => map
      .cells()
      .where((c) => c.$2 == '#')
      .map((c) => c.$1); //locationsWhereValue((c) => c == '#');
}
