// https://adventofcode.com/2016/day/4

import '../../day.dart';
import '../util/collection.dart';

class Day04 extends AdventDay {
  Day04() : super(2016, 4, solution1: 278221, solution2: 267);

  @override
  dynamic part1() {
    return inputRooms()
      .where((r) => r.real())
      .map((r) => r.sectorID)
      .sum();
  }

  @override
  dynamic part2() {
    return inputRooms()
      .firstWhere((r) => r.decryptedName() == 'northpole object storage')
      .sectorID;
  }

  Iterable<Room> inputRooms() => inputDataLines().map(Room.parse);
}

class Room {
  const Room(this.name, this.sectorID, this.checksum);

  final String name;
  final int sectorID;
  final String checksum;

  bool real() => checksum == computedChecksum();

  String computedChecksum() {
    final chars = name.split('').where((c) => c != '-').toList()..sort();
    final groups = chars
      .partitionWhere((c1, c2) => c1 != c2)
      .toList()
      ..sort((a, b) => b.length.compareTo(a.length));
    return groups
      .take(5)
      .map((g) => g.first)
      .join();
  }

  String decryptedName() {
    final charA = 'a'.codeUnits[0];
    final charDash = '-'.codeUnits[0];
    final charSpace = ' '.codeUnits[0];

    final charCodes = name.codeUnits;
    return String.fromCharCodes(charCodes.map((c) =>
      (c == charDash)
        ? charSpace
        : (c - charA + sectorID) % 26 + charA));
  }

  static Room parse(String s) {
    final roomRegexp = RegExp(r'([a-z\-]+)-(\d+)\[([a-z]+)\]');
    final match = roomRegexp.firstMatch(s);
    if (match == null) {
      throw Exception('Unable to parse room from $s.');
    }
    return Room(match.group(1)!, int.parse(match.group(2)!), match.group(3)!);
  }

  @override
  String toString() {
    return 'Room "$name", sector $sectorID, checksum $checksum';
  }

}
