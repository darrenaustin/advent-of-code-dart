import 'package:aoc2016/src/day16.dart';
import 'package:test/test.dart';

main() {
  group('2016 Day 16', () {
    group('Dragon Curve', () {
      test('sequence', () {
        expect(Day16().next('1'), '100');
        expect(Day16().next('0'), '001');
        expect(Day16().next('0'), '001');
        expect(Day16().next('11111'), '11111000000');
        expect(Day16().next('111100001010'), '1111000010100101011110000');
      });
      test('checksum', () {
        expect(Day16().checksum('110010110100'), '100');
      });
    });


    group('part 1', () {
      test('example', () {
        expect(Day16().part1('10000', 20), '01100');
      });

      test('solution', () => Day16().testPart1());
    });

    group('part 2', () {
      // test('example', () {
      //   expect(Day16().part2(exampleInput), 0);
      // });

      test('solution', () => Day16().testPart2());
    });
  });
}
