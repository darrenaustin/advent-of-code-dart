// https://adventofcode.com/2020/day/2

import 'package:aoc/aoc.dart';
import 'package:aoc/util/collection.dart';
import 'package:aoc/util/string.dart';

main() => Day02().solve();

class Day02 extends AdventDay {
  Day02() : super(2020, 2, name: 'Password Philosophy');

  @override
  dynamic part1(String input) {
    bool validPassword(Password p) {
      final numMatchingLetters = p.password.chars.quantify((c) => c == p.letter);
      return p.policy1 <= numMatchingLetters && numMatchingLetters <= p.policy2;
    }
    return parsePasswords(input).quantify(validPassword);
  }

  @override
  dynamic part2(String input) {
    bool validPassword(Password pw) {
      final occursInFirstPos = pw.password[pw.policy1 - 1] == pw.letter;
      final occursInSecondPos = pw.password[pw.policy2 - 1] == pw.letter;
      return occursInFirstPos ^ occursInSecondPos;
    }
    return parsePasswords(input).quantify(validPassword);
  }

  List<Password> parsePasswords(String input) =>
    input.lines.map(Password.parse).toList();
}

class Password {
  Password({
    required this.policy1,
    required this.policy2,
    required this.letter,
    required this.password,
  });

  factory Password.parse(String input) {
    final passwordRx = RegExp(r'(\d+)-(\d+) (\w): (\w+)');
    final match = passwordRx.firstMatch(input);
    if (match != null) {
      return Password(
        policy1: int.parse(match.group(1)!),
        policy2: int.parse(match.group(2)!),
        letter: match.group(3)!,
        password: match.group(4)!,
      );
    }
    throw Exception('Invalid password entry: $input');
  }

  final int policy1;
  final int policy2;
  final String letter;
  final String password;
}
