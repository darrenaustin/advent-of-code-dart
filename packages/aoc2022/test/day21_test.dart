import 'package:aoc2022/src/day21.dart';
import 'package:test/test.dart';

main() {
  group('2022 Day 21', () {
    final exampleInput = '''
root: pppw + sjmn
dbpl: 5
cczh: sllz + lgvd
zczc: 2
ptdq: humn - dvpt
dvpt: 3
lfqf: 4
humn: 5
ljgn: 2
sjmn: drzm * dbpl
sllz: 4
pppw: cczh / lfqf
lgvd: ljgn * ptdq
drzm: hmdt - zczc
hmdt: 32''';

    group('part 1', () {
      test('example', () {
        expect(Day21().part1(exampleInput), 152);
      });

      test('solution', () => Day21().testPart1());
    });

    group('part 2', () {
      test('example', () {
        expect(Day21().part2(exampleInput), 301);
      });

      test('solution', () => Day21().testPart2());
    });
  });
}
