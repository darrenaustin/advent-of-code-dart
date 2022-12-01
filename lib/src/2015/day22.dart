// https://adventofcode.com/2015/day/22

import 'dart:math';

import '../../day.dart';
import '../util/math.dart';

class Day22 extends AdventDay {
  Day22() : super(2015, 22, solution1: 1269, solution2: 1309);

  @override
  dynamic part1() {
    int? lowestManaCostWin(Battle battle, [int? lowestManaFound]) {
      if (battle.applyEffects()) {
        return battle.playerWon ? battle.player.manaSpent : null;
      }
      final Iterable<Spell> availableSpells = battle.player.spells!
          .where((Spell s) =>
            s.cost <= battle.player.mana && !battle.activeEffects.containsKey(s.name));
      for (final Spell spell in availableSpells) {
        final Battle nextBattle = Battle.from(battle);
        if (nextBattle.playerTurn(spell) || nextBattle.applyEffects() || nextBattle.bossTurn()) {
          if (nextBattle.playerWon) {
            lowestManaFound = minOrNull(lowestManaFound, nextBattle.player.manaSpent);
          }
        } else {
          if (lowestManaFound == null || nextBattle.player.manaSpent < lowestManaFound) {
            lowestManaFound = minOrNull(lowestManaFound, lowestManaCostWin(nextBattle, lowestManaFound));
          }
        }
      }
      return lowestManaFound;
    }

    return lowestManaCostWin(Battle(startingPlayer(), inputBoss()));
  }

  @override
  dynamic part2() {
    int? lowestManaCostWin(Battle battle, [int? lowestManaFound]) {
      // Hard mode
      battle.player.hitPoints--;
      if (battle.done) {
        return null;
      }
      if (battle.applyEffects()) {
        return battle.playerWon ? battle.player.manaSpent : null;
      }
      final Iterable<Spell> availableSpells = battle.player.spells!
          .where((Spell s) =>
            s.cost <= battle.player.mana && !battle.activeEffects.containsKey(s.name));
      for (final Spell spell in availableSpells) {
        final Battle nextBattle = Battle.from(battle);
        if (nextBattle.playerTurn(spell) || nextBattle.applyEffects() || nextBattle.bossTurn()) {
          if (nextBattle.playerWon) {
            lowestManaFound = minOrNull(lowestManaFound, nextBattle.player.manaSpent);
          }
        } else {
          if (lowestManaFound == null || nextBattle.player.manaSpent < lowestManaFound) {
            lowestManaFound = minOrNull(lowestManaFound, lowestManaCostWin(nextBattle, lowestManaFound));
          }
        }
      }
      return lowestManaFound;
    }

    final Battle battle = Battle(startingPlayer(), inputBoss());
    return lowestManaCostWin(battle);
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
    return boss;
  }

  Character startingPlayer() =>
    Character(name: 'Player', hitPoints: 50, mana: 500, spells: <Spell>[
      Spell(
        name: 'Magic Missile', cost: 53,
        effect: (Character caster, Character enemy) => enemy.hitPoints -= 4,
      ),
      Spell(
        name: 'Drain', cost: 73,
        effect: (Character caster, Character enemy) {
          enemy.hitPoints -= 2;
          caster.hitPoints += 2;
        },
      ),
      Spell(
        name: 'Shield', cost: 113, duration: 6,
        effect: (Character caster, Character enemy) => caster.armor = 7,
      ),
      Spell(
        name: 'Poison', cost: 173, duration: 6,
        effect: (Character caster, Character enemy) => enemy.hitPoints -= 3,
      ),
      Spell(
        name: 'Recharge', cost: 229, duration: 5,
        effect: (Character caster, Character enemy) => caster.mana += 101,
      ),
    ]);
}

class Battle {
  Battle(this.player, this.boss) : activeEffects = <String, SpellEffect>{};

  Battle.from(Battle other) :
    player = Character.from(other.player),
    boss = Character.from(other.boss),
    activeEffects = other.activeEffects
      .map((String name, SpellEffect effect) =>
        MapEntry<String, SpellEffect>(name, SpellEffect.from(effect)));

  final Character player;
  final Character boss;
  final Map<String, SpellEffect> activeEffects;

  bool get done => boss.hitPoints <= 0 || player.hitPoints <= 0;

  bool get playerWon => boss.hitPoints <= 0;

  bool applyEffects() {
    player.armor = 0;
    for (final SpellEffect effect in activeEffects.values) {
      effect.effect(player, boss);
      effect.duration--;
    }
    activeEffects.removeWhere((String name, SpellEffect effect) => effect.duration <= 0);
    return done;
  }

  bool playerTurn(Spell spell) {
    if (!done) {
      final SpellEffect? effect = spell.cast(player, boss);
      if (effect != null) {
        activeEffects[effect.name] = effect;
      }
    }
    return done;
  }

  bool bossTurn() {
    if (!done) {
      player.hitPoints -= max(1, boss.damage - player.armor);
    }
    return done;
  }

  @override
  String toString() {
    final StringBuffer buffer = StringBuffer();
    buffer.writeln(player);
    buffer.writeln(boss);
    activeEffects.values.forEach(buffer.writeln);
    return buffer.toString();
  }
}

typedef Effect = void Function(Character caster, Character enemy);

class SpellEffect {
  SpellEffect(this.name, this.effect, this.duration);

  SpellEffect.from(SpellEffect other) :
        name = other.name,
        effect = other.effect,
        duration = other.duration;

  final String name;
  final Effect effect;
  int duration;

  @override
  String toString() {
    return '$name: duration = $duration';
  }
}

class Spell {
  Spell({required this.name, required this.cost, this.duration = 0, required this.effect});

  final String name;
  final int cost;
  final Effect effect;
  final int duration;

  SpellEffect? cast(Character caster, Character enemy) {
    if (caster.mana >= cost) {
      caster.mana -= cost;
      caster.manaSpent += cost;
      if (duration > 0) {
        return SpellEffect(name, effect, duration);
      } else {
        effect(caster, enemy);
      }
    }
    return null;
  }

  @override
  String toString() {
    return '$name: $cost, $duration';
  }
}

class Character {
  Character({
    required this.name,
    this.hitPoints = 0,
    this.damage = 0,
    this.armor = 0,
    this.mana = 0,
    this.spells,
  });

  Character.from(Character other) :
    name = other.name,
    hitPoints = other.hitPoints,
    damage = other.damage,
    armor = other.armor,
    mana = other.mana,
    spells = other.spells,
    manaSpent = other.manaSpent;

  String name;
  int hitPoints;
  int damage;
  int armor;
  int mana;
  List<Spell>? spells;
  int manaSpent = 0;

  @override
  String toString() {
    return '$name [HP: $hitPoints, Damage: $damage, Armor: $armor, Mana: $mana]';
  }
}
