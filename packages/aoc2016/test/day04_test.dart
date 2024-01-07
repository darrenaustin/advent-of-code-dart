import 'package:aoc2016/src/day04.dart';
import 'package:test/test.dart';

main() {
  group('2016 Day 04', () {
    group('part 1', () {
      test('examples', () {
        expect(Room.parse('aaaaa-bbb-z-y-x-123[abxyz]').isReal, true);
        expect(Room.parse('a-b-c-d-e-f-g-h-987[abcde]').isReal, true);
        expect(Room.parse('not-a-real-room-404[oarel]').isReal, true);
        expect(Room.parse('totally-real-room-200[decoy]').isReal, false);
      });

      test('solution', () => Day04().testPart1());
    });

    group('part 2', () {
      test('example', () {
        expect(Room.parse('qzmt-zixmtkozy-ivhz-343[zimth]').decryptedName(),
            'very encrypted name');
      });

      test('solution', () => Day04().testPart2());
    });
  });
}
