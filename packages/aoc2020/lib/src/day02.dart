// https://adventofcode.com/2020/day/2

import 'package:aoc/aoc.dart';

main() => Day02().solve();

class Day02 extends AdventDay {
  Day02() : super(
    2020, 2, name: '',
  );

  @override
  dynamic part1(String input) => 'Need to migrate';

  @override
  dynamic part2(String input) => 'Need to migrate';
}

// https://adventofcode.com/2020/day/2
// 
// import 'package:aoc/aoc.dart';
// 
// class Day02 extends AdventDay {
//   Day02() : super(2020, 2, solution1: 582, solution2: 729);
// 
//   @override
//   dynamic part1() {
//     bool validPassword(Password p) {
//       final numMatchingLetters = p.password.split('')
//         .where((c) => c == p.letter)
//         .length;
//       return p.policy1 <= numMatchingLetters && numMatchingLetters <= p.policy2;
//     }
// 
//     return inputPasswords().where(validPassword).length;
//   }
// 
//   @override
//   dynamic part2() {
//     bool validPassword(Password pw) {
//       final occursInFirstPos = pw.password[pw.policy1 - 1] == pw.letter;
//       final occursInSecondPos = pw.password[pw.policy2 - 1] == pw.letter;
//       return occursInFirstPos ^ occursInSecondPos;
//     }
// 
//     return inputPasswords().where(validPassword).length;
//   }
// 
//   List<Password> inputPasswords() {
//     return inputDataLines()
//       .map(Password.from)
//       .toList();
//   }
// }
// 
// class Password {
//   Password({
//     required this.policy1,
//     required this.policy2,
//     required this.letter,
//     required this.password ,
//   });
// 
//   factory Password.from(String line) {
//     final passwordRx = RegExp(r'(\d+)-(\d+) (\w): (\w+)');
//     final match = passwordRx.firstMatch(line);
//     if (match != null) {
//       return Password(
//         policy1: int.parse(match.group(1)!),
//         policy2: int.parse(match.group(2)!),
//         letter: match.group(3)!,
//         password: match.group(4)!,
//       );
//     }
//     throw('Invalid password entry: $line');
//   }
// 
//   final int policy1;
//   final int policy2;
//   final String letter;
//   final String password;
// }
// 