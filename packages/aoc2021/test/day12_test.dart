import 'package:aoc2021/src/day12.dart';
import 'package:test/test.dart';

main() {
  group('2021 Day 12', () {
    final smallExampleInput = '''
start-A
start-b
A-c
A-b
b-d
A-end
b-end''';
    final mediumExampleInput = '''
dc-end
HN-start
start-kj
dc-start
dc-HN
LN-dc
HN-end
kj-sa
kj-HN
kj-dc''';
    final largeExampleInput = '''
fs-end
he-DX
fs-he
start-DX
pj-DX
end-zg
zg-sl
zg-pj
pj-he
RW-he
fs-DX
pj-RW
zg-RW
start-pj
he-WI
zg-he
pj-fs
start-RW''';

    group('part 1', () {
      test('examples', () {
        expect(Day12().part1(smallExampleInput), 10);
        expect(Day12().part1(mediumExampleInput), 19);
        expect(Day12().part1(largeExampleInput), 226);
      });

      test('solution', () => Day12().testPart1());
    });

    group('part 2', () {
      test('examples', () {
        expect(Day12().part2(smallExampleInput), 36);
        expect(Day12().part2(mediumExampleInput), 103);
        expect(Day12().part2(largeExampleInput), 3509);
      });

      test('solution', () => Day12().testPart2());
    });
  });
}
