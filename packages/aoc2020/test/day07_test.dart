import 'package:aoc2020/src/day07.dart';
import 'package:test/test.dart';

main() {
  group('2020 Day 07', () {
    final exampleInput1 = '''
light red bags contain 1 bright white bag, 2 muted yellow bags.
dark orange bags contain 3 bright white bags, 4 muted yellow bags.
bright white bags contain 1 shiny gold bag.
muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.
shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.
dark olive bags contain 3 faded blue bags, 4 dotted black bags.
vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
faded blue bags contain no other bags.
dotted black bags contain no other bags.''';
    final exampleInput2 = '''
shiny gold bags contain 2 dark red bags.
dark red bags contain 2 dark orange bags.
dark orange bags contain 2 dark yellow bags.
dark yellow bags contain 2 dark green bags.
dark green bags contain 2 dark blue bags.
dark blue bags contain 2 dark violet bags.
dark violet bags contain no other bags.''';

    group('part 1', () {
      test('example', () {
        expect(Day07().part1(exampleInput1), 4);
      });

      test('solution', () => Day07().testPart1());
    });

    group('part 2', () {
      test('examples', () {
        expect(Day07().part2(exampleInput1), 32);
        expect(Day07().part2(exampleInput2), 126);
      });

      test('solution', () => Day07().testPart2());
    });
  });
}
