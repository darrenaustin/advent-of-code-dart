import 'package:aoc2020/src/day08.dart';
import 'package:test/test.dart';

main() {
  group('2020 Day 08', () {
    final exampleInput = '''
nop +0
acc +1
jmp +4
acc +3
jmp -3
acc -99
acc +1
jmp -4
acc +6''';

    group('part 1', () {
      test('example', () {
        expect(Day08().part1(exampleInput), 5);
      });

      test('solution', () => Day08().testPart1());
    });

    group('part 2', () {
      test('example', () {
        expect(Day08().part2(exampleInput), 8);
      });

      test('solution', () => Day08().testPart2());
    });
  });
}
