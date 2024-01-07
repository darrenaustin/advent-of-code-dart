import 'package:aoc2015/src/day15.dart';
import 'package:test/test.dart';

main() {
  group('2015 Day 15', () {
    final exampleInput = '''
Butterscotch: capacity -1, durability -2, flavor 6, texture 3, calories 8
Cinnamon: capacity 2, durability 3, flavor -2, texture -1, calories 3''';

    group('part 1', () {
      test('examples', () {
        final ingredients = Day15.inputIngredients(exampleInput);
        expect(Day15.cookieScore(ingredients, [44, 56]), 62842880);
        expect(Day15().part1(exampleInput), 62842880);
      });

      test('solution', () => Day15().testPart1());
    });

    group('part 2', () {
      test('examples', () {
        final ingredients = Day15.inputIngredients(exampleInput);
        expect(Day15.calories(ingredients, [40, 60]), 500);
        expect(Day15.cookieScore(ingredients, [40, 60]), 57600000);
        expect(Day15().part2(exampleInput), 57600000);
      });

      test('solution', () => Day15().testPart2());
    });
  });
}
