// https://adventofcode.com/2016/day/9

import 'package:aoc/aoc.dart';

main() => Day09().solve();

class Day09 extends AdventDay {
  Day09() : super(2016, 9, name: 'Explosives in Cyberspace');

  @override
  dynamic part1(String input) => decompressedLength(input);

  @override
  dynamic part2(String input) => decompressedLength(input, recursive: true);

  final _whitespace = RegExp(r'\s*');
  final _markerRegexp = RegExp(r'(\d+)x(\d+)');

  int decompressedLength(String s, {bool recursive = false}) {
    s = s.replaceAll(_whitespace, '');
    int length = 0;
    while (s.isNotEmpty) {
      int markerStart = s.indexOf('(');
      if (markerStart == -1) {
        // No more markers so just account for the string that is left
        return length + s.length;
      }

      // Account for the text before the marker
      length += markerStart;

      // Find the marker info
      final markerEnd = s.indexOf(')', markerStart);
      if (markerEnd == -1) {
        throw Exception('Unmatched end marker: "$s"');
      }
      final markerText = s.substring(markerStart, markerEnd);
      final marker = _markerRegexp.firstMatch(markerText);
      if (marker == null) {
        throw Exception('Invalid marker $markerText');
      }
      int numChars = int.parse(marker.group(1)!);
      int count = int.parse(marker.group(2)!);

      if (recursive) {
        // Compute the expanded length of the marked characters
        String repeated = s.substring(markerEnd + 1, markerEnd + 1 + numChars);
        length += count * decompressedLength(repeated, recursive: true);
      } else {
        // Add the marker's repeated length
        length += numChars * count;
      }

      // Add the marker's repeated length
      s = s.substring(markerEnd + 1 + numChars);
    }
    return length;
  }
}
