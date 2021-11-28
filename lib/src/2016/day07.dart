// https://adventofcode.com/2016/day/7

import '../../day.dart';

class Day07 extends AdventDay {
  Day07() : super(2016, 7, solution1: 115);

  @override
  dynamic part1() {
    return inputDataLines().where(supportsTLS).length;
  }

  @override
  dynamic part2() {
    // return supportsSSL('aba[bab]xyz');
    // return supportsSSL('xyx[xyx]xyx');
    // return supportsSSL('aaa[kek]eke');
    // return supportsSSL('zazbz[bzb]cdb');
    // return inputDataLines().where(supportsSSL).length;
  }

  bool supportsTLS(String address) {
    bool foundABBA = false;
    while (address.isNotEmpty && !foundABBA) {
      int braceIndex = address.indexOf('[');
      if (braceIndex != -1) {
        foundABBA |= hasABBA(address.substring(0, braceIndex));
        // Check the hypernet sequence between the braces
        final closeBraceIndex = address.indexOf(']', braceIndex);
        if (closeBraceIndex == -1) {
          throw Exception('Hypernet sequence missing closing \']\' - $address');
        }
        if (hasABBA(address.substring(braceIndex + 1, closeBraceIndex))) {
          return false;
        }
        address = address.substring(closeBraceIndex + 1);
      } else {
        foundABBA |= hasABBA(address);
        address = '';
      }
    }
    return foundABBA;
  }

  final RegExp abbaRegExp = RegExp(r'(.)(.)\2(?!\2)\1');
  bool hasABBA(String s) {
    return abbaRegExp.hasMatch(s);
  }

  bool supportsSSL(String address) {
    List<String> abaSequences = [];
    List<String> hypernetSequences = [];

    // Parse the address collecting ABA sequences from the supernet sections
    // and the full text of of the hypernet sections (in brackets)
    while (address.isNotEmpty) {
      int braceIndex = address.indexOf('[');
      if (braceIndex != -1) {
        abaSequences.addAll(abaS(address.substring(0, braceIndex)));
        final closeBraceIndex = address.indexOf(']', braceIndex);
        if (closeBraceIndex == -1) {
          throw Exception('Hypernet sequence missing closing \']\' - $address');
        }
        hypernetSequences.add(address.substring(braceIndex + 1, closeBraceIndex));
        address = address.substring(closeBraceIndex + 1);
      } else {
        abaSequences.addAll(abaS(address));
        address = '';
      }
    }

    // Construct a regexp for matching any of the abas as babs
    final babSequences = abaSequences.map((s) => '${s[1]}${s[0]}${s[1]}');
    final babRegExp = RegExp('(${babSequences.join('|')})');
    return hypernetSequences.any((s) => babRegExp.hasMatch(s));
  }

  final RegExp abaRegExp = RegExp(r'(?=(.)(?!\1)(.)\1)');
  Iterable<String> abaS(String s) {
    return abaRegExp.allMatches(s).map((m) => '${m[1]!}${m[2]!}${m[1]!}');
  }



}

