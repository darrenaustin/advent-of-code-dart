// https://adventofcode.com/2015/day/14

import 'dart:math';

import '../../day.dart';
import '../util/collection.dart';

class Day14 extends AdventDay {
  Day14() : super(2015, 14, solution1: 2640, solution2: 1102);

  @override
  dynamic part1() {
    return inputReindeer().map((Reindeer r) => r.distance(2503)).max();
  }

  @override
  dynamic part2() {
    final List<Reindeer> reindeer = inputReindeer().toList();
    final List<int> points = List<int>.generate(reindeer.length, (int i) => 0);
    for (int seconds = 1; seconds <= 2503; seconds++) {
      int leadDistance = 0;
      List<int> leaderIndices = <int>[];
      for (int r = 0; r < reindeer.length; r++) {
        final int dist = reindeer[r].distance(seconds);
        if (dist > leadDistance) {
          leadDistance = dist;
          leaderIndices = <int>[r];
        } else if (dist == leadDistance) {
          leaderIndices.add(r);
        }
      }
      for (final int r in leaderIndices) {
        points[r]++;
      }
    }
    return points.max();
  }

  final RegExp reindeerRegex = RegExp(r'\S+ can fly (\d+) km/s for (\d+) seconds, but then must rest for (\d+) seconds.');

  Iterable<Reindeer> inputReindeer() {
    return inputDataLines().map((String l) {
      final RegExpMatch parse = reindeerRegex.firstMatch(l)!;
      return Reindeer(int.parse(parse.group(1)!), int.parse(parse.group(2)!), int.parse(parse.group(3)!));
    });
  }
}

class Reindeer {
  Reindeer(this.speed, this.flightTime, this.restTime);

  final int speed;
  final int flightTime;
  final int restTime;

  int distance(int duration) {
    return
      speed * flightTime * (duration ~/ (flightTime + restTime)) +
      speed * min(duration % (flightTime + restTime), flightTime);
  }
}
