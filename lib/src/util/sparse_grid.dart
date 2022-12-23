import 'dart:math';

import 'collection.dart';
import 'vec2.dart';

class SparseGrid<T> {
  SparseGrid({
    required this.defaultValue,
  }) : _cells = <Vec2, T>{},
       _min = Vec2.zero,
       _max = Vec2.zero;

  final T defaultValue;

  final Map<Vec2, T> _cells;

  Vec2 get minLocation => _min;
  Vec2 _min;

  Vec2 get maxLocation => _max;
  Vec2 _max;

  bool isSet(Vec2 p) => _cells.containsKey(p);

  T cell(Vec2 p) => _cells[p] ?? defaultValue;

  void setCell(Vec2 p, T value) {
    if (!isSet(p)) {
      _min = Vec2(min(_min.x, p.x), min(_min.y, p.y));
      _max = Vec2(max(_max.x, p.x), max(_max.y, p.y));
    }
    _cells[p] = value;
  }

  int numSetCells() => _cells.length;

  int numSetCellsWhere(bool Function(T) test) =>
    _cells.values.where(test).length;

  // Iterable<Vec2> locations() sync* {
  //   for (int y = 0; y < height; y++) {
  //     for (int x = 0; x < width; x++) {
  //       yield Vec2.int(x, y);
  //     }
  //   }
  // }
  //

  Iterable<Vec2> locationsWhere(bool Function(T) test) {
    return _cells.keys.where((p) => test(cell(p)));
  }

  @override
  String toString() {
    return
      range(_min.yInt, _max.yInt + 1)
        .map((int y) => range(_min.xInt, _max.xInt + 1)
          .map((int x) {
            final Vec2 p = Vec2.int(x, y);
            return isSet(p) ? cell(p).toString() : defaultValue;
          })
          .join(''))
        .join('\n');
  }
}
