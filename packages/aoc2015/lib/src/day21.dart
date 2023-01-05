// https://adventofcode.com/2015/day/21

import 'dart:math';

import 'package:aoc/aoc.dart';
import 'package:collection/collection.dart';

main() => Day21().solve();

class Day21 extends AdventDay {
  Day21() : super(
    2015, 21, name: 'RPG Simulator 20XX',
    solution1: 91, solution2: 158,
  );
  @override
  dynamic part1(String input) {
    final boss = Character.parse(input, 'Boss');
    return _equipmentPermutations()
      .where((items) => _equipPlayer(items).winsBattle(boss))
      .map(_equipmentCost)
      .min;
  }

  @override
  dynamic part2(String input) {
    final boss = Character.parse(input, 'Boss');
    return _equipmentPermutations()
      .where((items) => !_equipPlayer(items).winsBattle(boss))
      .map(_equipmentCost)
      .max;
  }

  Iterable<Iterable<Item>> _equipmentPermutations() sync* {
    final ringOptions = _ringPermutations();
    for (final weapon in weapons) {
      // No armor
      for (final rings in ringOptions) {
        yield <Item>[weapon, ...rings];
      }

      // Each armor
      for (final armor in armors) {
        for (final rings in ringOptions) {
          yield <Item>[weapon, armor, ...rings];
        }
      }
    }
  }

  Iterable<Iterable<Item>> _ringPermutations() sync* {
    yield [];
    for (int first = 0; first < rings.length - 1; first++) {
      final Item firstRing = rings[first];
      yield [firstRing];
      for (int second = first + 1; second < rings.length; second++) {
        yield [firstRing, rings[second]];
      }
    }
  }

  Character _equipPlayer(Iterable<Item> items) {
    return Character(
      name: 'Player',
      hitPoints: 100,
      damage: items.map((i) => i.damage).sum,
      armor: items.map((i) => i.armor).sum,
    );
  }

  int _equipmentCost(Iterable<Item> items) => items.map((i) => i.cost).sum;
}

const List<Item> weapons = <Item>[
  Item('Dagger', 8, 4, 0),
  Item('Shortsword', 10, 5, 0),
  Item('Warhammer', 25, 6, 0),
  Item('Longsword', 40, 7, 0),
  Item('Greataxe', 74, 8, 0),
];

const List<Item> armors = <Item>[
  Item('Leather', 13, 0, 1),
  Item('Chainmail', 31, 0, 2),
  Item('Splintmail', 53, 0, 3),
  Item('Bandedmail', 75, 0, 4),
  Item('Platemail', 102, 0, 5),
];

const List<Item> rings = <Item>[
  Item('Damage +1', 25, 1, 0),
  Item('Damage +2', 50, 2, 0),
  Item('Damage +3', 100, 3, 0),
  Item('Defense +1', 20, 0, 1),
  Item('Defense +2', 40, 0, 2),
  Item('Defense +3', 80, 0, 3),
];

class Item {
  const Item(this.name, this.cost, this.damage, this.armor);

  final String name;
  final int cost;
  final int damage;
  final int armor;
}

class Character {
  const Character({required this.name, this.hitPoints = 0, this.damage = 0, this.armor = 0});

  final String name;
  final int hitPoints;
  final int damage;
  final int armor;

  factory Character.parse(String input, String name) {
    final hitPointMatch = RegExp(r'Hit Points: (\d+)').firstMatch(input)!;
    final damageMatch = RegExp(r'Damage: (\d+)').firstMatch(input)!;
    final armorMatch = RegExp(r'Armor: (\d+)').firstMatch(input)!;
    return Character(
      name: name, 
      hitPoints: int.parse(hitPointMatch.group(1)!),
      damage: int.parse(damageMatch.group(1)!),
      armor: int.parse(armorMatch.group(1)!),
    );
  }

  bool winsBattle(Character opponent) {
    final myDamagePerRound = max(damage - opponent.armor, 1);
    final opponentDamagePerRound = max(opponent.damage - armor, 1);
    final iDieAfterRound = hitPoints ~/ opponentDamagePerRound;
    final opponentDiesAfterRound = opponent.hitPoints ~/ myDamagePerRound;
    return (iDieAfterRound >= opponentDiesAfterRound);
  }
}
