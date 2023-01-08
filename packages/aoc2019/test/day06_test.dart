import 'package:aoc2019/src/day06.dart';
import 'package:test/test.dart';

main() {
  group('2019 Day 06', () {
    group('part 1', () {
      test('example', () {
        final exampleInput = '''
COM)B
B)C
C)D
D)E
E)F
B)G
G)H
D)I
E)J
J)K
K)L''';
        expect(Day06().part1(exampleInput), 42); 
      });

      test('solution', () => Day06().testPart1());
    });

    group('part 2', () {
      test('example', () {
        final exampleInput = '''
COM)B
B)C
C)D
D)E
E)F
B)G
G)H
D)I
E)J
J)K
K)L
K)YOU
I)SAN''';
        expect(Day06().part2(exampleInput), 4); 
      });

      test('solution', () => Day06().testPart2());
    });
  });
}
