import 'package:aoc/util/string.dart';
import 'package:aoc2020/src/day05.dart';
import 'package:test/test.dart';

main() {
  group('2020 Day 05', () {
    group('Seat ID', () {
      test('row', () {
        expect(Day05.partitionValue('FBFBBFF'.chars, 'F', 'B', 128), 44);
      });
      test('column', () {
        expect(Day05.partitionValue('RLR'.chars, 'L', 'R', 8), 5);
      });

      test('seats', () {
        expect(Day05.seatId('BFFFBBFRRR'), 567);
        expect(Day05.seatId('FFFBBBFRRR'), 119);
        expect(Day05.seatId('BBFFBBFRLL'), 820);
      });
    });

    group('part 1', () {
      test('solution', () => Day05().testPart1());
    });

    group('part 2', () {
      test('solution', () => Day05().testPart2());
    });
  });
}
