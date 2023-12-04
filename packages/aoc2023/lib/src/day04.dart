// https://adventofcode.com/2023/day/4

import 'dart:math';

import 'package:aoc/aoc.dart';
import 'package:aoc/util/string.dart';
import 'package:collection/collection.dart';

main() => Day04().solve();

class Day04 extends AdventDay {
  Day04() : super(2023, 4, name: 'Scratchcards');

  @override
  dynamic part1(String input) =>
      input.lines.map(Card.parse).map((c) => c.score()).sum;

  @override
  dynamic part2(String input) {
    final cards = input.lines.map(Card.parse).toList();
    final numCards = List<int>.generate(cards.length, (i) => 1);

    for (int c = 0; c < cards.length; c++) {
      final cardsWon = cards[c].numCorrect();
      final copies = numCards[c];
      for (int n = 0; n < cardsWon; n++) {
        numCards[c + 1 + n] += copies;
      }
    }
    return numCards.sum;
  }
}

class Card {
  Card({required this.winningNumbers, required this.pickedNumbers});

  final Set<int> winningNumbers;
  final Set<int> pickedNumbers;

  static final spacesSeperator = RegExp(r'\s+');

  factory Card.parse(String input) {
    final match = RegExp(r'Card \s*([\d]+): (.*)').firstMatch(input)!;
    final numberGroups = match.group(2)!.split(' | ');
    final winningNumbers =
        numberGroups[0].trim().split(spacesSeperator).map(int.parse).toSet();
    final pickedNumbers =
        numberGroups[1].trim().split(spacesSeperator).map(int.parse).toSet();

    return Card(winningNumbers: winningNumbers, pickedNumbers: pickedNumbers);
  }

  int numCorrect() => pickedNumbers.intersection(winningNumbers).length;

  int score() {
    final correct = numCorrect();
    return correct == 0 ? 0 : pow(2, correct - 1) as int;
  }
}
