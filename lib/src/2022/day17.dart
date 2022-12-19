// https://adventofcode.com/2022/day/17

import 'dart:math';

import 'package:advent_of_code_dart/src/util/grid2.dart';

import '../../day.dart';
import '../util/vec2.dart';

class Day17 extends AdventDay {
  Day17() : super(2022, 17, solution1: 3227, solution2: 1597714285698);

  @override
  dynamic part1() {
    return Tower(shapes, inputWindDirections()).heightAfterShapes(2022);
  }

  @override
  dynamic part2() {
    return Tower(shapes, inputWindDirections()).heightAfterShapes(1000000000000);
  }

  List<Vec2> inputWindDirections() {
    return inputData()
      .split('')
      .map((d) => {
          '<': Vec2.left,
          '>': Vec2.right,
        }[d]!)
      .toList();
  }

  static final shapes = '''
####

.#.
###
.#.

..#
..#
###

#
#
#
#

##
##'''.split('\n\n')
      .map((shape) {
        final lines = shape.split('\n');
        final width = lines.first.length;
        final height = lines.length;
        final grid = Grid<String>(width, height, '.');
        for (int row = 0; row < height; row++) {
          final line = lines[row];
          for (int col = 0; col < width; col++) {
            grid.setCell(Vec2.int(col, row), line[col]);
          }
        }
        return grid;
      })
      .toList();
}

class Tower {
  Tower(this.shapes, this.winds)
    : _shapeIndex = 0,
      _windIndex = 0,
      _grid = Grid<String>(7, 0, '.'),
      _floor = 0,
      _shapePos = Vec2.zero,
      _cache = {};

  int get rockHeight => _grid.height - _floor;

  int heightAfterShapes(int numShapes) {
    int? cycleAddedHeight;
    for (int i = 0; i < numShapes; i++) {
      if (cycleAddedHeight == null) {
        // Compute a state for the current iteration
        final state = CacheState(cacheRows(), _shapeIndex, _windIndex);
        if (_cache.containsKey(state)) {
          // Encountered cycle
          final cycleStart = _cache[state]!; // Vec2.x = numRocks, y = height
          final cycleLength = i - cycleStart.xInt;
          final cycleHeight = rockHeight - cycleStart.yInt;
          final numCycles = (numShapes - i) ~/ cycleLength;

          // Fast-forward as many cycles that fit in the remaining shapes
          i += numCycles * cycleLength;
          cycleAddedHeight = numCycles * cycleHeight;
        } else {
          _cache[state] = Vec2.int(i, rockHeight);
        }
      }
      dropShape();
    }
    return rockHeight + (cycleAddedHeight ?? 0);
  }

  void dropShape() {
    final shape = shapes[_shapeIndex];
    growGridFor(shape);
    _shapePos = Vec2(2, _floor - shape.height- 3);
    bool landed = false;
    while (!landed) {
      pushShape();
      final newPos = _shapePos + Vec2.down;
      if (!shapeFits(shape, newPos)) {
        landed = true;
        _floor = min(_shapePos.yInt, _floor);
        drawShape(shape, _shapePos);
        break;
      }
      _shapePos = newPos;
    }
    nextShape();
  }

  void pushShape() {
    final shape = shapes[_shapeIndex];
    final newPos = _shapePos + nextWind();
    if (shapeFits(shape, newPos)) {
      _shapePos = newPos;
    }
  }

  bool shapeFits(Grid<String> shape, Vec2 pos) {
    if (pos.xInt < 0 || pos.xInt + shape.width > _grid.width ||
        pos.yInt < 0 || pos.yInt + shape.height > _grid.height) {
      return false;
    }
    for (int row = 0; row < shape.height; row++) {
      for (int col = 0; col < shape.width; col++) {
        final shapePos = Vec2.int(col, row);
        final pixel = shape.cell(shapePos);
        if (pixel != '.') {
          if (_grid.cell(pos + shapePos) != '.') {
            return false;
          }
        }
      }
    }
    return true;
  }

  void drawShape(Grid<String> shape, Vec2 pos) {
    for (int row = 0; row < shape.height; row++) {
      for (int col = 0; col < shape.width; col++) {
        final shapePos = Vec2.int(col, row);
        final pixel = shape.cell(shapePos);
        if (pixel != '.') {
          Vec2 gridPos = pos + shapePos;
          _grid.setCell(gridPos, pixel);
        }
      }
    }
  }

  void growGridFor(Grid<String> shape) {
    final spaceNeeded = shape.height + 3;
    if (spaceNeeded > _floor) {
      _grid.addTopRows(spaceNeeded);
      _floor = _floor + spaceNeeded;
    }
  }

  Grid<String> nextShape() {
    final shape = shapes[_shapeIndex];
    _shapeIndex = (_shapeIndex + 1) % shapes.length;
    return shape;
  }

  Vec2 nextWind() {
    final wind = winds[_windIndex];
    _windIndex = (_windIndex + 1) % winds.length;
    return wind;
  }

  String cacheRows() {
    final numRows = min(7, _grid.height - _floor);
    return _grid.printRows(_floor, numRows);
  }

  List<Grid<String>> shapes;
  List<Vec2> winds;
  final Grid<String> _grid;
  int _shapeIndex;
  int _windIndex;
  Vec2 _shapePos;
  int _floor;

  final Map<CacheState, Vec2> _cache;

  @override
  String toString() {
    return '$_grid\n';
  }
}

class CacheState {
  CacheState(this.rows, this.shapeIndex, this.windIndex);

  final String rows;
  final int shapeIndex;
  final int windIndex;

  @override
  bool operator ==(Object other) {
    return other is CacheState
      && other.rows == rows
      && other.shapeIndex == shapeIndex
      && other.windIndex == windIndex;
  }

  @override
  int get hashCode => Object.hash(rows, shapeIndex, windIndex);
}
