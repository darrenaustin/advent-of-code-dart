// https://adventofcode.com/2023/day/4

import 'dart:math';

import 'package:aoc/aoc.dart';
import 'package:aoc/util/string.dart';
import 'package:collection/collection.dart';

main() => Day04().solve();

class Day04 extends AdventDay {
  Day04() : super(2023, 4, name: '');

  @override
  dynamic part1(String input) {
    var sum = 0;
    for (final cardData in input.lines) {
      final match = RegExp(r'Card \s*[\d]+: (.*)').firstMatch(cardData);
      final numberString = match!.group(1)!;
      final parts = numberString.split(' | ');
      final winningNumString = parts[0];
      final winningNumbers =
          winningNumString.trim().split(RegExp(r'\s+')).map(int.parse).toSet();
      final pickedNumbersString = parts[1];
      final pickedNumbers = pickedNumbersString
          .trim()
          .split(RegExp(r'\s+'))
          .map(int.parse)
          .toSet();
      final correctNumbers = pickedNumbers.intersection(winningNumbers);
      if (correctNumbers.isNotEmpty) {
        sum += pow(2, correctNumbers.length - 1) as int;
      }
    }
    return sum;
  }

  @override
  dynamic part2(String input) {
    final cardScores = <int>[];
    final cards = <int>[];
    for (final cardData in input.lines) {
      final match = RegExp(r'Card \s*([\d]+): (.*)').firstMatch(cardData)!;
      final numberString = match.group(2)!;
      final parts = numberString.split(' | ');
      final winningNumString = parts[0];
      final winningNumbers =
          winningNumString.trim().split(RegExp(r'\s+')).map(int.parse).toSet();
      final pickedNumbersString = parts[1];
      final pickedNumbers = pickedNumbersString
          .trim()
          .split(RegExp(r'\s+'))
          .map(int.parse)
          .toSet();
      final correctNumbers = pickedNumbers.intersection(winningNumbers);
      cards.add(1);
      cardScores.add(correctNumbers.length);
    }

    for (int i = 0; i < cardScores.length; i++) {
      final cardsWon = cardScores[i];
      if (cardsWon > 0) {
        for (int copy = 0; copy < cards[i]; copy++) {
          for (int j = 0; j < cardsWon; j++) {
            cards[i + 1 + j]++;
          }
        }
      }
    }
    return cards.sum;
  }
}
