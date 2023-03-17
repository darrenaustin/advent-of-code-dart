import 'package:aoc2022/src/day01.dart';
import 'package:test/test.dart';

main() {
  group('2022 Day 01', () {
    final String exampleInput = '''
1000
2000
3000

4000

5000
6000

7000
8000
9000

10000''';

    group('part 1', () {
      test('example', () {
        expect(Day01().part1(exampleInput), 24000);
      });

      test('solution', () => Day01().testPart1());
    });

    group('part 2', () {
      test('examples', () {
        expect(Day01().part2(exampleInput), 45000);
      });

      test('solution', () => Day01().testPart2());
    });
  });
}
