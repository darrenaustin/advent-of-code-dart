import 'package:aoc2015/src/day21.dart';
import 'package:test/test.dart';

main() {
  group('2015 Day 21', () {
    group('part 1', () {
      test('examples', () {
        final player =
            Character(name: 'Player', hitPoints: 8, damage: 5, armor: 5);
        final boss =
            Character(name: 'Boss', hitPoints: 12, damage: 7, armor: 2);
        expect(player.winsBattle(boss), true);
      });

      test('solution', () => Day21().testPart1());
    });

    group('part 2', () {
      test('solution', () => Day21().testPart2());
    });
  });
}
