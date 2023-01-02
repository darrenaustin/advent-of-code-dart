import 'package:aoc/util/string.dart';
import 'package:aoc2015/src/day14.dart';
import 'package:test/test.dart';

main() {
  group('20155 Day 14', () {
    final exampleInput = '''
Comet can fly 14 km/s for 10 seconds, but then must rest for 127 seconds.
Dancer can fly 16 km/s for 11 seconds, but then must rest for 162 seconds.''';

    group('part 1', () {
      test('examples', () {
        final reindeer = exampleInput.lines.map(Reindeer.parse).toList();
        expect(reindeer[0].distance(1000), 1120);
        expect(reindeer[1].distance(1000), 1056);
      });

      test('solution', () => Day14().testPart1());
    });

    group('part 2', () {
      test('examples', () {
        final reindeer = exampleInput.lines.map(Reindeer.parse).toList();
        expect(Day14.winningScore(reindeer, 1000), 689);
      });

      test('solution', () => Day14().testPart2());
    });
  });
}