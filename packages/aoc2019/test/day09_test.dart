import 'package:aoc2019/src/day09.dart';
import 'package:aoc2019/src/intcode.dart';
import 'package:test/test.dart';

main() {
  group('2019 Day 09', () {
    group('part 1', () {
      test('example1', () {
        final exampleInput = '109,1,204,-1,1001,100,1,100,1008,100,16,101,1006,101,0,99';
        final machine = Intcode.from(program: exampleInput);
        while (!machine.execute()) {}
        final output = machine.output.join(',');
        expect(output, exampleInput);
      });

      test('example2', () {
        final exampleInput = '1102,34915192,34915192,7,4,7,99,0';
        final machine = Intcode.from(program: exampleInput);
        while (!machine.execute()) {}
        final output = machine.output.single;
        expect(output.toString().length, 16);
      });

      test('example3', () {
        final exampleInput = '104,1125899906842624,99';
        final machine = Intcode.from(program: exampleInput);
        while (!machine.execute()) {}
        final output = machine.output.single;
        expect(output, 1125899906842624);
      });

      test('solution', () => Day09().testPart1());
    });

    group('part 2', () {
      test('solution', () => Day09().testPart2());
    });
  });
}
