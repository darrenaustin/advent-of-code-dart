import 'package:aoc2016/src/day12.dart';
import 'package:test/test.dart';

main() {
  group('2016 Day 12', () {
    group('part 1', () {
      test('example', () {
        final exampleInput = '''
cpy 41 a
inc a
inc a
dec a
jnz a 2
dec a''';
        expect(Day12().part1(exampleInput), 42); 
      });

      test('solution', () => Day12().testPart1());
    });

    group('part 2', () {
      test('solution', () => Day12().testPart2());
    });
  });
}
