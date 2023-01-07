import 'package:aoc2016/src/day06.dart';
import 'package:test/test.dart';

main() {
  group('2016 Day 06', () {
    final exampleInput = '''
eedadn
drvtee
eandsr
raavrd
atevrs
tsrnev
sdttsa
rasrtv
nssdts
ntnada
svetve
tesnvt
vntsnd
vrdear
dvrsen
enarar''';

    group('part 1', () {
      test('example', () {
        expect(Day06().part1(exampleInput), 'easter'); 
      });

      test('solution', () => Day06().testPart1());
    });

    group('part 2', () {
      test('example', () {
        expect(Day06().part2(exampleInput), 'advent'); 
      });

      test('solution', () => Day06().testPart2());
    });
  });
}
