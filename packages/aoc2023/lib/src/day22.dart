// ignore_for_file: public_member_api_docs, sort_constructors_first
// https://adventofcode.com/2023/day/22

import 'package:aoc/aoc.dart';
import 'package:aoc/util/string.dart';
import 'package:aoc/util/vec.dart';
import 'package:collection/collection.dart';

main() => Day22().solve();

class Day22 extends AdventDay {
  Day22() : super(2023, 22, name: 'Sand Slabs');

  @override
  dynamic part1(String input) {
    final lines = input.lines.mapIndexed((i, l) => Line('$i', l)).toList();
    final space = Space();
    for (final l in lines) {
      space.addLine(l);
    }
    dropLines(space, lines);

    final canNuke = <Line>[];
    for (final nuked in lines) {
      space.removeLine(nuked);
      if (lines.every((l) => l == nuked || !space.canDrop(l))) {
        canNuke.add(nuked);
      }
      space.addLine(nuked);
    }
    return canNuke.length;
  }

  @override
  dynamic part2(String input) {
    final lines = input.lines.mapIndexed((i, l) => Line('$i', l)).toList();
    final space = Space();
    for (final l in lines) {
      space.addLine(l);
    }
    dropLines(space, lines);

    int sumFallingBricks = 0;
    for (int i = 0; i < lines.length; i++) {
      final num = distintegrate(space, lines, i);
      sumFallingBricks += num.length;
    }
    return sumFallingBricks;
  }

  void dropLines(Space space, List<Line> lines) {
    bool linesDropped = true;
    while (linesDropped) {
      linesDropped = false;
      for (final l in lines) {
        while (space.dropLine(l)) {
          linesDropped = true;
        }
      }
    }
  }

  List<String> distintegrate(Space space, List<Line> lines, int index) {
    space = Space.from(space);
    space.removeLine(lines[index]);
    final tempLines = [
      ...lines.where((l) => l != lines[index]).map((l) => Line.from(l))
    ];
    assert(tempLines.length == lines.length - 1);
    final dropped = <String>{};
    bool linesDropped = true;
    while (linesDropped) {
      linesDropped = false;
      for (final l in tempLines) {
        while (space.dropLine(l)) {
          dropped.add(l.id);
          linesDropped = true;
        }
      }
    }
    return dropped.toList();
  }
}

class Line {
  factory Line(String id, String input) {
    final ns = input.numbers();
    final start = Vec3.int(ns[0], ns[1], ns[2]);
    final end = Vec3.int(ns[3], ns[4], ns[5]);
    return Line._(id, start, end);
  }

  Line._(this.id, this.start, this.end)
      : _verticalBottom = (start.x == end.x && start.y == end.y)
            ? (start.z > end.z)
                ? end
                : start
            : null;

  factory Line.from(Line other) => Line._(other.id, other.start, other.end);

  final String id;
  Vec3 start;
  Vec3 end;

  Vec3? _verticalBottom;
  bool get isVertical => _verticalBottom != null;

  int get bottom => _verticalBottom?.zInt ?? start.zInt;

  Vec3 direction() => start.directionTo(end);

  List<Vec3> points() {
    if (start == end) {
      return [start];
    }
    final ps = <Vec3>[];
    final dir = direction();
    var pos = start;
    while (pos != end) {
      ps.add(pos);
      pos += dir;
    }
    ps.add(end);
    return ps;
  }

  List<Vec3> bottomPoints() {
    if (_verticalBottom != null) {
      return [_verticalBottom!];
    }
    return points();
  }

  void update(Vec3 delta) {
    start += delta;
    end += delta;
    if (_verticalBottom != null) {
      _verticalBottom = (start.z > end.z) ? end : start;
    }
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Line &&
        other.id == id &&
        other.start == start &&
        other.end == end;
  }

  @override
  int get hashCode => id.hashCode ^ start.hashCode ^ end.hashCode;

  @override
  String toString() => '$id: [$start -> $end]';
}

class Space {
  Space();

  factory Space.from(Space other) => Space().._locs.addAll(other._locs);

  final _locs = <Vec3>{};

  void addLine(Line l) => _locs.addAll(l.points());

  void removeLine(Line l) => _locs.removeAll(l.points());

  static final Vec3 down = Vec3(0, 0, -1);

  bool canDrop(Line line) {
    if (line.bottom == 1) {
      return false;
    }
    return line
        .bottomPoints()
        .map((p) => p + down)
        .every((p) => !_locs.contains(p));
  }

  bool dropLine(Line line) {
    if (line.bottom == 1) {
      return false;
    }
    final below = line.bottomPoints().map((p) => p + down);
    if (below.every((p) => !_locs.contains(p))) {
      removeLine(line);
      line.update(down);
      addLine(line);
      return true;
    }
    return false;
  }
}
