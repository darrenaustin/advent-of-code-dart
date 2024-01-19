import 'package:aoc2017/src/day10.dart';
import 'package:test/test.dart';

main() {
  group('2017 Day 10', () {
    final exampleInput = '''
3, 4, 1, 5''';

    group('part 1', () {
      test('example', () {
        expect(Day10().part1(exampleInput, 5), 12);
      });

      test('solution', () => Day10().testPart1());
    });

    group('part 2', () {
      test('example', () {
        expect(Day10().part2(''), 'a2582a3a0e66e6e86e3812dcb672a272');
        expect(Day10().part2('AoC 2017'), '33efeb34ea91902bb2f59c9920caa6cd');
        expect(Day10().part2('1,2,3'), '3efbe78a8d82f29979031a4aa0b16a9d');
        expect(Day10().part2('1,2,4'), '63960835bcdc130f0b66d7ff4f6a5a8e');
      });

      test('solution', () => Day10().testPart2());
    });
  });
}
