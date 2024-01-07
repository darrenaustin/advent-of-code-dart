// https://adventofcode.com/2015/day/15

import 'dart:math';

import 'package:aoc/aoc.dart';
import 'package:aoc/util/collection.dart';
import 'package:aoc/util/string.dart';
import 'package:collection/collection.dart';

main() => Day15().solve();

class Day15 extends AdventDay {
  Day15() : super(2015, 15, name: 'Science for Hungry People');

  @override
  dynamic part1(String input) {
    final ingredients = inputIngredients(input);
    final combos =
        sumCombinations(List<int>.filled(ingredients.length, 0), 100);
    return combos.map((c) => cookieScore(ingredients, c)).max;
  }

  @override
  dynamic part2(String input) {
    final ingredients = inputIngredients(input);
    final combos =
        sumCombinations(List<int>.filled(ingredients.length, 0), 100);
    return combos
        .where((c) => calories(ingredients, c) == 500)
        .map((e) => cookieScore(ingredients, e))
        .max;
  }

  static final _ingredientPattern = RegExp(r'(\S+) (-?\d+)');

  static List<Map<String, int>> inputIngredients(String input) {
    return input.lines.map((String l) {
      final ingredients = l.substring(l.indexOf(':') + 2).split(', ');
      return Map<String, int>.fromEntries(ingredients.map((String i) {
        final match = _ingredientPattern.firstMatch(i)!;
        return MapEntry(match.group(1)!, int.parse(match.group(2)!));
      }));
    }).toList();
  }

  static int cookieScore(
      List<Map<String, int>> ingredients, List<int> ingredientQuantities) {
    final totals = <String, int>{};
    for (final i in range(ingredients.length)) {
      ingredients[i].forEach((String name, int value) {
        if (name != 'calories') {
          totals[name] = (totals[name] ?? 0) + ingredientQuantities[i] * value;
        }
      });
    }
    return totals.values.map((v) => max(v, 0)).product;
  }

  static int calories(
      List<Map<String, int>> ingredients, List<int> ingredientQuantities) {
    return range(ingredients.length)
        .map((i) => ingredients[i]['calories']! * ingredientQuantities[i])
        .sum;
  }

  Iterable<List<int>> sumCombinations(List<int> start, int sum,
      [int len = 0]) sync* {
    final int remaining = sum - start.sum;
    if (len == start.length - 1) {
      yield List<int>.from(start)..[len] = remaining;
    } else {
      for (final n in range(remaining)) {
        final newStart = List<int>.from(start)..[len] = n;
        for (final combo in sumCombinations(newStart, sum, len + 1)) {
          yield combo;
        }
      }
    }
  }
}
