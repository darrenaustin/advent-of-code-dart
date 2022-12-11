// https://adventofcode.com/2016/day/5

import 'dart:convert';

import 'package:crypto/crypto.dart';

import '../../day.dart';

class Day05 extends AdventDay {
  Day05() : super(2016, 5, solution1: '2414bc77', solution2: '437e60fc');

  @override
  dynamic part1() {
    return password(inputData());
  }

  @override
  dynamic part2() {
    // return '437e60fc';
    return positionalPassword(inputData());
  }
}

String password(String id) {
  return passwordHashes(id)
      .take(8)
      .map((h) => h[5])
      .join();
}

String positionalPassword(String id) {
  final chars = List<String>.filled(8, '_');
  int charsFound = 0;
  Iterable<String> hashes = passwordHashes(id);
  while (charsFound < 8) {
    final hash = hashes.first;
    final int? index = int.tryParse(hash[5]);
    if (index != null &&
        0 <= index && index < 8 &&
        chars[index] == '_') {
      chars[index] = hash[6];
      charsFound++;
      // print(chars.join());
    }
    hashes = hashes.skip(1);
  }
  return chars.join();
}

// TODO: this is WAY too slow for this. Look into
//       ways to speed this up.
String textMD5(String text) {
  return md5.convert(utf8.encode(text)).toString();
}

Iterable<String> passwordHashes(String id) sync* {
  int index = 0;
  late String hash;
  while (true) {
    do {
      hash = textMD5('$id${index.toString()}');
      index++;
    } while (!hash.startsWith('00000'));
    yield hash;
  }
}
