import 'vec2.dart';

class Grid<T> {
  Grid(this.width, this.height, this.defaultValue) {
    _cells = List<List<T>>.generate(height, (int i) => List<T>.generate(width, (int i) => defaultValue));
  }

  factory Grid.from(List<List<T>> values, T defaultValue) {
    final grid = Grid<T>(values[0].length, values.length, defaultValue);
    for (int row = 0; row < grid.height; row++) {
      for (int col = 0; col < grid.width; col++) {
        final rowLine = values[row];
        grid.setCell(Vec2.int(col, row), rowLine[col]);
      }
    }
    return grid;
  }

  factory Grid.copy(Grid<T> other) {
    final grid = Grid<T>(other.width, other.height, other.defaultValue);
    for (final loc in other.locations()) {
      grid.setCell(loc, other.cell(loc));
    }
    return grid;
  }

  final int width;
  final int height;
  final T defaultValue;
  late final List<List<T>> _cells;

  T cell(Vec2 p) => _cells[p.yInt][p.xInt];
  void setCell(Vec2 p, T value) => _cells[p.yInt][p.xInt] = value;

  bool validCell(Vec2 p) => 0 <= p.x && p.x < width && 0 <= p.y && p.y < height;

  Iterable<T> cells() sync* {
    for (final List<T> line in _cells) {
      for (final T value in line) {
        yield value;
      }
    }
  }

  Iterable<T> cellsWhere(bool Function(T) test) {
    return cells().where(test);
  }

  Iterable<Vec2> locations() sync* {
    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        yield Vec2.int(x, y);
      }
    }
  }

  Iterable<Vec2> locationsWhere(bool Function(T) test) {
    return locations().where((p) => test(cell(p)));
  }

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

  Iterable<T> neighbors(Vec2 p, [List<Vec2> offsets = Vec2.aroundDirs]) {
    return offsets.map((Vec2 o) => p + o).where(validCell).map(cell);
  }

  Iterable<Vec2> neighborLocations(Vec2 p, [List<Vec2> offsets = Vec2.aroundDirs]) {
    return offsets.map((Vec2 o) => p + o).where(validCell);
  }

  @override
  String toString() {
    return _cells.map((List<T> r) => r.join(' ')).join('\n');
  }
}
