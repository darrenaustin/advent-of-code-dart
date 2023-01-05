import 'package:aoc2015/src/day25.dart';
import 'package:test/test.dart';

main() {
  group('2015 Day 25', () {
    group('part 1', () {
      test('examples', () {
        final day = Day25();
        expect(day.codeAt(20151125, 2, 1), 31916031);
        expect(day.codeAt(20151125, 3, 1), 16080970);
        expect(day.codeAt(20151125, 4, 1), 24592653);
        expect(day.codeAt(20151125, 5, 1), 77061);
        expect(day.codeAt(20151125, 6, 1), 33071741);
        expect(day.codeAt(20151125, 1, 2), 18749137);
        expect(day.codeAt(20151125, 2, 2), 21629792);
        expect(day.codeAt(20151125, 3, 2), 8057251);
        expect(day.codeAt(20151125, 4, 2), 32451966);
        expect(day.codeAt(20151125, 5, 2), 17552253);
        expect(day.codeAt(20151125, 6, 2), 6796745);
        expect(day.codeAt(20151125, 1, 3), 17289845);
        expect(day.codeAt(20151125, 2, 3), 16929656);
        expect(day.codeAt(20151125, 3, 3), 1601130);
        expect(day.codeAt(20151125, 4, 3), 21345942);
        expect(day.codeAt(20151125, 5, 3), 28094349);
        expect(day.codeAt(20151125, 6, 3), 25397450);
      });

      test('solution', () => Day25().testPart1());
    });

    group('part 2', () {
      test('solution', () => Day25().testPart2());
    });
  });
}
