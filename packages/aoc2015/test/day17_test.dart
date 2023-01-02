import 'package:aoc2015/src/day17.dart';
import 'package:test/test.dart';

main() {
  group('2015 Day 17', () {
    group('part 1', () {
      test('example', () {
        expect(Day17.containersThatSumTo([5, 5, 10, 15, 20], 25).length, 4);
      });

      test('solution', () => Day17().testPart1());
    });

    group('part 2', () {
      test('example', () {
        expect(Day17.numMinFill([5, 5, 10, 15, 20], 25), 3);
      });

      test('solution', () => Day17().testPart2());
    });
  });
}
