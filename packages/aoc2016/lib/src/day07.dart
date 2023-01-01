// https://adventofcode.com/2016/day/7

import 'package:aoc/aoc.dart';

main() => Day07().solve();

class Day07 extends AdventDay {
  Day07() : super(
    2016, 7, name: '',
  );

  @override
  dynamic part1(String input) => 'Need to migrate';

  @override
  dynamic part2(String input) => 'Need to migrate';
}

// https://adventofcode.com/2016/day/7
// 
// import 'package:collection/collection.dart';
// 
// import 'package:aoc/aoc.dart';
// 
// class Day07 extends AdventDay {
//   Day07() : super(2016, 7, solution1: 115, solution2: 231);
// 
//   @override
//   dynamic part1() {
//     return inputDataLines().where(supportsTLS).length;
//   }
// 
//   @override
//   dynamic part2() {
//     return inputDataLines().where(supportsSSL).length;
//   }
// 
//   final RegExp abbaRegExp = RegExp(r'(.)(.)\2(?!\2)\1');
//   bool hasABBA(String s) => abbaRegExp.hasMatch(s);
// 
//   bool supportsTLS(String s) {
//     final IPAddress address = IPAddress(s);
//     return address.hypernetSequences.none(hasABBA)
//         && address.supernetSequences.any(hasABBA);
//   }
// 
//   final RegExp abaRegExp = RegExp(r'(?=(.)(?!\1)(.)\1)');
//   Iterable<String> abaS(String s) => abaRegExp.allMatches(s).map((m) => '${m[1]!}${m[2]!}${m[1]!}');
//   String bab(String aba) => '${aba[1]}${aba[0]}${aba[1]}';
// 
//   bool supportsSSL(String s) {
//     final IPAddress address = IPAddress(s);
//     final abaSequences = address.supernetSequences.map(abaS).flattened;
//     if (abaSequences.isEmpty) {
//       return false;
//     }
//     final babSequences = abaSequences.map(bab);
//     final anyBAB = RegExp('(${babSequences.join('|')})');
//     return address.hypernetSequences.any((s) => s.contains(anyBAB));
//   }
// }
// 
// class IPAddress {
//   IPAddress(String address) {
//     final List<String> supernet = [];
//     final List<String> hypernet = [];
//     while (address.isNotEmpty) {
//       int braceIndex = address.indexOf('[');
//       if (braceIndex != -1) {
//         supernet.add(address.substring(0, braceIndex));
//         final closeBraceIndex = address.indexOf(']', braceIndex);
//         if (closeBraceIndex == -1) {
//           throw Exception('Hypernet sequence missing closing \']\' - $address');
//         }
//         hypernet.add(address.substring(braceIndex + 1, closeBraceIndex));
//         address = address.substring(closeBraceIndex + 1);
//       } else {
//         supernet.add(address);
//         address = '';
//       }
//     }
//     supernetSequences = supernet;
//     hypernetSequences = hypernet;
//   }
// 
//   late final Iterable<String> supernetSequences;
//   late final Iterable<String> hypernetSequences;
// }
// 