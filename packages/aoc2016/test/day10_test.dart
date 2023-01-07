import 'package:aoc/util/string.dart';
import 'package:aoc2016/src/day10.dart';
import 'package:test/test.dart';

main() {
  group('2016 Day 10', () {
    group('part 1', () {
      test('example', () {
        final exampleInput = '''
value 5 goes to bot 2
bot 2 gives low to bot 1 and high to bot 0
value 3 goes to bot 1
bot 1 gives low to output 1 and high to bot 0
bot 0 gives low to output 2 and high to output 0
value 2 goes to bot 2''';
        expect(Factory(exampleInput.lines).runInstructions(<int>{2, 5}), 2);
      });

      test('solution', () => Day10().testPart1());
    });

    group('part 2', () {
      test('solution', () => Day10().testPart2());
    });
  });
}
