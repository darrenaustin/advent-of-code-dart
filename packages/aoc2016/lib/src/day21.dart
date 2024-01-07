// https://adventofcode.com/2016/day/21

import 'package:aoc/aoc.dart';
import 'package:aoc/util/string.dart';

main() => Day21().solve();

class Day21 extends AdventDay {
  Day21() : super(2016, 21, name: 'Scrambled Letters and Hash');

  @override
  dynamic part1(String input, [String password = 'abcdefgh']) =>
      scramble(password, input);

  @override
  dynamic part2(String input, [String scrambled = 'fbgdceah']) =>
      unscramble(scrambled, input);

  String scramble(String password, String input) =>
      input.lines.fold(password, (pwd, op) => performOperation(pwd, op));

  String unscramble(String password, String input) => input.lines.reversed
      .fold(password, (pwd, op) => performReverseOperation(pwd, op));

  String performOperation(String password, String operation) {
    final swapPosMatch = RegExp(r'swap position (\d+) with position (\d+)')
        .firstMatch(operation);
    if (swapPosMatch != null) {
      return password.swapPositions(
          int.parse(swapPosMatch.group(1)!), int.parse(swapPosMatch.group(2)!));
    }
    final swapLetterMatch = RegExp(r'swap letter ([a-z]) with letter ([a-z])')
        .firstMatch(operation);
    if (swapLetterMatch != null) {
      return password.swapLetters(
          swapLetterMatch.group(1)!, swapLetterMatch.group(2)!);
    }
    final rotateMatch =
        RegExp(r'rotate (left|right) (\d+) step').firstMatch(operation);
    if (rotateMatch != null) {
      return password.rotate((rotateMatch.group(1)! == 'left' ? -1 : 1) *
          int.parse(rotateMatch.group(2)!));
    }
    final rotateLetterMatch =
        RegExp(r'rotate based on position of letter ([a-z])')
            .firstMatch(operation);
    if (rotateLetterMatch != null) {
      return password.rotateAroundLetter(rotateLetterMatch.group(1)!);
    }
    final reveseMatch =
        RegExp(r'reverse positions (\d+) through (\d+)').firstMatch(operation);
    if (reveseMatch != null) {
      return password.reversePositions(
          int.parse(reveseMatch.group(1)!), int.parse(reveseMatch.group(2)!));
    }
    final moveMatch =
        RegExp(r'move position (\d+) to position (\d+)').firstMatch(operation);
    if (moveMatch != null) {
      return password.movePosition(
          int.parse(moveMatch.group(1)!), int.parse(moveMatch.group(2)!));
    }
    throw Exception('Unable to parse operation: $operation');
  }

  String performReverseOperation(String password, String operation) {
    final swapPosMatch = RegExp(r'swap position (\d+) with position (\d+)')
        .firstMatch(operation);
    if (swapPosMatch != null) {
      return password.swapPositions(
          int.parse(swapPosMatch.group(2)!), int.parse(swapPosMatch.group(1)!));
    }
    final swapLetterMatch = RegExp(r'swap letter ([a-z]) with letter ([a-z])')
        .firstMatch(operation);
    if (swapLetterMatch != null) {
      return password.swapLetters(
          swapLetterMatch.group(2)!, swapLetterMatch.group(1)!);
    }
    final rotateMatch =
        RegExp(r'rotate (left|right) (\d+) step').firstMatch(operation);
    if (rotateMatch != null) {
      return password.rotate((rotateMatch.group(1)! == 'left' ? 1 : -1) *
          int.parse(rotateMatch.group(2)!));
    }
    final rotateLetterMatch =
        RegExp(r'rotate based on position of letter ([a-z])')
            .firstMatch(operation);
    if (rotateLetterMatch != null) {
      return password.reverseRotateAroundLetter(rotateLetterMatch.group(1)!);
    }
    final reveseMatch =
        RegExp(r'reverse positions (\d+) through (\d+)').firstMatch(operation);
    if (reveseMatch != null) {
      return password.reversePositions(
          int.parse(reveseMatch.group(1)!), int.parse(reveseMatch.group(2)!));
    }
    final moveMatch =
        RegExp(r'move position (\d+) to position (\d+)').firstMatch(operation);
    if (moveMatch != null) {
      return password.movePosition(
          int.parse(moveMatch.group(2)!), int.parse(moveMatch.group(1)!));
    }
    throw Exception('Unable to parse operation: $operation');
  }
}

extension ScrambleStringExt on String {
  String swapPositions(int x, int y) =>
      replaceRange(x, x + 1, this[y]).replaceRange(y, y + 1, this[x]);

  String swapLetters(String x, String y) =>
      swapPositions(indexOf(x), indexOf(y));

  // Negative steps => rotate to the left, Positive => rotate to the right
  String rotate(int steps) {
    final rotated = <String>[];
    for (int i = 0; i < length; i++) {
      rotated.add(this[(i - steps) % length]);
    }
    return rotated.join('');
  }

  String rotateAroundLetter(String x) {
    final index = indexOf(x);
    final steps = 1 + index + (index > 3 ? 1 : 0);
    return rotate(steps);
  }

  String reverseRotateAroundLetter(String x) {
    // This only works for length 8 passwords
    assert(length == 8);
    final index = indexOf(x);
    final steps = index ~/ 2 + (index.isOdd || index == 0 ? 1 : 5);
    return rotate(-steps);
  }

  String reversePositions(int x, int y) {
    final reversed = <String>[];
    final mid = (y - x + 1) ~/ 2 + x;
    for (int i = 0; i < length; i++) {
      if (x <= i && i <= y) {
        if (i < mid) {
          reversed.add(this[y - (i - x)]);
        } else {
          reversed.add(this[x + (y - i)]);
        }
      } else {
        reversed.add(this[i]);
      }
    }
    return reversed.join('');
  }

  String movePosition(int x, int y) {
    final moves = chars;
    moves.insert(y, moves.removeAt(x));
    return moves.join('');
  }
}
