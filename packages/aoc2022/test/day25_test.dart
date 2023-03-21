import 'package:aoc2022/src/day25.dart';
import 'package:test/test.dart';

main() {
  group('2022 Day 25', () {
    final exampleInput = '''
1=-0-2
12111
2=0=
21
2=01
111
20012
112
1=-1=
1-12
12
1=
122''';

    group('SNAFU', () {
      test('decimal to SNAFU', () {
        expect(Day25.intSnafu(1), '1');
        expect(Day25.intSnafu(2), '2');
        expect(Day25.intSnafu(3), '1=');
        expect(Day25.intSnafu(4), '1-');
        expect(Day25.intSnafu(5), '10');
        expect(Day25.intSnafu(6), '11');
        expect(Day25.intSnafu(7), '12');
        expect(Day25.intSnafu(8), '2=');
        expect(Day25.intSnafu(9), '2-');
        expect(Day25.intSnafu(10), '20');
        expect(Day25.intSnafu(15), '1=0');
        expect(Day25.intSnafu(20), '1-0');
        expect(Day25.intSnafu(2022), '1=11-2');
        expect(Day25.intSnafu(12345), '1-0---0');
        expect(Day25.intSnafu(314159265), '1121-1110-1=0');
      });

      test('SNAFU to decimal', () {
        expect(Day25.snafuInt('1=-0-2'), 1747);
        expect(Day25.snafuInt('12111'), 906);
        expect(Day25.snafuInt('2=0='), 198);
        expect(Day25.snafuInt('21'), 11);
        expect(Day25.snafuInt('2=01'), 201);
        expect(Day25.snafuInt('111'), 31);
        expect(Day25.snafuInt('20012'), 1257);
        expect(Day25.snafuInt('112'), 32);
        expect(Day25.snafuInt('1=-1='), 353);
        expect(Day25.snafuInt('1-12'), 107);
        expect(Day25.snafuInt('12'), 7);
        expect(Day25.snafuInt('1='), 3);
        expect(Day25.snafuInt('122'), 37);
      });
    });

    group('part 1', () {
      test('example', () {
        expect(Day25().part1(exampleInput), '2=-1=0');
      });

      test('solution', () => Day25().testPart1());
    });

    group('part 2', () {
      test('solution', () => Day25().testPart2());
    });
  });
}
