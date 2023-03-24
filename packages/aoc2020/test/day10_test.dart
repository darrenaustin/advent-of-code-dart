import 'package:aoc2020/src/day10.dart';
import 'package:test/test.dart';

main() {
  final exampleInput1 = '''
16
10
15
5
1
11
7
19
6
12
4''';
  final exampleInput2 = '''
28
33
18
42
31
14
46
20
48
47
24
23
49
45
19
38
39
11
1
32
25
35
8
17
7
9
4
2
34
10
3''';

  group('2020 Day 10', () {
    group('part 1', () {
      test('example', () {
        expect(Day10().part1(exampleInput1), 7 * 5);
        expect(Day10().part1(exampleInput2), 22 * 10);
      });

      test('solution', () => Day10().testPart1());
    });

    group('part 2', () {
      test('example', () {
        expect(Day10().part2(exampleInput1), 8);
        expect(Day10().part2(exampleInput2), 19208);
      });

      test('solution', () => Day10().testPart2());
    });
  });
}
