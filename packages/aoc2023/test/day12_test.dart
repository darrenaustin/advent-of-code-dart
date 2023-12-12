import 'package:aoc2023/src/day12.dart';
import 'package:test/test.dart';

main() {
  group('2023 Day 12', () {
    final String exampleInput = '''
???.### 1,1,3
.??..??...?##. 1,1,3
?#?#?#?#?#?#?#? 1,3,1,6
????.#...#... 4,1,1
????.######..#####. 1,6,5
?###???????? 3,2,1''';

    group('part 1', () {
      test('example', () {
        expect(Day12().part1(exampleInput), 21);
      });

      test('solution', () => Day12().testPart1());
    });

    group('part 2', () {
      test('example', () {
        expect(Day12().part2(exampleInput), 525152);
      });

      test('solution', () => Day12().testPart2());
    });
  });
}
