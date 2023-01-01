import 'package:aoc2015/src/day07.dart';
import 'package:test/test.dart';

main() {
  group('2015 Day 07', () {
    group('part 1', () {
      test('examples', () {
        final exampleCircuit = Day07.circuit('''
123 -> x
456 -> y
x AND y -> d
x OR y -> e
x LSHIFT 2 -> f
y RSHIFT 2 -> g
NOT x -> h
NOT y -> i''');
        expect(Day07.signal('d', exampleCircuit), 72);
        expect(Day07.signal('e', exampleCircuit), 507);
        expect(Day07.signal('f', exampleCircuit), 492);
        expect(Day07.signal('g', exampleCircuit), 114);
        expect(Day07.signal('h', exampleCircuit), 65412);
        expect(Day07.signal('i', exampleCircuit), 65079);
        expect(Day07.signal('x', exampleCircuit), 123);
        expect(Day07.signal('y', exampleCircuit), 456);
      });

      test('solution', () {
        final day = Day07();
        expect(day.part1(day.input()), day.solution1); 
      });
    });

    group('part 2', () {
      test('solution', () {
        final day = Day07();
        expect(day.part2(day.input()), day.solution2); 
      });
    });
  });
}