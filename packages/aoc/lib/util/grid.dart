import 'package:aoc/util/string.dart';
import 'package:collection/collection.dart';

import 'vec.dart';

class Grid<T> {
  Grid(int width, int height, this.defaultValue,
      {this.cellPrintWidth = 1, this.cellSeparator = ' '})
      : _width = width,
        _height = height {
    _cells = List<List<T>>.generate(
        height, (_) => List<T>.filled(width, defaultValue));
  }

  factory Grid.from(List<List<T>> values, T defaultValue,
      {int cellPrintWidth = 1, String cellSeparator = ' '}) {
    final grid = Grid<T>(values[0].length, values.length, defaultValue,
        cellPrintWidth: cellPrintWidth, cellSeparator: cellSeparator);
    for (int row = 0; row < grid.height; row++) {
      for (int col = 0; col < grid.width; col++) {
        final rowLine = values[row];
        grid.setValue(Vec(col, row), rowLine[col]);
      }
    }
    return grid;
  }

  factory Grid.emptyFrom(Grid<T> other) =>
      Grid<T>(other.width, other.height, other.defaultValue,
          cellPrintWidth: other.cellPrintWidth,
          cellSeparator: other.cellSeparator);

  static Grid<String> parse(String input,
          {String defaultValue = '.',
          int cellPrintWidth = 1,
          String cellSeparator = ' '}) =>
      Grid<String>.from(input.lines.map((l) => l.chars).toList(), defaultValue,
          cellPrintWidth: cellPrintWidth, cellSeparator: cellSeparator);

  int get width => _width;
  int _width;
  int get height => _height;
  int _height;
  final T defaultValue;
  final int cellPrintWidth;
  final String cellSeparator;
  late final List<List<T>> _cells;

  Grid<T> copy() => Grid.from(_cells, defaultValue);

  T value(Vec l) => _cells[l.yInt][l.xInt];
  void setValue(Vec l, T value) => _cells[l.yInt][l.xInt] = value;
  void updateValue(Vec p, T Function(T) update) {
    setValue(p, update(value(p)));
  }

  Iterable<T> values() sync* {
    for (final List<T> line in _cells) {
      for (final T value in line) {
        yield value;
      }
    }
  }

  void updateValues(T Function(T) update) {
    for (int row = 0; row < height; row++) {
      for (int col = 0; col < width; col++) {
        final value = _cells[row][col];
        _cells[row][col] = update(value);
      }
    }
  }

  void updateValuesWhere(bool Function(T) test, T Function(T) update) {
    for (int row = 0; row < height; row++) {
      for (int col = 0; col < width; col++) {
        final value = _cells[row][col];
        if (test(value)) {
          _cells[row][col] = update(value);
        }
      }
    }
  }

  bool validColumn(int col) => 0 <= col && col < width;
  bool validRow(int row) => 0 <= row && row < height;

  bool validLocation(Vec l) =>
      0 <= l.x && l.x < width && 0 <= l.y && l.y < height;

  Iterable<Vec> locations() sync* {
    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        yield Vec(x, y);
      }
    }
  }

  Iterable<Vec> locationsWhereValue(bool Function(T) test) =>
      locations().where((p) => test(value(p)));

  Iterable<(Vec, T)> cells() => locations().map((l) => (l, value(l)));

  Iterable<(Vec, T)> columnCells(int col) sync* {
    assert(validColumn(col));
    for (int row = 0; row < height; row++) {
      final pos = Vec(col, row);
      yield (pos, value(pos));
    }
  }

  Iterable<T> columnValues(int col) => columnCells(col).map((c) => c.$2);

  void setColumn(int col, Iterable<T> values) {
    assert(validColumn(col));
    assert(values.length == height);
    int row = 0;
    for (final value in values) {
      _cells[row][col] = value;
      row++;
    }
  }

  void insertCol(int beforeCol, [List<T>? values]) {
    final col = [...(values ?? List<T>.filled(height, defaultValue))];
    assert(col.length == height);
    for (int row = 0; row < height; row++) {
      _cells[row].insert(beforeCol, col[row]);
    }
    _width++;
  }

  Iterable<(Vec, T)> rowCells(int row) sync* {
    assert(validRow(row));
    for (int col = 0; col < width; col++) {
      final pos = Vec(col, row);
      yield (pos, value(pos));
    }
  }

  Iterable<T> rowValues(int col) => rowCells(col).map((c) => c.$2);

  void setRow(int row, Iterable<T> values) {
    assert(validRow(row));
    assert(values.length == width);
    int col = 0;
    for (final value in values) {
      _cells[row][col] = value;
      col++;
    }
  }

  void insertRow(int beforeRow, [List<T>? values]) {
    final row = [...(values ?? List<T>.filled(width, defaultValue))];
    assert(row.length == width);
    _cells.insert(beforeRow, row);
    _height++;
  }

  Iterable<(Vec, T)> neighborCells(Vec l,
          [List<Vec> offsets = Vec.aroundDirs]) =>
      offsets.map((o) => l + o).where(validLocation).map((l) => (l, value(l)));

  Iterable<T> neighborValues(Vec p, [List<Vec> offsets = Vec.aroundDirs]) =>
      offsets.map((Vec o) => p + o).where(validLocation).map(value);

  Iterable<Vec> neighborLocations(Vec p,
          [List<Vec> offsets = Vec.aroundDirs]) =>
      offsets.map((Vec o) => p + o).where(validLocation);

  static final _listEquals = const DeepCollectionEquality().equals;
  static final _listHash = const DeepCollectionEquality().hash;

  @override
  bool operator ==(covariant Grid<T> other) {
    if (identical(this, other)) return true;

    return other.width == width &&
        other.height == height &&
        other.defaultValue == defaultValue &&
        _listEquals(other._cells, _cells);
  }

  @override
  int get hashCode =>
      width.hashCode ^
      height.hashCode ^
      defaultValue.hashCode ^
      _listHash(_cells);

  @override
  String toString() => _cells
      .map((List<T> r) => r
          .map((v) => v.toString().padLeft(cellPrintWidth))
          .join(cellSeparator))
      .join('\n');
}
