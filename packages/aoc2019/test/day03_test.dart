import 'package:aoc2019/src/day03.dart';
import 'package:test/test.dart';

main() {
  group('2019 Day 03', () {
    final exampleInput1 = '''
R8,U5,L5,D3
U7,R6,D4,L4''';
    final exampleInput2 = '''
R75,D30,R83,U83,L12,D49,R71,U7,L72
U62,R66,U55,R34,D71,R55,D58,R83''';
    final exampleInput3 = '''
R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51
U98,R91,D20,R16,D67,R40,U7,R15,U6,R7''';

    group('part 1', () {
      test('examples', () {
        expect(Day03().part1(exampleInput1), 6);
        expect(Day03().part1(exampleInput2), 159);
        expect(Day03().part1(exampleInput3), 135);
      });

      test('solution', () => Day03().testPart1());
    });

    group('part 2', () {
      test('examples', () {
        expect(Day03().part2(exampleInput1), 30);
        expect(Day03().part2(exampleInput2), 610);
        expect(Day03().part2(exampleInput3), 410);
      });

      test('solution', () => Day03().testPart2());
    });
  });
}
