// https://adventofcode.com/2021/day/13

import 'package:aoc/aoc.dart';
import 'package:aoc/util/sparse_grid.dart';
import 'package:aoc/util/vec.dart';

main() => Day13().solve();

class Day13 extends AdventDay {
  Day13() : super(2021, 13, name: 'Transparent Origami');

  @override
  dynamic part1(String input) {
    final folds = parseFolds(input);
    return parseDotCoords(input)
        .map((d) => foldDot(d, folds.first))
        .toSet()
        .length;
  }

  @override
  dynamic part2(String input) {
    final foldedDots = parseFolds(input).fold(parseDotCoords(input),
        (dots, fold) => dots.map((d) => foldDot(d, fold)).toSet());
    printDots(foldedDots);

    // Have no easy way to automate this (look into OCR?)
    return 'HEJHJRCJ';
  }

  Iterable<Vec2> parseDotCoords(String input) =>
      input.split('\n\n').first.split('\n').map((l) {
        final coords = l.split(',');
        return Vec2.int(int.parse(coords[0]), int.parse(coords[1]));
      });

  Iterable<Fold> parseFolds(String input) {
    final foldLines = input.split('\n\n').last.split('\n');
    return foldLines.map((l) {
      final parts = l.split('=');
      return Fold(parts[0].split('').last == 'y', int.parse(parts[1]));
    });
  }

  Vec2 foldDot(Vec2 dot, Fold fold) {
    if (fold.vertical) {
      return (dot.y < fold.line) ? dot : Vec2(dot.x, 2 * fold.line - dot.y);
    } else {
      return (dot.x < fold.line) ? dot : Vec2(2 * fold.line - dot.x, dot.y);
    }
  }

  void printDots(Iterable<Vec2> dots) {
    final grid = SparseGrid(defaultValue: ' ');
    for (final dot in dots) {
      grid.setCell(dot, '#');
    }
    print(grid);
  }
}

class Fold {
  Fold(this.vertical, this.line);

  final bool vertical;
  final int line;
}
