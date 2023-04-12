// https://adventofcode.com/2020/day/13

import 'package:aoc/aoc.dart';
import 'package:aoc/util/string.dart';

main() => Day13().solve();

class Day13 extends AdventDay {
  Day13() : super(2020, 13, name: 'Shuttle Search');

  @override
  dynamic part1(String input) {
    final timestamp = parseTimestamp(input);
    final buses = parseBusIds(input);
    int closestBus = buses.first;
    int closestWaitTime = waitTime(buses.first, timestamp);
    for (final bus in buses.skip(1)) {
      final busWaitTime = waitTime(bus, timestamp);
      if (busWaitTime < closestWaitTime) {
        closestBus = bus;
        closestWaitTime = busWaitTime;
      }
    }
    return closestBus * closestWaitTime;
  }

  @override
  dynamic part2(String input) {
    final busOffsets = parseBusOffsets(input);
    var timestamp = 0;
    var increment = 1;
    for (final busOffset in busOffsets) {
      while ((timestamp + busOffset.offset) % busOffset.id != 0) {
        timestamp += increment;
      }
      increment *= busOffset.id;
    }
    return timestamp;
  }

  int parseTimestamp(String input) => int.parse(input.lines[0]);

  Iterable<int> parseBusIds(String input) =>
    input.lines[1]
      .split(',')
      .where((e) => e != 'x')
      .map(int.parse);

  Iterable<int?> parseAllBusIds(String input) =>
    input.lines[1]
      .split(',')
      .map((e) => e == 'x' ? null : int.parse(e));

  Iterable<BusOffset> parseBusOffsets(String input) =>
    parseAllBusIds(input).toList().asMap().entries
      // Remove any entries that had an 'x' (which were translated into null ids)
      .where((kv) => kv.value != null)
      // The index for each entry is the offset for the timestamp (or the remainder)
      .map((kv) => BusOffset(kv.value!, kv.key));

  int waitTime(int bus, int timestamp) =>
    ((timestamp ~/ bus) + 1) * bus - timestamp;
}

class BusOffset {
  BusOffset(this.id, this.offset);

  final int id;
  final int offset;
}
