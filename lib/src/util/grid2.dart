import 'dart:math';

import 'collection.dart';
import 'vec2.dart';

class Grid<T> {
  Grid(this.width, this.height, this.defaultValue) {
    _cells = List<List<T>>.generate(height, (int i) => List<T>.generate(width, (int i) => defaultValue));
  }

  final int width;
  final int height;
  final T defaultValue;
  late final List<List<T>> _cells;

  T cell(Vector p) => _cells[p.y.toInt()][p.x.toInt()];
  void setCell(Vector p, T value) => _cells[p.y.toInt()][p.x.toInt()] = value;

  bool validCell(Vector p) =>
      0 <= p.x && p.x < width && 0 <= p.y && p.y < height;

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

  static const List<Vector> cardinalNeighborOffsets = <Vector>[
    Vector(-1, -1), Vector(0, -1), Vector(1, -1),
    Vector(-1,  0),                Vector(1,  0),
    Vector(-1,  1), Vector(0,  1), Vector(1,  1),
  ];

  Iterable<T> neighbors(Vector p, [List<Vector> offsets = cardinalNeighborOffsets]) {
    return offsets.map((Vector o) => p + o).where(validCell).map(cell);
  }

  @override
  String toString() {
    return _cells.map((List<T> r) => r.join()).join('\n');
  }
}

class SparseGrid<T> {
  SparseGrid({
    required this.defaultValue,
  })  : _cells = <Vector, T>{},
        _min = Vector.zero,
        _max = Vector.zero;

  final T defaultValue;

  final Map<Vector, T> _cells;

  Vector get minVector => _min;
  Vector _min;

  Vector get maxVector => _max;
  Vector _max;

  bool isSet(Vector p) {
    return _cells.containsKey(p);
  }

  T cell(Vector p) {
    return _cells[p] ?? defaultValue;
  }

  void setCell(Vector p, T value) {
    _cells[p] = value;
    _min = Vector(min(_min.x, p.x), min(_min.y, p.y));
    _max = Vector(max(_max.x, p.x), max(_max.y, p.y));
  }

  int numSetCells() => _cells.length;

  int numSetCellsWhere(bool Function(T) test) {
    return _cells.values.where(test).length;
  }

  @override
  String toString() {
    return range(_min.y.toInt(), _max.y.toInt() + 1)
        .map((int y) => range(_min.x.toInt(), _max.x.toInt() + 1).map((int x) {
              final Vector p = Vector.int(x, y);
              return isSet(p) ? cell(p).toString() : ' ';
            }).join(' '))
        .join('\n');
  }
}
