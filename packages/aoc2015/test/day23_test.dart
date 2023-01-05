import 'package:aoc2015/src/day23.dart';
import 'package:test/test.dart';

main() {
  group('2015 Day 23', () {
    group('part 1', () {
      test('examples', () {
        final exampleInput = '''
inc a
jio a, +2
tpl a
inc a''';
        final machine = Machine(Day23.instructions(exampleInput))..execute();
        expect(machine.registers[Register.a], 2); 
      });

      test('solution', () => Day23().testPart1());
    });

    group('part 2', () {
      test('solution', () => Day23().testPart2());
    });
  });
}
