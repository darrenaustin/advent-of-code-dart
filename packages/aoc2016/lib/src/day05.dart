// https://adventofcode.com/2016/day/5

import 'dart:convert';

import 'package:aoc/aoc.dart';
import 'package:crypto/crypto.dart';

main() => Day05().solve();

class Day05 extends AdventDay {
  Day05() : super(
    2016, 5, name: 'How About a Nice Game of Chess?',
    solution1: '2414bc77', solution2: '437e60fc',
  );

  // These are still super slow, but I think this is as fast as I can
  // get using the standard md5 support in the crypto package.

  @override
  dynamic part1(String input) => passwordFromHashes(input);

  @override
  dynamic part2(String input) => passwordFromHashIndex(input);
}

final int zero = '0'.codeUnitAt(0);
final int one = '1'.codeUnitAt(0);
final int nine = '9'.codeUnitAt(0);

String passwordFromHashes(String id) {
  int password = 0;
  int digitsFound = 0;
  List<int> encoded = [...utf8.encode(id)];
  int startIndex = encoded.length;
  encoded.add(zero);

  while (digitsFound < 8) {
    final digest = md5.convert(encoded);
    if (digest.bytes[0] == 0 && digest.bytes[1] == 0 && digest.bytes[2] < 16) {
      password = (password << 4) | digest.bytes[2];
      digitsFound += 1;
    }
    // Manually increment the index in the encoded data
    int endIndex = encoded.length - 1;
    while (endIndex > startIndex) {
      if (encoded[endIndex] < nine) {
        encoded[endIndex] += 1;
        break;
      }
      encoded[endIndex] = zero;
      endIndex--;
    }
    if (endIndex == startIndex) {
      if (encoded[endIndex] == nine) {
        encoded[endIndex] = one;
        encoded.add(zero);
      } else {
        encoded[endIndex] += 1;
      }
    }
  }
  return password.toRadixString(16);
}

String passwordFromHashIndex(String id) {
  int password = 0;
  Set<int> digitsFound = {};
  List<int> encoded = [...utf8.encode(id)];
  int startIndex = encoded.length;
  encoded.add(zero);

  while (digitsFound.length < 8) {
    final digest = md5.convert(encoded);
    if (digest.bytes[0] == 0 && digest.bytes[1] == 0 &&
        digest.bytes[2] < 8 && !digitsFound.contains(digest.bytes[2])) {
      int index = digest.bytes[2];
      int char = digest.bytes[3] >> 4;
      password |= char << ((7 - index) << 2);
      digitsFound.add(index);
    }
    // Manually increment the index in the encoded data
    int endIndex = encoded.length - 1;
    while (endIndex > startIndex) {
      if (encoded[endIndex] < nine) {
        encoded[endIndex] += 1;
        break;
      }
      encoded[endIndex] = zero;
      endIndex--;
    }
    if (endIndex == startIndex) {
      if (encoded[endIndex] == nine) {
        encoded[endIndex] = one;
        encoded.add(zero);
      } else {
        encoded[endIndex] += 1;
      }
    }
  }
  return password.toRadixString(16).padLeft(8, '0');
}

// https://adventofcode.com/2016/day/5
// 
// import 'dart:convert';
// 
// import 'package:crypto/crypto.dart';
// 
// import 'package:aoc/aoc.dart';
// 
// class Day05 extends AdventDay {
//   Day05() : super(2016, 5, solution1: '2414bc77', solution2: '437e60fc');
// 
//   // These are still very slow, but I think this is as fast as I can
//   // get it using the standard md5 support in the crypto package.
// 
//   @override
//   dynamic part1() => passwordFromHashes(inputData());
// 
//   @override
//   dynamic part2() => passwordFromHashIndex(inputData());
// }
// 
// final int zero = '0'.codeUnitAt(0);
// final int one = '1'.codeUnitAt(0);
// final int nine = '9'.codeUnitAt(0);
// 
// String passwordFromHashes(String id) {
//   int password = 0;
//   int digitsFound = 0;
//   List<int> encoded = [...utf8.encode(id)];
//   int startIndex = encoded.length;
//   encoded.add(zero);
// 
//   while (digitsFound < 8) {
//     final digest = md5.convert(encoded);
//     if (digest.bytes[0] == 0 && digest.bytes[1] == 0 && digest.bytes[2] < 16) {
//       password = (password << 4) | digest.bytes[2];
//       digitsFound += 1;
//     }
//     // Manually increment the index in the encoded data
//     int endIndex = encoded.length - 1;
//     while (endIndex > startIndex) {
//       if (encoded[endIndex] < nine) {
//         encoded[endIndex] += 1;
//         break;
//       }
//       encoded[endIndex] = zero;
//       endIndex--;
//     }
//     if (endIndex == startIndex) {
//       if (encoded[endIndex] == nine) {
//         encoded[endIndex] = one;
//         encoded.add(zero);
//       } else {
//         encoded[endIndex] += 1;
//       }
//     }
//   }
//   return password.toRadixString(16);
// }
// 
// String passwordFromHashIndex(String id) {
//   int password = 0;
//   Set<int> digitsFound = {};
//   List<int> encoded = [...utf8.encode(id)];
//   int startIndex = encoded.length;
//   encoded.add(zero);
// 
//   while (digitsFound.length < 8) {
//     final digest = md5.convert(encoded);
//     if (digest.bytes[0] == 0 && digest.bytes[1] == 0 &&
//         digest.bytes[2] < 8 && !digitsFound.contains(digest.bytes[2])) {
//       int index = digest.bytes[2];
//       int char = digest.bytes[3] >> 4;
//       password |= char << ((7 - index) << 2);
//       digitsFound.add(index);
//     }
//     // Manually increment the index in the encoded data
//     int endIndex = encoded.length - 1;
//     while (endIndex > startIndex) {
//       if (encoded[endIndex] < nine) {
//         encoded[endIndex] += 1;
//         break;
//       }
//       encoded[endIndex] = zero;
//       endIndex--;
//     }
//     if (endIndex == startIndex) {
//       if (encoded[endIndex] == nine) {
//         encoded[endIndex] = one;
//         encoded.add(zero);
//       } else {
//         encoded[endIndex] += 1;
//       }
//     }
//   }
//   return password.toRadixString(16).padLeft(8, '0');
// }
// 