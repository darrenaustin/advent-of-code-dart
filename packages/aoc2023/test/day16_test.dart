import 'package:aoc2023/src/day16.dart';
import 'package:test/test.dart';

main() {
  group('2023 Day 16', () {
    final exampleInput = '''
    ''';

    group('part 1', () {
      test('example', () {
        expect(Day16().part1(exampleInput), 0); 
      });

      test('solution', () => Day16().testPart1());
    });

    group('part 2', () {
      test('example', () {
        expect(Day16().part2(exampleInput), 0); 
      });

      test('solution', () => Day16().testPart2());
    });
  });
}
