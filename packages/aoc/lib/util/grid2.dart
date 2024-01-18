import 'package:aoc/util/string.dart';
import 'package:collection/collection.dart';

import 'vec.dart';

class Grid<T> {
  Grid(this.width, int height, this.defaultValue) : _height = height {
    _cells = List<List<T>>.generate(
        height, (_) => List<T>.generate(width, (_) => defaultValue));
  }

  factory Grid.from(List<List<T>> values, T defaultValue) {
    final grid = Grid<T>(values[0].length, values.length, defaultValue);
    for (int row = 0; row < grid.height; row++) {
      for (int col = 0; col < grid.width; col++) {
        final rowLine = values[row];
        grid.setCell(Vec(col, row), rowLine[col]);
      }
    }
    return grid;
  }

  factory Grid.emptyFrom(Grid<T> other) =>
      Grid<T>(other.width, other.height, other.defaultValue);

  static Grid<String> fromString(String input, [String defaultValue = '.']) =>
      Grid<String>.from(input.lines.map((l) => l.chars).toList(), defaultValue);

  final int width;
  int get height => _height;
  int _height;
  final T defaultValue;
  late final List<List<T>> _cells;

  Grid<T> copy() {
    final grid = Grid<T>(width, height, defaultValue);
    for (final loc in locations()) {
      grid.setCell(loc, cell(loc));
    }
    return grid;
  }

  T cell(Vec p) => _cells[p.yInt][p.xInt];
  void setCell(Vec p, T value) => _cells[p.yInt][p.xInt] = value;

  bool validCell(Vec p) => 0 <= p.x && p.x < width && 0 <= p.y && p.y < height;

  void updateCell(Vec p, T Function(T) update) {
    setCell(p, update(cell(p)));
  }

  Iterable<T> cells() sync* {
    for (final List<T> line in _cells) {
      for (final T value in line) {
        yield value;
      }
    }
  }

  Iterable<T> cellsWhere(bool Function(T) test) => cells().where(test);

  Iterable<Vec> locations() sync* {
    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        yield Vec(x, y);
      }
    }
  }

  Iterable<Vec> locationsWhere(bool Function(T) test) =>
      locations().where((p) => test(cell(p)));

  void updateCells(T Function(T) update) {
    for (int row = 0; row < height; row++) {
      for (int col = 0; col < width; col++) {
        final value = _cells[row][col];
        _cells[row][col] = update(value);
      }
    }
  }

  void updateCellsWhere(bool Function(T) test, T Function(T) update) {
    for (int row = 0; row < height; row++) {
      for (int col = 0; col < width; col++) {
        final value = _cells[row][col];
        if (test(value)) {
          _cells[row][col] = update(value);
        }
      }
    }
  }

  void addTopRows(int numRows) {
    for (int r = 0; r < numRows; r++) {
      _cells.insert(0, List<T>.generate(width, (_) => defaultValue));
    }
    _height += numRows;
  }

  List<List<T>> copyRows(int startRow, int lastRow) {
    final List<List<T>> rows = [];
    for (int r = startRow; r <= lastRow; r++) {
      rows.add(List.from(_cells[r]));
    }
    return rows;
  }

  String printRows(int startRow, int numRows) => _cells
      .sublist(startRow, startRow + numRows)
      .map((List<T> r) => r.join(' '))
      .join('\n');

  Iterable<T> neighbors(Vec p, [List<Vec> offsets = Vec.aroundDirs]) =>
      offsets.map((Vec o) => p + o).where(validCell).map(cell);

  Iterable<Vec> neighborLocations(Vec p,
          [List<Vec> offsets = Vec.aroundDirs]) =>
      offsets.map((Vec o) => p + o).where(validCell);

  Iterable<(Vec, T)> column(int col) sync* {
    for (int r = 0; r < height; r++) {
      final pos = Vec(col, r);
      yield (pos, cell(pos));
    }
  }

  Iterable<(Vec, T)> row(int row) sync* {
    for (int c = 0; c < width; c++) {
      final pos = Vec(c, row);
      yield (pos, cell(pos));
    }
  }

  static final deepEq = DeepCollectionEquality();

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is Grid<T> &&
        other.width == width &&
        other.height == height &&
        other.defaultValue == defaultValue &&
        deepEq.equals(other._cells, _cells);
  }

  @override
  int get hashCode =>
      width.hashCode ^
      height.hashCode ^
      defaultValue.hashCode ^
      deepEq.hash(_cells);

  @override
  String toString() => _cells.map((List<T> r) => r.join(' ')).join('\n');
}
