import 'dart:math';

import 'range.dart';
import 'vec.dart';

class SparseGrid<T> {
  SparseGrid({
    required this.defaultValue,
    this.cellPrintWidth = 2,
  })  : _cells = <Vec, T>{},
        _min = Vec.zero,
        _max = Vec.zero;

  final T defaultValue;
  final int cellPrintWidth;

  final Map<Vec, T> _cells;

  Vec get minLocation => _min;
  Vec _min;

  Vec get maxLocation => _max;
  Vec _max;

  bool isSet(Vec p) => _cells.containsKey(p);

  T cell(Vec p) => _cells[p] ?? defaultValue;

  void setCell(Vec p, T value) {
    if (!isSet(p)) {
      _min = Vec(min(_min.x, p.x), min(_min.y, p.y));
      _max = Vec(max(_max.x, p.x), max(_max.y, p.y));
    }
    _cells[p] = value;
  }

  int numSetCells() => _cells.length;

  int numSetCellsWhere(bool Function(T) test) =>
      _cells.values.where(test).length;

  Iterable<Vec> locationsWhere(bool Function(T) test) {
    return _cells.keys.where((p) => test(cell(p)));
  }

  @override
  String toString() {
    return rangeinc(_min.yInt, _max.yInt)
        .map((int y) => rangeinc(_min.xInt, _max.xInt).map((int x) {
              final Vec p = Vec(x, y);
              return (isSet(p) ? cell(p).toString() : '')
                  .padLeft(cellPrintWidth);
            }).join(''))
        .join('\n');
  }
}
