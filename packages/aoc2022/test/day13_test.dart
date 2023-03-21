import 'package:aoc2022/src/day13.dart';
import 'package:test/test.dart';

main() {
  group('2022 Day 13', () {
    final exampleInput = '''
[1,1,3,1,1]
[1,1,5,1,1]

[[1],[2,3,4]]
[[1],4]

[9]
[[8,7,6]]

[[4,4],4,4]
[[4,4],4,4,4]

[7,7,7,7]
[7,7,7]

[]
[3]

[[[]]]
[[]]

[1,[2,[3,[4,[5,6,7]]]],8,9]
[1,[2,[3,[4,[5,6,0]]]],8,9]''';

    group('part 1', () {
      test('example', () {
        expect(Day13().part1(exampleInput), 13);
      });

      test('solution', () => Day13().testPart1());
    });

    group('part 2', () {
      test('example', () {
        expect(Day13().part2(exampleInput), 140);
      });

      test('solution', () => Day13().testPart2());
    });
  });
}
