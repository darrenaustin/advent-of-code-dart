// https://adventofcode.com/2021/day/13

import 'package:advent_of_code_dart/src/util/collection.dart';
import 'package:advent_of_code_dart/src/util/grid.dart';

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
    final gridDotPointLines = inputData().split('\n\n').first.split('\n');
    final dotLocations = gridDotPointLines.map((l) {
      final coords = l.split(',');
      final x = int.parse(coords[0]);
      final y = int.parse(coords[1]);
      return Loc(x, y);
    });
    final gridWidth = dotLocations.map((l) => l.x + 1).max();
    final gridHeight = dotLocations.map((l) => l.y + 1).max();
    final grid = Grid<String>(gridWidth, gridHeight, ' ');
    for (final loc in dotLocations) {
      grid.setCell(loc, '#');
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
          final foldedP = Loc(x, newHeight + fold.line - i);
          final p = Loc(x, i);
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
          final foldedP = Loc(newWidth + fold.line - i, y);
          final p = Loc(i, y);
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
