// https://adventofcode.com/2016/day/11

import 'package:aoc/aoc.dart';
import 'package:aoc/util/collection.dart';
import 'package:aoc/util/combinatorics.dart';
import 'package:aoc/util/pathfinding.dart';
import 'package:aoc/util/string.dart';
import 'package:collection/collection.dart';

main() => Day11().solve();

class Day11 extends AdventDay {
  Day11() : super(2016, 11, name: 'Radioisotope Thermoelectric Generators');

  @override
  dynamic part1(String input) {
    final building = parseBuilding(input);
    return aStarLowestCost<Building>(
      start: building,
      goal: building.goal(),
      estimatedDistance: Building.distanceToGoal,
      costTo: (b1, b2) => 1,
      neighborsOf: (b) => b.nextSteps()
    )?.toInt();
  }

  @override
  dynamic part2(String input) {
    final building = parseBuilding(input, [Pair(1, 1), Pair(1, 1)]);
    return aStarLowestCost<Building>(
      start: building,
      goal: building.goal(),
      estimatedDistance: Building.distanceToGoal,
      costTo: (b1, b2) => 1,
      neighborsOf: (b) => b.nextSteps()
    )?.toInt();
  }

  Building parseBuilding(String input, [List<Pair>? extraPairs]) {
    final chips = <String, int>{};
    final generators = <String, int>{};
    int floor = 1;
    for (final floorText in input.lines) {
      final chipMatches = RegExp(r'a (\w+)-compatible microchip').allMatches(floorText);
      for (final chipMatch in chipMatches) {
        final name = chipMatch.group(1)!;
        chips[name] = floor;
      }
      final generatorMatches = RegExp(r'a (\w+) generator').allMatches(floorText);
      for (final generatorMatch in generatorMatches) {
        final name = generatorMatch.group(1)!;
        generators[name] = floor;
      }
      floor++;
    }
    final pairs = <Pair>[];
    assert(chips.length == generators.length);
    for (final name in chips.keys) {
      pairs.add(Pair(chips[name]!, generators[name]!));
    }
    if (extraPairs != null) {
      pairs.addAll(extraPairs);
    }
    return Building(1, pairs);
  }
}

class Pair extends Comparable<Pair> {
  Pair(this.chip, this.generator);

  final int chip;
  final int generator;

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is Pair
      && other.chip == chip
      && other.generator == generator;
  }

  @override
  int get hashCode => chip.hashCode ^ generator.hashCode;

  @override
  int compareTo(Pair other) {
    late final chipSign = (chip - other.chip).sign;
    late final generatorSign = (generator - other.generator).sign;

    return chipSign == 0
      ? generatorSign == 0
        ? 0
        : generatorSign
      : chipSign;
  }

  @override
  String toString() => 'P[$chip, $generator]';
}

const deepEq = DeepCollectionEquality();

class Building {
  Building(this.elevator, List<Pair> pairs) : pairs = List.from(pairs)..sort();

  final int elevator;
  final List<Pair> pairs;

  Building goal() =>
    Building(4, List<Pair>.generate(pairs.length, (_) => Pair(4, 4)));

  static double distanceToGoal(Building b) =>
    4.0 - b.elevator +
    b.pairs.map((p) => 4 - p.chip + 4 - p.generator).sum;

  Iterable<Building> nextSteps() sync* {
    final elevatorDirections = [if (elevator != 4) 1, if (elevator != 1) -1];
    final floorItems = <Item>[
      ...pairs.indicesWhere((p) => p.chip == elevator).map((i) => Item.chip(i)),
      ...pairs.indicesWhere((p) => p.generator == elevator).map((i) => Item.generator(i))
    ];

    final possibleMovingItems = <Iterable<Item>>[
      ...combinations(floorItems, 2),
      ...floorItems.map((e) => [e]),
    ];

    for (final dir in elevatorDirections) {
      final movedElevator = elevator + dir;
      for (final items in possibleMovingItems) {
        final movedPairs = move(items, movedElevator);
        if (validFloor(movedPairs, elevator) && validFloor(movedPairs, movedElevator)) {
          yield Building(movedElevator, movedPairs);
        }
      }
    }
  }

  List<Pair> move(Iterable<Item> items, newFloor) {
    final movedPairs = List<Pair>.from(pairs);
    for (final item in items) {
      final oldPair = movedPairs.removeAt(item.pairIndex);
      final newPair = item.type == ItemType.chip
        ? Pair(newFloor, oldPair.generator)
        : Pair(oldPair.chip, newFloor);
      movedPairs.insert(item.pairIndex, newPair);
    }
    return movedPairs;
  }

  bool validFloor(List<Pair> pairs, int floor) {
    final chips = pairs.indicesWhere((p) => p.chip == floor);
    final generators = pairs.indicesWhere((p) => p.generator == floor).toSet();

    return generators.isEmpty || chips.every((chipIndex) => generators.contains(chipIndex));
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is Building
      && other.elevator == elevator
      && deepEq.equals(other.pairs, pairs);
  }

  @override
  int get hashCode => elevator.hashCode ^ deepEq.hash(pairs);

  @override
  String toString() => 'Elevator: $elevator, items: $pairs';
}

enum ItemType { chip, generator }

class Item {
  const Item.chip(this.pairIndex) : type = ItemType.chip;
  const Item.generator(this.pairIndex) : type = ItemType.generator;

  final int pairIndex;
  final ItemType type;

  @override
  String toString() => type == ItemType.chip ? 'chip($pairIndex)' : 'generator($pairIndex)';
}
