import 'package:aoc2021/src/day13.dart';
import 'package:test/test.dart';

main() {
  group('2021 Day 13', () {
    group('part 1', () {
      final exampleInput = '''
6,10
0,14
9,10
0,3
10,4
4,11
6,0
6,12
4,1
0,13
10,12
3,4
3,0
8,4
1,10
2,14
8,10
9,0

fold along y=7
fold along x=5''';

      test('example', () {
        expect(Day13().part1(exampleInput), 17);
      });

      test('solution', () => Day13().testPart1());
    });

    group('part 2', () {
      // test('examples', () {
      //   expect(Day13().part2(''), 0);
      // });

      test('solution', () => Day13().testPart2());
    });
  });
}
