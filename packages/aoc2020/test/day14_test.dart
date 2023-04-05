import 'package:aoc2020/src/day14.dart';
import 'package:test/test.dart';

main() {
  final exampleInput1 = '''
mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X
mem[8] = 11
mem[7] = 101
mem[8] = 0''';
  final exampleInput2 = '''
mask = 000000000000000000000000000000X1001X
mem[42] = 100
mask = 00000000000000000000000000000000X0XX
mem[26] = 1''';

  group('2020 Day 14', () {
    group('part 1', () {
      test('example', () {
        expect(Day14().part1(exampleInput1), 165);
      });

      test('solution', () => Day14().testPart1());
    });

    group('part 2', () {
      test('example', () {
        expect(Day14().part2(exampleInput2), 208);
      });

      test('solution', () => Day14().testPart2());
    });
  });
}
