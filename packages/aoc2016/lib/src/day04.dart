// https://adventofcode.com/2016/day/4

import 'package:aoc/aoc.dart';
import 'package:aoc/util/collection.dart';
import 'package:aoc/util/comparison.dart';
import 'package:aoc/util/string.dart';
import 'package:collection/collection.dart';

main() => Day04().solve();

class Day04 extends AdventDay {
  Day04() : super(2016, 4, name: 'Security Through Obscurity');

  @override
  dynamic part1(String input) {
    return inputRooms(input).where((r) => r.isReal).map((r) => r.sectorID).sum;
  }

  @override
  dynamic part2(String input) {
    // Name determined by manually inspecting all the decrypted names.
    return inputRooms(input)
        .firstWhere((r) => r.decryptedName() == 'northpole object storage')
        .sectorID;
  }

  Iterable<Room> inputRooms(String input) => input.lines.map(Room.parse);
}

class Room {
  const Room(this.name, this.sectorID, this.checksum);

  final String name;
  final int sectorID;
  final String checksum;

  bool get isReal => checksum == computedChecksum();

  String computedChecksum() {
    final nameChars = name.split('-').join().split('')..sort();
    final groups = nameChars
        .slicesWhere(isNotEqual)
        .sorted((a, b) => b.length.compareTo(a.length));
    return groups.take(5).map((g) => g.first).join();
  }

  static final _charA = 'a'.codeUnits[0];
  static final _charDash = '-'.codeUnits[0];
  static final _charSpace = ' '.codeUnits[0];

  String decryptedName() => String.fromCharCodes(name.codeUnits.map((c) =>
      c == _charDash ? _charSpace : (c - _charA + sectorID) % 26 + _charA));

  static final _roomRegexp = RegExp(r'([a-z\-]+)-(\d+)\[([a-z]+)\]');

  static Room parse(String s) {
    final match = _roomRegexp.firstMatch(s);
    if (match == null) {
      throw Exception('Invalid room description: $s.');
    }
    return Room(match.group(1)!, int.parse(match.group(2)!), match.group(3)!);
  }

  @override
  String toString() {
    return 'Room "$name", sector $sectorID, checksum $checksum';
  }
}
