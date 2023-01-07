import 'package:aoc2016/src/day03.dart';
import 'package:test/test.dart';

main() {
  group('2016 Day 03', () {
    group('part 1', () {
      test('example', () {
        expect(Day03().part1('5 10 25'), 0); 
      });

      test('solution', () => Day03().testPart1());
    });

    group('part 2', () {
      test('example', () {
        final exampleInput = '''
101 301 501
102 302 502
103 303 503
201 401 601
202 402 602
203 403 603''';
        expect(Day03().part2(exampleInput), 6); 
      });

      test('solution', () => Day03().testPart2());
    });
  });
}
