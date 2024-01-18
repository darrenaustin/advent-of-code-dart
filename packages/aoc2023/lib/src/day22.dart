// ignore_for_file: public_member_api_docs, sort_constructors_first
// https://adventofcode.com/2023/day/22

import 'package:aoc/aoc.dart';
import 'package:aoc/util/string.dart';
import 'package:aoc/util/vec3.dart';
import 'package:collection/collection.dart';

main() => Day22().solve();

class Day22 extends AdventDay {
  Day22() : super(2023, 22, name: 'Sand Slabs');

  @override
  dynamic part1(String input) =>
      (BrickSpace(input)..dropBricks()).numSafelyDisintegrate();

  @override
  dynamic part2(String input) {
    final space = BrickSpace(input)..dropBricks();

    int sumFallingBricks = 0;
    for (final b in space.bricks) {
      sumFallingBricks += BrickSpace.from(space).distintegrate(b);
    }
    return sumFallingBricks;
  }
}

class Brick {
  factory Brick(id, String input) {
    final ns = input.numbers();
    var start = Vec3.int(ns[0], ns[1], ns[2]);
    var end = Vec3.int(ns[3], ns[4], ns[5]);
    if (start.zInt > end.zInt) {
      (start, end) = (end, start);
    }

    final points = <Vec3>[];
    final dir = start.directionTo(end);
    var pos = start;
    while (pos != end) {
      points.add(pos);
      pos += dir;
    }
    points.add(end);

    return Brick._(id, points);
  }

  Brick._(this.id, this._points)
      : _vertical = _points.first.x == _points.last.x &&
            _points.first.y == _points.last.y;

  factory Brick.from(Brick other) => Brick._(other.id, other._points);

  final int id;
  List<Vec3> _points;
  Iterable<Vec3> get points => _points;
  Vec3 get start => _points.first;
  Vec3 get end => _points.last;

  final bool _vertical;
  bool get isVertical => _vertical;

  int get bottom => start.zInt;

  Iterable<Vec3> bottomPoints() => (isVertical) ? [start] : points;

  void move(Vec3 delta) {
    // TODO: sort out why we can't replace the list in place.
    // for (int i = 0; i < _points.length; i++) {
    //   _points[i] += delta;
    // }
    _points = _points.map((p) => p + delta).toList();
  }

  @override
  String toString() => '$id: [$start -> $end]';
}

class BrickSpace {
  factory BrickSpace(String input) {
    final bricks = input.lines.mapIndexed((i, l) => Brick(i, l)).toList()
      ..sortBy<num>((b) => b.bottom);
    final occupied = <Vec3>{};
    for (final b in bricks) {
      occupied.addAll(b.points);
    }
    return BrickSpace._(bricks, occupied);
  }

  BrickSpace._(this._bricks, this._occupied);

  factory BrickSpace.from(BrickSpace other) => BrickSpace._(
      other.bricks.map((b) => Brick.from(b)).toList(),
      Set.from(other._occupied));

  final List<Brick> _bricks;
  Iterable<Brick> get bricks => _bricks;

  final Set<Vec3> _occupied;

  static final Vec3 down = Vec3(0, 0, -1);

  void _addBrick(Brick b) => _occupied.addAll(b.points);
  void _removeBrick(Brick b) => _occupied.removeAll(b.points);

  Set<int> dropBricks([List<Brick>? bricks]) {
    bricks ??= _bricks;
    final dropped = <int>{};
    for (final b in bricks) {
      if (_dropBrick(b)) {
        dropped.add(b.id);
      }
    }
    _sortBricks();
    return dropped;
  }

  bool _canDrop(Brick brick) {
    return (brick.bottom == 1)
        ? false
        : brick
            .bottomPoints()
            .map((p) => p + down)
            .every((p) => !_occupied.contains(p));
  }

  bool _dropBrick(Brick brick) {
    bool dropped = false;
    bool droppable = true;

    while (droppable) {
      if (brick.bottom == 1) {
        return dropped;
      }
      final below = brick.bottomPoints().map((p) => p + down);
      if (below.every((p) => !_occupied.contains(p))) {
        _removeBrick(brick);
        brick.move(down);
        _addBrick(brick);
        dropped = true;
      } else {
        droppable = false;
      }
    }
    return dropped;
  }

  bool canSafelyDisintegrate(Brick brick) {
    _removeBrick(brick);
    final canDisintegrate =
        bricks.every((b) => b.id == brick.id || !_canDrop(b));
    _addBrick(brick);
    return canDisintegrate;
  }

  int numSafelyDisintegrate() =>
      bricks.where((b) => canSafelyDisintegrate(b)).length;

  int distintegrate(Brick brick) {
    _removeBrick(brick);
    final index = _bricks.indexWhere((b) => b.id == brick.id);
    _bricks.removeAt(index);
    return dropBricks(_bricks.sublist(index)).length;
  }

  void _sortBricks() {
    _bricks.sortBy<num>((b) => b.bottom);
  }
}
