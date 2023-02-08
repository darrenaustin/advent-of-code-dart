import 'package:aoc2021/src/day10.dart';
import 'package:test/test.dart';

main() {
  group('2021 Day 10', () {
    final exampleInput = '''
[({(<(())[]>[[{[]{<()<>>
[(()[<>])]({[<{<<[]>>(
{([(<{}[<>[]}>{[]{[(<()>
(((({<>}<{<{<>}{[]{[]{}
[[<[([]))<([[{}[[()]]]
[{[{({}]{}}([{[{{{}}([]
{<[[]]>}<{[{[{[]{()[[[]
[<(<(<(<{}))><([]([]()
<{([([[(<>()){}]>(<<{{
<{([{{}}[<[[[<>{}]]]>[]]''';

    group('part 1', () {
      test('example', () {
        expect(Day10().part1(exampleInput), 26397);
      });

      test('solution', () => Day10().testPart1());
    });

    group('part 2', () {
      test('example', () {
        expect(Day10().part2(exampleInput), 288957);
      });

      test('solution', () => Day10().testPart2());
    });
  });
}
