import 'package:aoc2016/src/day22.dart';
import 'package:test/test.dart';

main() {
  group('2016 Day 22', () {
    group('part 1', () {
      test('solution', () => Day22().testPart1());
    });

    group('part 2', () {
      final exampleInput = '''
root@ebhq-gridcenter# df -h
Filesystem            Size  Used  Avail  Use%
/dev/grid/node-x0-y0   10T    8T     2T   80%
/dev/grid/node-x0-y1   11T    6T     5T   54%
/dev/grid/node-x0-y2   32T   28T     4T   87%
/dev/grid/node-x1-y0    9T    7T     2T   77%
/dev/grid/node-x1-y1    8T    0T     8T    0%
/dev/grid/node-x1-y2   11T    7T     4T   63%
/dev/grid/node-x2-y0   10T    6T     4T   60%
/dev/grid/node-x2-y1    9T    8T     1T   88%
/dev/grid/node-x2-y2    9T    6T     3T   66%''';
      test('example', () {
        expect(Day22().part2(exampleInput), 7);
      });

      test('solution', () => Day22().testPart2());
    });
  });
}
