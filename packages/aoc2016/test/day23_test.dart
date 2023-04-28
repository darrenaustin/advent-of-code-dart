import 'package:aoc/util/string.dart';
import 'package:aoc2016/src/assembunny.dart';
import 'package:aoc2016/src/day23.dart';
import 'package:test/test.dart';

main() {
  group('2016 Day 23', () {
    group('part 1', () {
      test('example', () {
        final exampleInput = '''
cpy 2 a
tgl a
tgl a
tgl a
cpy 1 a
dec a
dec a''';
        final machine = Assembunny(exampleInput.lines);
        machine.execute();
        expect(machine.registers['a'], 3);
      });

      test('solution', () => Day23().testPart1());
    });

    group('part 2', () {
      test('solution', () => Day23().testPart2());
    });
  });
}
