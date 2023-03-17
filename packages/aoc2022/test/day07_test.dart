import 'package:aoc2022/src/day07.dart';
import 'package:test/test.dart';

main() {
  group('2022 Day 07', () {
    final exampleInput = r'''
$ cd /
$ ls
dir a
14848514 b.txt
8504156 c.dat
dir d
$ cd a
$ ls
dir e
29116 f
2557 g
62596 h.lst
$ cd e
$ ls
584 i
$ cd ..
$ cd ..
$ cd d
$ ls
4060174 j
8033020 d.log
5626152 d.ext
7214296 k''';
    group('part 1', () {
      test('example', () {
        expect(Day07().part1(exampleInput), 95437);
      });

      test('solution', () => Day07().testPart1());
    });

    group('part 2', () {
      test('examples', () {
        expect(Day07().part2(exampleInput), 24933642);
      });

      test('solution', () => Day07().testPart2());
    });
  });
}
