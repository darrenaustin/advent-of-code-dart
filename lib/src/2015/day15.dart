// https://adventofcode.com/2015/day/15

import 'dart:math';

import '../../day.dart';
import '../util/collection.dart';

class Day15 extends AdventDay {
  Day15() : super(2015, 15, solution1: 222870, solution2: 117936);

  @override
  dynamic part1() {
    final List<Map<String, int>> ingredients = inputIngredients().toList();
    final Iterable<List<int>> combos = sumCombinations(List<int>.filled(ingredients.length, 0), 100);
    return combos
      .map((List<int> c) => cookieScore(ingredients, c))
      .max();
  }

  @override
  dynamic part2() {
    final List<Map<String, int>> ingredients = inputIngredients().toList();
    final Iterable<List<int>> combos = sumCombinations(List<int>.filled(ingredients.length, 0), 100);
    return combos
      .where((List<int> c) => calories(ingredients, c) == 500)
      .map((List<int> e) => cookieScore(ingredients, e))
      .max();
  }

  Iterable<Map<String, int>> inputIngredients() {
    return inputDataLines().map((String l) {
      final List<String> ingredients = l.substring(l.indexOf(':') + 2).split(', ');
      return Map<String, int>.fromEntries(ingredients.map((String i) {
        final RegExpMatch parse = RegExp(r'(\S+) (-?\d+)').firstMatch(i)!;
        return MapEntry<String, int>(parse.group(1)!, int.parse(parse.group(2)!));
      }));
    });
  }

  int cookieScore(List<Map<String, int>> ingredients, List<int> ingredientQuantities) {
    final Map<String, int> totals = <String, int>{};
    for (int i = 0; i < ingredients.length; i++) {
      ingredients[i].forEach((String name, int value) {
        if (name != 'calories') {
          totals[name] = (totals[name] ?? 0) + ingredientQuantities[i] * value;
        }
      });
    }
    return totals.values.map((int v) => max(v, 0)).product();
  }

  int calories(List<Map<String, int>> ingredients, List<int> ingredientQuantities) {
    int total = 0;
    for (int i = 0; i < ingredients.length; i++) {
      total += ingredients[i]['calories']! * ingredientQuantities[i];
    }
    return total;
  }

  Iterable<List<int>> sumCombinations(List<int> start, int sum, [int len = 0]) sync* {
    final int remaining = sum - start.sum();
    if (len == start.length - 1) {
      yield List<int>.from(start)..[len] = remaining;
    } else {
      for (int n = 0; n < remaining; n++) {
        final List<int> newStart = List<int>.from(start)..[len] = n;
        for (final List<int> combo in sumCombinations(newStart, sum, len + 1)) {
          yield combo;
        }
      }
    }
  }
}
