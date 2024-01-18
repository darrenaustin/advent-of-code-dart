// https://adventofcode.com/2023/day/16

import 'package:aoc/aoc.dart';
import 'package:aoc/util/collection.dart';
import 'package:aoc/util/grid2.dart';
import 'package:aoc/util/vec2.dart';
import 'package:collection/collection.dart';

main() => Day16().solve();

class Day16 extends AdventDay {
  Day16() : super(2023, 16, name: 'The Floor Will Be Lava');

  @override
  dynamic part1(String input) =>
      energizedBy(Grid.fromString(input), Vec2.zero, Dir.right);

  @override
  dynamic part2(String input) {
    final grid = Grid.fromString(input);
    return <(Vec2, Dir)>[
      for (int x = 1; x < grid.width - 1; x++) ...[
        (Vec2.int(x, 0), Dir.down),
        (Vec2.int(x, grid.height - 1), Dir.up)
      ],
      for (int y = 1; y < grid.height - 1; y++) ...[
        (Vec2.int(0, y), Dir.right),
        (Vec2.int(grid.width - 1, y), Dir.left)
      ],
      (Vec2.zero, Dir.down),
      (Vec2.zero, Dir.right),
      (Vec2.int(grid.width - 1, 0), Dir.down),
      (Vec2.int(grid.width - 1, 0), Dir.left),
      (Vec2.int(0, grid.height - 1), Dir.up),
      (Vec2.int(0, grid.height - 1), Dir.left),
      (Vec2.int(grid.width - 1, grid.height - 1), Dir.up),
      (Vec2.int(grid.width - 1, grid.height - 1), Dir.right),
    ].map((s) => energizedBy(grid, s.$1, s.$2)).max;
  }

  int energizedBy(Grid<String> grid, Vec2 pos, Dir dir) {
    final energized = <Vec2>{};
    final seenBeams = <(Vec2, Dir)>{};
    final beams = {(pos, dir)};
    while (beams.isNotEmpty) {
      final beam = beams.removeFirst();
      if (!seenBeams.add(beam)) {
        continue;
      }

      final (pos, dir) = beam;
      if (grid.validCell(pos)) {
        energized.add(pos);
        final newDirs = switch (grid.cell(pos)) {
          '.' => [dir],
          '/' => switch (dir) {
              Dir.left => [Dir.down],
              Dir.right => [Dir.up],
              Dir.up => [Dir.right],
              Dir.down => [Dir.left],
            },
          '\\' => switch (dir) {
              Dir.left => [Dir.up],
              Dir.right => [Dir.down],
              Dir.up => [Dir.left],
              Dir.down => [Dir.right],
            },
          '-' => switch (dir) {
              Dir.up => [Dir.left, Dir.right],
              Dir.down => [Dir.left, Dir.right],
              Dir.left => [Dir.left],
              Dir.right => [Dir.right],
            },
          '|' => switch (dir) {
              Dir.up => [Dir.up],
              Dir.down => [Dir.down],
              Dir.left => [Dir.up, Dir.down],
              Dir.right => [Dir.up, Dir.down],
            },
          _ => throw Exception('Unknown tile: \'${grid.cell(pos)}\' at $pos')
        };
        for (final d in newDirs) {
          beams.add((pos + d.vec, d));
        }
      }
    }
    return energized.length;
  }
}

enum Dir {
  up(Vec2.up),
  down(Vec2.down),
  left(Vec2.left),
  right(Vec2.right);

  final Vec2 vec;

  const Dir(this.vec);
}
