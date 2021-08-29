// https://adventofcode.com/2015/day/11

import 'package:collection/collection.dart';

import '../../day.dart';

class Day11 extends AdventDay {
  Day11() : super(2015, 11, solution1: 'hxbxxyzz', solution2: 'hxcaabcc');

  @override
  dynamic part1() {
    return nextValidPassword('hxbxwxba');
  }

  @override
  dynamic part2() {
    return nextValidPassword(part1().toString());
  }

  static final List<String> alphabet = 'abcdefghijklmnopqrstuvwxyz'.split('').toList();

  static final Map<String, String> nextChar =
    Map<String, String>.fromEntries(alphabet.mapIndexed((int i, String ch) =>
        MapEntry<String, String>(ch, alphabet[(i + 1) % alphabet.length])))
        ..['h'] = 'j' // Skip the special chars i, o, and l.
        ..['n'] = 'p'
        ..['k'] = 'm';

  static final RegExp straightRegexp =
    RegExp(List<String>.generate(alphabet.length - 2, (int i) =>
        alphabet.getRange(i, i + 3).join()).join('|'));

  String increment(String s) {
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

  bool validPassword(String text) {
    return
      straightRegexp.hasMatch(text) &&
      // No need to check the special chars, as we skipped them.
      // !RegExp(r'i|o|l').hasMatch(text) &&
      RegExp(r'(.)\1').allMatches(text).map((RegExpMatch m) => m.group(0)).toSet().length > 1;
  }

  String nextValidPassword(String text) {
    text = increment(text);
    while (!validPassword(text)) {
      text = increment(text);
    }
    return text;
  }
}
