import 'package:aoc2017/src/day07.dart';
import 'package:test/test.dart';

main() {
  group('2017 Day 07', () {
    final exampleInput = '''
pbga (66)
xhth (57)
ebii (61)
havc (66)
ktlj (57)
fwft (72) -> ktlj, cntj, xhth
qoyq (66)
padx (45) -> pbga, havc, qoyq
tknk (41) -> ugml, padx, fwft
jptl (61)
ugml (68) -> gyxo, ebii, jptl
gyxo (61)
cntj (57)''';

    group('part 1', () {
      test('example', () {
        expect(Day07().part1(exampleInput), 'tknk');
      });

      test('solution', () => Day07().testPart1());
    });

    group('part 2', () {
      test('example', () {
        expect(Day07().part2(exampleInput), 60);
      });

      test('solution', () => Day07().testPart2());
    });
  });
}
