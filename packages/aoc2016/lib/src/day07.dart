// https://adventofcode.com/2016/day/7

import 'package:aoc/aoc.dart';
import 'package:aoc/util/string.dart';
import 'package:collection/collection.dart';

main() => Day07().solve();

class Day07 extends AdventDay {
  Day07() : super(
    2016, 7, name: 'Internet Protocol Version 7',
    solution1: 115, solution2: 231,
  );

  @override
  dynamic part1(String input) {
    return input.lines.where(supportsTLS).length;
  }

  @override
  dynamic part2(String input) {
    return input.lines.where(supportsSSL).length;
  }

  static final RegExp _abbaRegExp = RegExp(r'(.)(.)\2(?!\2)\1');
  static bool _hasABBA(String s) => _abbaRegExp.hasMatch(s);

  static bool supportsTLS(String s) {
    final address = IPAddress(s);
    return 
      address.hypernetSequences.none(_hasABBA) &&
      address.supernetSequences.any(_hasABBA);
  }

  static final RegExp _abaRegExp = RegExp(r'(?=(.)(?!\1)(.)\1)');
  static Iterable<String> _abaS(String s) =>
     _abaRegExp.allMatches(s).map((m) => '${m[1]!}${m[2]!}${m[1]!}');
  static String _bab(String aba) => '${aba[1]}${aba[0]}${aba[1]}';

  static bool supportsSSL(String s) {
    final address = IPAddress(s);
    final abaSequences = address.supernetSequences.map(_abaS).flattened;
    if (abaSequences.isEmpty) {
      return false;
    }
    final babSequences = abaSequences.map(_bab);
    final anyBAB = RegExp('(${babSequences.join('|')})');
    return address.hypernetSequences.any((s) => s.contains(anyBAB));
  }
}

class IPAddress {
  IPAddress(String address) {
    final List<String> supernet = [];
    final List<String> hypernet = [];
    while (address.isNotEmpty) {
      int braceIndex = address.indexOf('[');
      if (braceIndex != -1) {
        supernet.add(address.substring(0, braceIndex));
        final closeBraceIndex = address.indexOf(']', braceIndex);
        if (closeBraceIndex == -1) {
          throw "Hypernet sequence missing closing ']' - $address";
        }
        hypernet.add(address.substring(braceIndex + 1, closeBraceIndex));
        address = address.substring(closeBraceIndex + 1);
      } else {
        supernet.add(address);
        address = '';
      }
    }
    supernetSequences = supernet;
    hypernetSequences = hypernet;
  }

  late final Iterable<String> supernetSequences;
  late final Iterable<String> hypernetSequences;
}
