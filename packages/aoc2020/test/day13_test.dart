import 'package:aoc2020/src/day13.dart';
import 'package:test/test.dart';

main() {
  group('2020 Day 13', () {
    final exampleInput = '''
939
7,13,x,x,59,x,31,19''';

    group('part 1', () {
      test('example', () {
        expect(Day13().part1(exampleInput), 295);
      });

      test('solution', () => Day13().testPart1());
    });

    group('part 2', () {
      test('example', () {
        expect(Day13().part2(exampleInput), 1068781);
        expect(Day13().part2('\n17,x,13,19' ''), 3417);
        expect(Day13().part2('\n67,7,59,61'), 754018);
        expect(Day13().part2('\n67,x,7,59,61'), 779210);
        expect(Day13().part2('\n67,7,x,59,61'), 1261476);
        expect(Day13().part2('\n1789,37,47,1889'), 1202161486);
      });

      test('solution', () => Day13().testPart2());
    });
  });
}
