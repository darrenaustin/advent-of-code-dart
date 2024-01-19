// https://adventofcode.com/2023/day/2

import 'dart:math';

import 'package:aoc/aoc.dart';
import 'package:aoc/util/collection.dart';
import 'package:aoc/util/string.dart';
import 'package:collection/collection.dart';

main() => Day02().solve();

class Day02 extends AdventDay {
  Day02() : super(2023, 2, name: 'Cube Conundrum');

  @override
  dynamic part1(String input) => input.lines
      .map(parseGame)
      .where((g) => possibleWith(g, {"red": 12, "green": 13, "blue": 14}))
      .map((g) => g.id)
      .sum;

  @override
  dynamic part2(String input) =>
      input.lines.map(parseGame).map((g) => minOf({}, g).values.product).sum;

  Game parseGame(String input) {
    final match = RegExp(r'Game ([\d]+): (.*)').firstMatch(input)!;
    final id = int.parse(match.group(1)!);
    final pulls = match.group(2)!.split('; ').map(parsePull);
    return Game(id, pulls);
  }

  Map<String, int> parsePull(String input) {
    final pull = <String, int>{};
    for (final entry in input.split(', ')) {
      final parts = entry.split(' ');
      final name = parts.last;
      final number = int.parse(parts.first);
      pull[name] = number;
    }
    return pull;
  }

  Map<String, int> maxCubesNeeded(Iterable<Map<String, int>> pulls) {
    final maxCubes = <String, int>{};
    for (final pull in pulls) {
      for (final MapEntry(key: name, value: count) in pull.entries) {
        maxCubes[name] = max((maxCubes[name] ?? 0), count);
      }
    }
    return maxCubes;
  }

  bool possibleWith(Game game, maxBagCubes) {
    final gameMaxCubes = maxCubesNeeded(game.pulls);
    for (final MapEntry(key: name, value: count) in gameMaxCubes.entries) {
      if (count > maxBagCubes[name]) {
        return false;
      }
    }
    return true;
  }

  Map<String, int> minOf(Map<String, int> cubes, Game game) {
    final maxNeededForGame = maxCubesNeeded(game.pulls);
    final minCubes = Map<String, int>.from(cubes);
    for (final MapEntry(key: name, value: count) in maxNeededForGame.entries) {
      minCubes[name] = max((minCubes[name] ?? 0), count);
    }
    return minCubes;
  }
}

class Game {
  Game(this.id, this.pulls);

  final int id;
  final Iterable<Map<String, int>> pulls;
}
