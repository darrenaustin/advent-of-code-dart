// https://adventofcode.com/2022/day/19

import 'dart:math';

import 'package:aoc/aoc.dart';
import 'package:aoc/util/collection.dart';
import 'package:aoc/util/string.dart';
import 'package:collection/collection.dart';

main() => Day19().solve();

class Day19 extends AdventDay {
  Day19() : super(2022, 19, name: 'Not Enough Minerals');

  @override
  dynamic part1(String input) =>
      parseBlueprints(input).map((bp) => maxGeodes(bp, 24) * bp.id).sum;

  @override
  dynamic part2(String input) =>
      parseBlueprints(input).take(3).map((bp) => maxGeodes(bp, 32)).product;

  int maxGeodes(Blueprint bp, int time) {
    // Highest ore cost for a robot.
    final int maxOreCost =
        [bp.oreCost, bp.clayOreCost, bp.obsidianOreCost, bp.geodeOreCost].max;

    // Optimal number of geodes for a given time left.
    final optimalGeodes = range(time + 1).map((t) => (t - 1) * t / 2).toList();

    int maxGeodes = 0;

    void search(Factory f, Robot buyRobot) {
      // If it doesn't make sense to buy the given robot, or we can't
      // produce enough geodes from here greater than the max we have seen,
      // then this config will not lead to a maximum.
      if (buyRobot == Robot.ore && f.oreRobots >= maxOreCost ||
          buyRobot == Robot.clay && f.clayRobots >= bp.obsidianClayCost ||
          buyRobot == Robot.obsidian &&
              f.obsidianRobots >= bp.geodeObsidianCost ||
          f.geode + f.geodeRobots * f.timeLeft + optimalGeodes[f.timeLeft] <=
              maxGeodes) {
        return;
      }

      while (f.timeLeft > 0) {
        if (buyRobot == Robot.ore && f.ore >= bp.oreCost) {
          for (final r in Robot.values) {
            search(f.nextDay(oreRobots: 1, ore: -bp.oreCost), r);
          }
          return;
        } else if (buyRobot == Robot.clay && f.ore >= bp.clayOreCost) {
          for (final r in Robot.values) {
            search(f.nextDay(clayRobots: 1, ore: -bp.clayOreCost), r);
          }
          return;
        } else if (buyRobot == Robot.obsidian &&
            f.ore >= bp.obsidianOreCost &&
            f.clay >= bp.obsidianClayCost) {
          for (final r in Robot.values) {
            search(
                f.nextDay(
                    obsidianRobots: 1,
                    ore: -bp.obsidianOreCost,
                    clay: -bp.obsidianClayCost),
                r);
          }
          return;
        } else if (buyRobot == Robot.geode &&
            f.ore >= bp.geodeOreCost &&
            f.obsidian >= bp.geodeObsidianCost) {
          for (final r in Robot.values) {
            search(
                f.nextDay(
                    geodeRobots: 1,
                    ore: -bp.geodeOreCost,
                    obsidian: -bp.geodeObsidianCost),
                r);
          }
          return;
        }
        f = f.nextDay();
      }
      maxGeodes = max(maxGeodes, f.geode);
    }

    for (final buyRobot in Robot.values) {
      search(Factory(timeLeft: time), buyRobot);
    }
    return maxGeodes;
  }

  List<Blueprint> parseBlueprints(String input) =>
      input.lines.map(Blueprint.from).toList();
}

enum Robot { ore, clay, obsidian, geode }

class Blueprint {
  Blueprint(this.id, this.oreCost, this.clayOreCost, this.obsidianOreCost,
      this.obsidianClayCost, this.geodeOreCost, this.geodeObsidianCost);

  factory Blueprint.from(String line) {
    final digits = RegExp(r'\d+')
        .allMatches(line)
        .map((m) => int.parse(m.group(0)!))
        .toList();
    return Blueprint(digits[0], digits[1], digits[2], digits[3], digits[4],
        digits[5], digits[6]);
  }

  final int id;
  final int oreCost;
  final int clayOreCost;
  final int obsidianOreCost;
  final int obsidianClayCost;
  final int geodeOreCost;
  final int geodeObsidianCost;
}

class Factory {
  Factory({
    required this.timeLeft,
    this.oreRobots = 1,
    this.clayRobots = 0,
    this.obsidianRobots = 0,
    this.geodeRobots = 0,
    this.ore = 0,
    this.clay = 0,
    this.obsidian = 0,
    this.geode = 0,
  });

  Factory nextDay({
    int oreRobots = 0,
    int clayRobots = 0,
    int obsidianRobots = 0,
    int geodeRobots = 0,
    int ore = 0,
    int clay = 0,
    int obsidian = 0,
    int geode = 0,
  }) =>
      Factory(
        timeLeft: timeLeft - 1,
        oreRobots: this.oreRobots + oreRobots,
        clayRobots: this.clayRobots + clayRobots,
        obsidianRobots: this.obsidianRobots + obsidianRobots,
        geodeRobots: this.geodeRobots + geodeRobots,
        ore: this.ore + this.oreRobots + ore,
        clay: this.clay + this.clayRobots + clay,
        obsidian: this.obsidian + this.obsidianRobots + obsidian,
        geode: this.geode + this.geodeRobots + geode,
      );

  final int timeLeft;
  final int oreRobots;
  final int clayRobots;
  final int obsidianRobots;
  final int geodeRobots;
  final int ore;
  final int clay;
  final int obsidian;
  final int geode;
}
