// https://adventofcode.com/2018/day/4

import 'package:aoc/aoc.dart';
import 'package:aoc/util/string.dart';
import 'package:collection/collection.dart';

main() => Day04().solve();

class Day04 extends AdventDay {
  Day04() : super(2018, 4, name: 'Repose Record');

  @override
  dynamic part1(String input) {
    final guardSleepTimes = parseGuardSleepTimes(input);
    final mostSleepyGuard = guardSleepTimes
      .entries
      .map((e) => MapEntry(e.key, e.value.sum))
      .reduce((kv, ekv) => kv.value < ekv.value ? ekv : kv)
      .key;
    final minutes = guardSleepTimes[mostSleepyGuard]!;
    final mostSleptMinute = minutes.indexOf(minutes.max);
    return mostSleepyGuard * mostSleptMinute;
  }

  @override
  dynamic part2(String input) {
    final guardSleepTimes = parseGuardSleepTimes(input);
    final mostSleepyGuard = guardSleepTimes
      .entries
      .map((e) => MapEntry(e.key, e.value.max))
      .reduce((kv, ekv) => kv.value < ekv.value ? ekv : kv)
      .key;
    final minutes = guardSleepTimes[mostSleepyGuard]!;
    final mostSleptMinute = minutes.indexOf(minutes.max);
    return mostSleepyGuard * mostSleptMinute;
  }

  Map<int, List<int>> parseGuardSleepTimes(String input) {
    final sleepTimes = <int, List<int>>{};
    int? guard;
    List<int>? hour;
    int? lastSleepTime;
    for (final record in input.lines..sort()) {
      final statusText = record.substring(19);
      final minute = int.parse(RegExp(r':([\d]+)]').firstMatch(record)!.group(1)!);
      if (statusText.startsWith('Guard')) {
        guard = int.parse(RegExp(r'#([\d]+)').firstMatch(statusText)!.group(1)!);
        if (!sleepTimes.containsKey(guard)) {
          sleepTimes[guard] = List<int>.generate(60, (_) => 0);
        }
        hour = sleepTimes[guard];
      } else if (statusText == 'falls asleep') {
        lastSleepTime = minute;
      } else if (statusText == 'wakes up') {
        for (int t = lastSleepTime!; t < minute; t++) {
          hour![t]++;
        }
        lastSleepTime = null;
      } else {
        throw Exception('Unknown status $statusText');
      }
    }
    return sleepTimes;
  }
}
