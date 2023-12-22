import 'package:aoc2023/src/day22.dart';
import 'package:test/test.dart';

main() {
  group('2023 Day 22', () {
    final exampleInput = '''
1,0,1~1,2,1
0,0,2~2,0,2
0,2,3~2,2,3
0,0,4~0,2,4
2,0,5~2,2,5
0,1,6~2,1,6
1,1,8~1,1,9''';

    group('part 1', () {
      test('example', () {
        expect(Day22().part1(exampleInput), 5);
      });

      test('solution', () => Day22().testPart1());
    });

    group('part 2', () {
      test('example', () {
        expect(Day22().part2(exampleInput), 7);
      });

      test('solution', () => Day22().testPart2());
    });
  });
}
