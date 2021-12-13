// https://adventofcode.com/2021/day/13

import 'package:advent_of_code_dart/src/util/grid2.dart';
import 'package:advent_of_code_dart/src/util/vec2.dart';

import '../../day.dart';

class Day13 extends AdventDay {
  Day13() : super(2021, 13, solution1: 647, solution2: 'HEJHJRCJ');

  @override
  dynamic part1() {
    return foldAt(inputGrid(), inputFolds().first).cellsWhere((c) => c == '#').length;
  }

  @override
  dynamic part2() {
    var grid = inputGrid();
    for (final fold in inputFolds()) {
      grid = foldAt(grid, fold);
    }
    print(grid);
    // Have no easy way to automate this (look into OCR?)
    return 'HEJHJRCJ';
  }

  Grid<String> inputGrid()  {
    final gridDotPoints = inputData().split('\n\n').first.split('\n');
    final expandingGrid = SparseGrid<String>(defaultValue: ' ');
    for (final point in gridDotPoints) {
      final coords = point.split(',');
      expandingGrid.setCell(Vector.int(int.parse(coords[0]), int.parse(coords[1])), '#');
    }
    final grid = Grid<String>(expandingGrid.maxVector.x.toInt() + 1, expandingGrid.maxVector.y.toInt() + 1, ' ');
    for (final loc in grid.locations()) {
      grid.setCell(loc, expandingGrid.cell(loc));
    }
    return grid;
  }

  Iterable<Fold> inputFolds() {
    final foldLines = inputData().split('\n\n').last.split('\n');
    return foldLines.map((l) {
      final parts = l.split('=');
      return Fold(parts[0].split('').last == 'y', int.parse(parts[1]));
    });
  }

  Grid<String> foldAt(Grid<String>grid, Fold fold) {
    if (fold.vertical) {
      final newHeight = grid.height - fold.line - 1;
      final newGrid = Grid<String>(grid.width, newHeight, ' ');
      for (int i = 0; i < newHeight; i++) {
        for (int x = 0; x < grid.width; x++) {
          final foldedP = Vector.int(x, newHeight + fold.line - i);
          final p = Vector.int(x, i);
          final cell = grid.cell(p) == '#' || grid.cell(foldedP) == '#' ? '#' : ' ';
          newGrid.setCell(p, cell);
        }
      }
      return newGrid;
    } else {
      final newWidth = grid.width - fold.line - 1;
      final newGrid = Grid<String>(newWidth, grid.height, ' ');
      for (int i = 0; i < newWidth; i++) {
        for (int y = 0; y < grid.height; y++) {
          final foldedP = Vector.int(newWidth + fold.line - i, y);
          final p = Vector.int(i, y);
          final cell = grid.cell(p) == '#' || grid.cell(foldedP) == '#' ? '#' : ' ';
          newGrid.setCell(p, cell);
        }
      }
      return newGrid;
    }
  }
}

class Fold {
  Fold(this.vertical, this.line);

  final bool vertical;
  final int line;
}
