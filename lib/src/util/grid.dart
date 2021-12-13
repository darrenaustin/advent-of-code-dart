import 'dart:math';

import 'collection.dart';

class Loc {
  const Loc(this.x, this.y);

  final int x;
  final int y;

  static const Loc zero = Loc(0, 0);

  Loc operator +(Loc other) {
    return Loc(x + other.x, y + other.y);
  }

  Loc operator -() => Loc(-x, -y);

  Loc operator -(Loc other) {
    return Loc(x - other.x, y - other.y);
  }

  Loc operator *(num factor) {
    return Loc((x * factor).toInt(), (y * factor).toInt());
  }

  @override
  bool operator ==(Object other) {
    return other is Loc
        && other.x == x
        && other.y == y;
  }

  @override
  int get hashCode => x.hashCode ^ y.hashCode;

  @override
  String toString() => 'Loc($x, $y)';
}

class Grid<T> {
  Grid(this.width, this.height, this.defaultValue) {
    _cells = List<List<T>>.generate(height, (int i) => List<T>.generate(width, (int i) => defaultValue));
  }

  final int width;
  final int height;
  final T defaultValue;
  late final List<List<T>> _cells;

  T cell(Loc p) => _cells[p.y.toInt()][p.x.toInt()];
  void setCell(Loc p, T value) => _cells[p.y.toInt()][p.x.toInt()] = value;

  bool validCell(Loc p) => 0 <= p.x && p.x < width && 0 <= p.y && p.y < height;

  Iterable<T> cells() sync* {
    for (final List<T> line in _cells) {
      for (final T value in line) {
        yield value;
      }
    }
  }

  Iterable<Loc> locations() sync* {
    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        yield Loc(x, y);
      }
    }
  }

  Iterable<T> cellsWhere(bool Function(T) test) {
    return cells().where(test);
  }

  Iterable<Loc> locationsWhere(bool Function(T) test) {
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

  static const List<Loc> cardinalNeighborOffsets = <Loc>[
    Loc(-1, -1), Loc(0, -1), Loc(1, -1),
    Loc(-1,  0),             Loc(1,  0),
    Loc(-1,  1), Loc(0,  1), Loc(1,  1),
  ];

  static const List<Loc> orthogonalNeighborOffsets = <Loc>[
                 Loc(0, -1),
    Loc(-1,  0),             Loc(1,  0),
                 Loc(0,  1),
  ];

  Iterable<T> neighbors(Loc p, [List<Loc> offsets = cardinalNeighborOffsets]) {
    return offsets.map((Loc o) => p + o).where(validCell).map(cell);
  }

  Iterable<Loc> neighborLocations(Loc p, [List<Loc> offsets = cardinalNeighborOffsets]) {
    return offsets.map((Loc o) => p + o).where(validCell);
  }

  @override
  String toString() {
    return _cells.map((List<T> r) => r.join(' ')).join('\n');
  }
}

class SparseGrid<T> {
  SparseGrid({
    required this.defaultValue,
  })  : _cells = <Loc, T>{},
        _min = Loc.zero,
        _max = Loc.zero;

  final T defaultValue;

  final Map<Loc, T> _cells;

  Loc get minLocation => _min;
  Loc _min;

  Loc get maxLocation => _max;
  Loc _max;

  bool isSet(Loc p) {
    return _cells.containsKey(p);
  }

  T cell(Loc p) {
    return _cells[p] ?? defaultValue;
  }

  void setCell(Loc p, T value) {
    _cells[p] = value;
    _min = Loc(min(_min.x, p.x), min(_min.y, p.y));
    _max = Loc(max(_max.x, p.x), max(_max.y, p.y));
  }

  int numSetCells() => _cells.length;

  int numSetCellsWhere(bool Function(T) test) {
    return _cells.values.where(test).length;
  }

  @override
  String toString() {
    return range(_min.y.toInt(), _max.y.toInt() + 1)
        .map((int y) => range(_min.x.toInt(), _max.x.toInt() + 1).map((int x) {
              final Loc p = Loc(x, y);
              return isSet(p) ? cell(p).toString() : ' ';
            }).join(' '))
        .join('\n');
  }
}
