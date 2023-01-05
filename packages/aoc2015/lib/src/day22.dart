// https://adventofcode.com/2015/day/22

import 'dart:math';

import 'package:aoc/aoc.dart';
import 'package:aoc/util/math.dart';

main() => Day22().solve();

class Day22 extends AdventDay {
  Day22() : super(
    2015, 22, name: 'Wizard Simulator 20XX',
    solution1: 1269, solution2: 1309,
  );

  @override
  dynamic part1(String input) {
    int? lowestManaCostWin(Battle battle, [int? lowestMana]) {
      if (battle.applyEffects()) {
        return battle.playerWon ? battle.player.manaSpent : null;
      }
      final availableSpells = battle.player.spells!
        .where((s) => 
          s.cost <= battle.player.mana &&
          !battle.activeEffects.containsKey(s.name)
        );
      for (final spell in availableSpells) {
        final nextBattle = Battle.from(battle);
        if (nextBattle.playerTurn(spell) ||
            nextBattle.applyEffects() ||
            nextBattle.bossTurn()) {
          if (nextBattle.playerWon) {
            lowestMana = minOrNull(lowestMana, nextBattle.player.manaSpent);
          }
        } else if (lowestMana == null || nextBattle.player.manaSpent < lowestMana) {
          lowestMana = minOrNull(lowestMana, lowestManaCostWin(nextBattle, lowestMana));
        }
      }
      return lowestMana;
    }

    return lowestManaCostWin(Battle(startingPlayer(), Character.parse(input, 'Boss')));
  }

  @override
  dynamic part2(String input) {
    int? lowestManaCostWin(Battle battle, [int? lowestMana]) {
      // Hard mode
      battle.player.hitPoints--;
      if (battle.done) return null;
      if (battle.applyEffects()) {
        return battle.playerWon ? battle.player.manaSpent : null;
      }
      final availableSpells = battle.player.spells!
        .where((s) =>
          s.cost <= battle.player.mana && 
          !battle.activeEffects.containsKey(s.name)
        );
      for (final Spell spell in availableSpells) {
        final Battle nextBattle = Battle.from(battle);
        if (nextBattle.playerTurn(spell) ||
            nextBattle.applyEffects() ||
            nextBattle.bossTurn()) {
          if (nextBattle.playerWon) {
            lowestMana = minOrNull(lowestMana, nextBattle.player.manaSpent);
          }
        } else {
          if (lowestMana == null || nextBattle.player.manaSpent < lowestMana) {
            lowestMana = minOrNull(lowestMana, lowestManaCostWin(nextBattle, lowestMana));
          }
        }
      }
      return lowestMana;
    }

    final battle = Battle(startingPlayer(), Character.parse(input, 'Boss'));
    return lowestManaCostWin(battle);
  }

  Character startingPlayer() =>
    Character(name: 'Player', hitPoints: 50, mana: 500, spells: [
      Spell(
        name: 'Magic Missile', cost: 53,
        effect: (caster, enemy) => enemy.hitPoints -= 4,
      ),
      Spell(
        name: 'Drain', cost: 73,
        effect: (caster, enemy) {
          enemy.hitPoints -= 2;
          caster.hitPoints += 2;
        },
      ),
      Spell(
        name: 'Shield', cost: 113, duration: 6,
        effect: (caster, enemy) => caster.armor = 7,
      ),
      Spell(
        name: 'Poison', cost: 173, duration: 6,
        effect: (caster, enemy) => enemy.hitPoints -= 3,
      ),
      Spell(
        name: 'Recharge', cost: 229, duration: 5,
        effect: (caster, enemy) => caster.mana += 101,
      ),
    ]);
}

class Battle {
  Battle(this.player, this.boss) : activeEffects = <String, SpellEffect>{};
  
  Battle.from(Battle other) :
    player = other.player.copy(),
    boss = other.boss.copy(),
    activeEffects = other.activeEffects.map((n, e) => MapEntry(n, e.copy()));

  final Character player;
  final Character boss;
  final Map<String, SpellEffect> activeEffects;

  bool get done => boss.hitPoints <= 0 || player.hitPoints <= 0;

  bool get playerWon => boss.hitPoints <= 0;

  bool applyEffects() {
    player.armor = 0;
    for (final effect in activeEffects.values) {
      effect.effect(player, boss);
      effect.duration--;
    }
    activeEffects.removeWhere((_, effect) => effect.duration <= 0);
    return done;
  }

  bool playerTurn(Spell spell) {
    if (!done) {
      final effect = spell.cast(player, boss);
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
}

typedef Effect = void Function(Character caster, Character enemy);

class SpellEffect {
  SpellEffect(this.name, this.effect, this.duration);

  SpellEffect copy({String? name, Effect? effect, int? duration}) =>
    SpellEffect(
      name ?? this.name,
      effect ?? this.effect,
      duration ?? this.duration
    );

  final String name;
  final Effect effect;
  int duration;
}

class Spell {
  Spell({
   required this.name, 
   required this.cost,
   this.duration = 0,
   required this.effect
  });

  final String name;
  final int cost;
  final int duration;
  final Effect effect;

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
}

class Character {
  Character({
    this.name = '',
    this.hitPoints = 0,
    this.damage = 0,
    this.armor = 0,
    this.mana = 0,
    this.spells,
    this.manaSpent = 0
  });

  factory Character.parse(String input, String name) {
    final hitPointMatch = RegExp(r'Hit Points: (\d+)').firstMatch(input)!;
    final damageMatch = RegExp(r'Damage: (\d+)').firstMatch(input)!;
    return Character(
      name: name, 
      hitPoints: int.parse(hitPointMatch.group(1)!),
      damage: int.parse(damageMatch.group(1)!),
    );
  }

  Character copy({
    String? name,
    int? hitPoints,
    int? damage,
    int? armor,
    int? mana,
    List<Spell>? spells,
    int? manaSpent,
  }) =>
    Character(
      name: name ?? this.name,
      hitPoints: hitPoints ?? this.hitPoints,
      damage: damage ?? this.damage,
      armor: armor ?? this.armor,
      mana: mana ?? this.mana,
      spells: spells ?? (this.spells != null ? List.from(this.spells!) : null),
      manaSpent: manaSpent ?? this.manaSpent
    );

  String name;
  int hitPoints;
  int damage;
  int armor;
  int mana;
  List<Spell>? spells;
  int manaSpent;
}
