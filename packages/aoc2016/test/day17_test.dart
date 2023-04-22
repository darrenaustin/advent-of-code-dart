import 'package:aoc2016/src/day17.dart';
import 'package:test/test.dart';

main() {
  group('2016 Day 17', () {
    group('part 1', () {
      test('examples', () {
        expect(Day17().part1('ihgpwlah'), 'DDRRRD');
        expect(Day17().part1('kglvqrro'), 'DDUDRLRRUDRD');
        expect(Day17().part1('ulqzkmiv'), 'DRURDRUDDLLDLUURRDULRLDUUDDDRR');
      });

      test('solution', () => Day17().testPart1());
    });

    group('part 2', () {
      test('examples', () {
        expect(Day17().part2('ihgpwlah'), 370);
        expect(Day17().part2('kglvqrro'), 492);
        expect(Day17().part2('ulqzkmiv'), 830);
      });

      test('solution', () => Day17().testPart2());
    });
  });
}
