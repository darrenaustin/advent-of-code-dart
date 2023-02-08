import 'package:aoc2021/src/day07.dart';
import 'package:test/test.dart';

main() {
  group('2021 Day 07', () {
    final exampleInput = '16,1,2,0,4,2,7,1,2,14';
    group('part 1', () {
      test('examples', () {
        final crabs = Day07.parseCrabs(exampleInput);
        expect(Day07.fuelUsed(crabs, 1), 41);
        expect(Day07.fuelUsed(crabs, 2), 37);
        expect(Day07.fuelUsed(crabs, 3), 39);
        expect(Day07.fuelUsed(crabs, 10), 71);
      });

      test('solution', () => Day07().testPart1());
    });

    group('part 2', () {
      test('examples', () {
        final crabs = Day07.parseCrabs(exampleInput);
        expect(Day07.acceleratingFuelUsed(crabs, 5), 168);
        expect(Day07.acceleratingFuelUsed(crabs, 2), 206);
      });

      test('solution', () => Day07().testPart2());
    });
  });
}
