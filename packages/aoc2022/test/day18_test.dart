import 'package:aoc2022/src/day18.dart';
import 'package:test/test.dart';

main() {
  group('2022 Day 18', () {
    final exampleInput = '''
2,2,2
1,2,2
3,2,2
2,1,2
2,3,2
2,2,1
2,2,3
2,2,4
2,2,6
1,2,5
3,2,5
2,1,5
2,3,5''';

    group('part 1', () {
      test('example', () {
        expect(Day18().part1(exampleInput), 64);
      });

      test('solution', () => Day18().testPart1());
    });

    group('part 2', () {
      test('example', () {
        expect(Day18().part2(exampleInput), 58);
      });

      test('solution', () => Day18().testPart2());
    });
  });
}
