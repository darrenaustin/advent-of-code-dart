// https://adventofcode.com/2015/day/11

import 'package:aoc/aoc.dart';
import 'package:aoc/util/string.dart';
import 'package:collection/collection.dart';

main() => Day11().solve();

class Day11 extends AdventDay {
  Day11() : super(
    2015, 11, name: 'Corporate Policy',
    solution1: 'hxbxxyzz', solution2: 'hxcaabcc',
  );

  @override
  dynamic part1(String input) => nextValidPassword('hxbxwxba');

  @override
  dynamic part2(String input) => nextValidPassword(part1(input) as String);

  static final List<String> alphabet = 'abcdefghijklmnopqrstuvwxyz'.chars;

  static final nextChar =
    Map<String, String>.fromEntries(
      alphabet.mapIndexed((i, ch) => MapEntry(ch, alphabet[(i + 1) % alphabet.length]))
    )
    ..['h'] = 'j' // Skip the special chars i, o, and l.
    ..['n'] = 'p'
    ..['k'] = 'm';

  static final RegExp _straightPattern =
    RegExp(List<String>.generate(alphabet.length - 2, (int i) =>
        alphabet.getRange(i, i + 3).join()).join('|'));

  static final RegExp _confusedCharsPattern = RegExp(r'i|o|l');
  static final RegExp _pairsPattern = RegExp(r'(.)\1');

  static String increment(String s) {
    final List<String> chars = s.split('').reversed.toList();
    int index = 0;
    while (index < s.length) {
      final String next = nextChar[chars[index]]!;
      chars[index] = next;
      if (next != alphabet[0]) {
        break;
      }
      index++;
    }
    if (index == s.length) {
      chars.add(alphabet[0]);
    }
    return chars.reversed.join();
  }

  static bool validPassword(String text) {
    return
      // Must have a straight of at least three consecutive characters:
      _straightPattern.hasMatch(text) &&
      // Must not contain the letters i, o, or l:
      !_confusedCharsPattern.hasMatch(text) &&
      // Must have at least two non-overlapping pairs of characters:
      _pairsPattern.allMatches(text).map((m) => m.group(0)).toSet().length > 1;
  }

  static String nextValidPassword(String text) {
    do {
      text = increment(text);
    } while (!validPassword(text));
    return text;
  }
}
