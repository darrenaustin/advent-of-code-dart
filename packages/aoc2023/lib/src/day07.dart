// ignore_for_file: public_member_api_docs, sort_constructors_first
// https://adventofcode.com/2023/day/7

import 'package:aoc/aoc.dart';
import 'package:aoc/util/collection.dart';
import 'package:aoc/util/string.dart';
import 'package:collection/collection.dart';

main() => Day07().solve();

class Day07 extends AdventDay {
  Day07() : super(2023, 7, name: 'Camel Cards');

  @override
  dynamic part1(String input) {
    return (input.lines.map(Hand.parse).toList()..sort())
        .mapIndexed((index, h) => (index + 1) * h.bid)
        .sum;
  }

  @override
  dynamic part2(String input) {
    return (input.lines.map(Hand.parseJoker).toList()..sort())
        .mapIndexed((index, h) => (index + 1) * h.bid)
        .sum;
  }
}

enum HandType implements Comparable {
  highCard(1),
  onePair(2),
  twoPair(3),
  threeKind(4),
  fullHouse(5),
  fourKind(6),
  fiveKind(7);

  const HandType(this._order);
  final int _order;

  @override
  int compareTo(other) => _order.compareTo(other._order);
}

class Hand implements Comparable {
  Hand(this.cards, this.type, this.bid, this._cardOrder);

  final String cards;
  final HandType type;
  final int bid;
  final int Function(String) _cardOrder;

  static Hand parse(String input, [bool joker = false]) {
    final parts = input.split(' ');
    final cards = parts[0];
    final cardOrder = joker ? _jokerCardOrder : _plainCardOrder;
    final sortedCards = _sortCards(parts[0], cardOrder);
    final type = joker ? _jokerHandType(sortedCards) : _handType(sortedCards);
    final bid = int.parse(parts[1]);
    return Hand(cards, type, bid, cardOrder);
  }

  static Hand parseJoker(String input) => parse(input, true);

  static int _plainCardOrder(String card) => '23456789TJQKA'.indexOf(card);
  static int _jokerCardOrder(String card) => 'J23456789TQKA'.indexOf(card);

  static String _sortCards(String hand, int Function(String) cardOrder) =>
      hand.chars
          .sorted((a, b) => cardOrder(b).compareTo(cardOrder(a)))
          .join('');

  static HandType _handType(String hand) {
    final groups =
        frequencies(hand.chars).values.sorted((a, b) => b.compareTo(a));
    return switch (groups.first) {
      5 => HandType.fiveKind,
      4 => HandType.fourKind,
      3 => groups.last == 2 ? HandType.fullHouse : HandType.threeKind,
      2 => groups.length > 1 && groups.skip(1).first == 2
          ? HandType.twoPair
          : HandType.onePair,
      _ => HandType.highCard,
    };
  }

  static HandType _jokerHandType(String hand) {
    final numJokers = 'J'.allMatches(hand).length;
    if (numJokers == 5) {
      return HandType.fiveKind;
    }
    if (numJokers == 0) {
      return _handType(hand);
    }
    final plainHand = hand.substring(0, hand.length - numJokers);
    final plainType = _handType(plainHand);
    switch (plainType) {
      case HandType.fiveKind:
        return plainType;
      case HandType.fourKind:
        return numJokers == 1 ? HandType.fiveKind : HandType.fourKind;
      case HandType.fullHouse:
        return HandType.fullHouse;
      case HandType.threeKind:
        return numJokers == 2
            ? HandType.fiveKind
            : numJokers == 1
                ? HandType.fourKind
                : HandType.threeKind;
      case HandType.twoPair:
        return numJokers == 1 ? HandType.fullHouse : HandType.twoPair;
      case HandType.onePair:
        return numJokers == 3
            ? HandType.fiveKind
            : numJokers == 2
                ? HandType.fourKind
                : HandType.threeKind;
      case HandType.highCard:
        return numJokers == 4
            ? HandType.fiveKind
            : numJokers == 3
                ? HandType.fourKind
                : numJokers == 2
                    ? HandType.threeKind
                    : HandType.onePair;
    }
  }

  @override
  int compareTo(other) {
    if (other is Hand) {
      final types = type.compareTo(other.type);
      if (types == 0) {
        final cardsRanked = cards.chars.map(_cardOrder).toList();
        final otherCardsRanked = other.cards.chars.map(_cardOrder).toList();
        for (int i = 0; i < cardsRanked.length; i++) {
          final card = cardsRanked[i].compareTo(otherCardsRanked[i]);
          if (card != 0) {
            return card;
          }
        }
        return 0;
      }
      return types;
    }
    return -1;
  }
}
