import 'package:aoc2019/src/day01.dart';
import 'package:test/test.dart';

main() {
  group('2019 Day 01', () {
    group('part 1', () {
      test('examples', () {
        expect(Day01.fuelFor(12), 2); 
        expect(Day01.fuelFor(14), 2); 
        expect(Day01.fuelFor(1969), 654); 
        expect(Day01.fuelFor(100756), 33583); 
      });

      test('solution', () => Day01().testPart1());
    });

    group('part 2', () {
      test('examples', () {
        expect(Day01.totalFuelFor(14), 2);
        expect(Day01.totalFuelFor(1969), 966);
        expect(Day01.totalFuelFor(100756), 50346);
      });

      test('solution', () => Day01().testPart2());
    });
  });
}
