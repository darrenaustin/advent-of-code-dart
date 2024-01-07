// https://adventofcode.com/2015/day/14

import 'dart:math';

import 'package:aoc/aoc.dart';
import 'package:aoc/util/collection.dart';
import 'package:aoc/util/string.dart';
import 'package:collection/collection.dart';

main() => Day14().solve();

class Day14 extends AdventDay {
  Day14() : super(2015, 14, name: 'Reindeer Olympics');

  @override
  dynamic part1(String input) =>
      input.lines.map(Reindeer.parse).map((r) => r.distance(2503)).max;

  @override
  dynamic part2(String input) =>
      winningScore(input.lines.map(Reindeer.parse).toList(), 2503);

  static int winningScore(List<Reindeer> reindeer, int seconds) {
    final points = List<int>.generate(reindeer.length, (_) => 0);
    for (final seconds in range(1, seconds + 1)) {
      int leadDistance = 0;
      final leadersIndices = [];
      for (final r in range(reindeer.length)) {
        final dist = reindeer[r].distance(seconds);
        if (dist > leadDistance) {
          leadDistance = dist;
          leadersIndices.clear();
          leadersIndices.add(r);
        } else if (dist == leadDistance) {
          leadersIndices.add(r);
        }
      }
      for (final r in leadersIndices) {
        points[r]++;
      }
    }
    return points.max;
  }
}

class Reindeer {
  Reindeer(this.speed, this.flightTime, this.restTime);

  final int speed;
  final int flightTime;
  final int restTime;

  int distance(int duration) {
    return speed * flightTime * (duration ~/ (flightTime + restTime)) +
        speed * min(duration % (flightTime + restTime), flightTime);
  }

  static final RegExp _reindeerPattern = RegExp(
      r'\S+ can fly (\d+) km/s for (\d+) seconds, but then must rest for (\d+) seconds.');

  static Reindeer parse(String input) {
    final match = _reindeerPattern.firstMatch(input)!;
    return Reindeer(int.parse(match.group(1)!), int.parse(match.group(2)!),
        int.parse(match.group(3)!));
  }
}
