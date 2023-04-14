// https://adventofcode.com/2016/day/14

import 'dart:convert';

import 'package:aoc/aoc.dart';
import 'package:crypto/crypto.dart';

main() => Day14().solve();

class Day14 extends AdventDay {
  Day14() : super(2016, 14, name: '');

  @override
  dynamic part1(String input) => indexOfKey(MD5Stream(input), 64);

  @override
  dynamic part2(String input) =>  indexOfKey(MD5Stream(input, 2016), 64);

  static int indexOfKey(MD5Stream stream, int maxKey) {
    int keys = 0;
    int index = 0;
    while (keys < maxKey) {
      final tripletChar = firstTriplet(stream.hash(index));
      if (tripletChar != null) {
        for (int i = 1; i < 1001; i++) {
          if (has5of(stream.hash(index + i), tripletChar)) {
            keys++;
            break;
          }
        }
      }
      index++;
    }
    return index - 1;
  }

  static String? firstTriplet(String s) =>
    RegExp(r'(.)\1\1').firstMatch(s)?.group(1);

  static bool has5of(String s, String c) =>
    RegExp('($c)\\1\\1\\1\\1').hasMatch(s);
}

class MD5Stream {
  MD5Stream(this.salt, [this.stretchHashes = 0]);

  final String salt;
  final int stretchHashes;
  final _hash = <String>[];
  int _maxIndex = 0;

  String hash(int index) {
    while (_maxIndex <= index) {
      _hash.add(_computeHash(_maxIndex));
      _maxIndex++;
    }
    return _hash[index];
  }

  String _computeHash(int index) {
    String hash = md5.convert(utf8.encode('$salt$index')).toString();
    for (int i = 0; i < stretchHashes; i++) {
      hash = md5.convert(utf8.encode(hash)).toString();
    }
    return hash;
  }
}
