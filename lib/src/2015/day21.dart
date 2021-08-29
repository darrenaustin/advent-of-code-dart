// https://adventofcode.com/2015/day/21

import 'dart:math';

import '../../day.dart';
import '../util/collection.dart';

class Day21 extends AdventDay {
  Day21() : super(2015, 21, solution1: 91, solution2: 158);

  @override
  dynamic part1() {
    final Character boss = inputBoss();
    return equipmentPermutations()
      .where((Iterable<Item> e) {
        final Character player = equipPlayer(e);
        return battle(player, boss) == player;
      })
      .map(equipmentCost)
      .min();
  }

  @override
  dynamic part2() {
    final Character boss = inputBoss();
    return equipmentPermutations()
      .where((Iterable<Item> e) {
        final Character player = equipPlayer(e);
        return battle(player, boss) != player;
      })
      .map(equipmentCost)
      .max();
  }

  Character inputBoss() {
    final Character boss = Character(name: 'Boss');
    final String stats = inputData();
    final RegExpMatch? hitPointParse = RegExp(r'Hit Points: (\d+)').firstMatch(stats);
    if (hitPointParse != null) {
      boss.hitPoints = int.parse(hitPointParse.group(1)!);
    }
    final RegExpMatch? damageParse = RegExp(r'Damage: (\d+)').firstMatch(stats);
    if (damageParse != null) {
      boss.damage = int.parse(damageParse.group(1)!);
    }
    final RegExpMatch? armorParse = RegExp(r'Armor: (\d+)').firstMatch(stats);
    if (armorParse != null) {
      boss.armor = int.parse(armorParse.group(1)!);
    }
    return boss;
  }

  Character battle(Character a, Character b) {
    final int aDamagePerRound = max(a.damage - b.armor, 1);
    final int bDamagePerRound = max(b.damage - a.armor, 1);
    final int aDiesAfterRound = a.hitPoints ~/ bDamagePerRound;
    final int bDiesAfterRound = b.hitPoints ~/ aDamagePerRound;
    return (bDiesAfterRound > aDiesAfterRound) ? b : a;
  }

  Iterable<Iterable<Item>> equipmentPermutations() sync* {
    final Iterable<Iterable<Item>> rings = ringPermutations();
    for (final Item weapon in weapons) {
      // No armor
      for (final Iterable<Item> r in rings) {
        yield <Item>[weapon, ...r];
      }

      // Each armor
      for (final Item a in armor) {
        for (final Iterable<Item> r in rings) {
          yield <Item>[weapon, a, ...r];
        }
      }
    }
  }

  Iterable<Iterable<Item>> ringPermutations() sync* {
    yield <Item>[];
    for (int first = 0; first < rings.length; first++) {
      final Item firstRing = rings[first];
      yield <Item>[firstRing];
      for (int second = first + 1; second < rings.length; second++) {
        final Item secondRing = rings[second];
        yield <Item>[firstRing, secondRing];
      }
    }
  }

  Character equipPlayer(Iterable<Item> items) {
    return Character(
      name: 'Player',
      hitPoints: 100,
      damage: items.map((Item i) => i.damage).sum(),
      armor: items.map((Item i) => i.armor).sum(),
    );
  }

  int equipmentCost(Iterable<Item> items) =>
    items.map((Item i) => i.cost).sum();
}

const List<Item> weapons = <Item>[
  Item('Dagger', 8, 4, 0),
  Item('Shortsword', 10, 5, 0),
  Item('Warhammer', 25, 6, 0),
  Item('Longsword', 40, 7, 0),
  Item('Greataxe', 74, 8, 0),
];

const List<Item> armor = <Item>[
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

  @override
  String toString() {
    return '$name [Cost: $cost, Damage: $damage, Armor: $armor]';
  }
}

class Character {
  Character({required this.name, this.hitPoints = 0, this.damage = 0, this.armor = 0});

  String name;
  int hitPoints;
  int damage;
  int armor;

  @override
  String toString() {
    return '$name [HP: $hitPoints, Damage: $damage, Armor: $armor]';
  }
}
