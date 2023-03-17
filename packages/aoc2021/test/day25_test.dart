import 'package:aoc2021/src/day25.dart';
import 'package:test/test.dart';

main() {
  group('2021 Day 25', () {

    final exampleInput = '''
v...>>.vv>
.vv>>.vv..
>>.>v>...v
>>v>>.>.v.
v>v.vv.v..
>.>>..v...
.vv..>.>v.
v.v..>>v.v
....v..v.>''';

    group('part 1', () {
      test('example', () {
        expect(Day25().part1(exampleInput), 58);
      });

      test('solution', () => Day25().testPart1());
    });

    group('part 2', () {
      test('solution', () => Day25().testPart2());
    });
  });
}
