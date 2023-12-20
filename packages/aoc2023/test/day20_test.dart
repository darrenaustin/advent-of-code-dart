import 'package:aoc2023/src/day20.dart';
import 'package:test/test.dart';

main() {
  group('2023 Day 20', () {
    final exampleInput1 = '''
broadcaster -> a, b, c
%a -> b
%b -> c
%c -> inv
&inv -> a''';
    final exampleInput2 = '''
broadcaster -> a
%a -> inv, con
&inv -> b
%b -> con
&con -> output''';

    group('part 1', () {
      test('example', () {
        expect(Day20().part1(exampleInput1), 32000000);
        expect(Day20().part1(exampleInput2), 11687500);
      });

      test('solution', () => Day20().testPart1());
    });

    group('part 2', () {
      test('solution', () => Day20().testPart2());
    });
  });
}
