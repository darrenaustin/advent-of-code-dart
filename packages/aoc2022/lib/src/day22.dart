// https://adventofcode.com/2022/day/22

import 'package:aoc/aoc.dart';
import 'package:aoc/util/grid.dart';
import 'package:aoc/util/vec.dart';
import 'package:collection/collection.dart';

// This solution is hand crafted to my input.
// A more general solution would be a lot more work.

main() => Day22().solve();

class Day22 extends AdventDay {
  Day22() : super(2022, 22, name: 'Monkey Map');

  @override
  dynamic part1(String input) {
    final grid = parseGrid(input);
    final path = parsePath(input);
    final startOff = move(grid, Vec.zero, Vec.right, 1);

    Vec pos = move(grid, startOff, Vec.left, 1);
    Vec facing = Vec.right;

    for (final p in path) {
      int steps = p.steps;
      while (steps > 0) {
        Vec newPos = wrapped(grid, pos + facing);
        while (grid.value(newPos) == ' ') {
          newPos = wrapped(grid, newPos + facing);
        }
        if (grid.value(newPos) == '#') {
          break;
        }
        pos = newPos;
        steps--;
      }
      if (p.turn != Vec.zero) {
        final int facingIndex = dirs.indexOf(facing);
        if (p.turn == Vec.right) {
          facing = dirs[(facingIndex + 1) % 4];
        } else {
          facing = dirs[(facingIndex + 3) % 4];
        }
      }
    }
    return password(pos, facing);
  }

  @override
  dynamic part2(String input) {
    final grid = parseGrid(input);
    final path = parsePath(input);
    final faceSize = 50;

    // Hard coded faces and edges based on inspecting my input
    // (with some arts and crafts)

    final faceOffset = <Face, Vec>{
      Face.down: Vec(50, 0),
      Face.right: Vec(100, 0),
      Face.front: Vec(50, 50),
      Face.up: Vec(50, 100),
      Face.left: Vec(0, 100),
      Face.back: Vec(0, 150),
    };

    final edges = <Face, Map<Vec, CubeEdge>>{
      Face.up: {
        Vec.up: CubeEdge(Face.front, Vec.up),
        Vec.down: CubeEdge(Face.back, Vec.left),
        Vec.left: CubeEdge(Face.left, Vec.left),
        Vec.right: CubeEdge(Face.right, Vec.left),
      },
      Face.down: {
        Vec.up: CubeEdge(Face.back, Vec.right),
        Vec.down: CubeEdge(Face.front, Vec.down),
        Vec.left: CubeEdge(Face.left, Vec.right),
        Vec.right: CubeEdge(Face.right, Vec.right),
      },
      Face.left: {
        Vec.up: CubeEdge(Face.front, Vec.right),
        Vec.down: CubeEdge(Face.back, Vec.down),
        Vec.left: CubeEdge(Face.down, Vec.right),
        Vec.right: CubeEdge(Face.up, Vec.right),
      },
      Face.right: {
        Vec.up: CubeEdge(Face.back, Vec.up),
        Vec.down: CubeEdge(Face.front, Vec.left),
        Vec.left: CubeEdge(Face.down, Vec.left),
        Vec.right: CubeEdge(Face.up, Vec.left),
      },
      Face.front: {
        Vec.up: CubeEdge(Face.down, Vec.up),
        Vec.down: CubeEdge(Face.up, Vec.down),
        Vec.left: CubeEdge(Face.left, Vec.down),
        Vec.right: CubeEdge(Face.right, Vec.up),
      },
      Face.back: {
        Vec.up: CubeEdge(Face.left, Vec.up),
        Vec.down: CubeEdge(Face.right, Vec.down),
        Vec.left: CubeEdge(Face.down, Vec.down),
        Vec.right: CubeEdge(Face.up, Vec.up),
      },
    };

    Vec mapPos(Vec pos, Vec fromDir, Vec toDir) {
      final wrappedX = pos.xInt < 0
          ? faceSize - 1
          : pos.xInt >= faceSize
              ? 0
              : pos.xInt;
      final wrappedY = pos.yInt < 0
          ? faceSize - 1
          : pos.yInt >= faceSize
              ? 0
              : pos.yInt;
      final wrapped = Vec(wrappedX, wrappedY);
      if (fromDir == toDir) {
        return wrapped;
      }
      if (fromDir == Vec.up) {
        if (toDir == Vec.right) {
          return Vec(0, wrapped.x);
        }
        throw ('Huh?');
      } else if (fromDir == Vec.down) {
        if (toDir == Vec.left) {
          return Vec(faceSize - 1, wrapped.x);
        }
        throw ('Huh?');
      } else if (fromDir == Vec.left) {
        if (toDir == Vec.down) {
          return Vec(wrapped.y, 0);
        } else if (toDir == Vec.right) {
          return Vec(0, faceSize - wrapped.y - 1);
        }
        throw ('Huh?');
      } else if (fromDir == Vec.right) {
        if (toDir == Vec.up) {
          return Vec(wrapped.yInt, faceSize - 1);
        } else if (toDir == Vec.left) {
          return Vec(faceSize - 1, faceSize - wrapped.yInt - 1);
        }
        throw ('Huh?');
      }
      throw ('Huh?');
    }

    bool validFaceCell(Vec p) =>
        (0 <= p.x && p.x < faceSize && 0 <= p.y && p.y < faceSize);

    CubePos newPos(CubePos start) {
      final nextPos = start.pos + start.facing;
      if (validFaceCell(nextPos)) {
        return CubePos(start.face, nextPos, start.facing);
      }
      final edge = edges[start.face]![start.facing]!;
      return CubePos(
          edge.face, mapPos(nextPos, start.facing, edge.facing), edge.facing);
    }

    String cellAt(CubePos pos) => grid.value(faceOffset[pos.face]! + pos.pos);

    CubePos pos = CubePos(Face.down, Vec.zero, Vec.right);
    for (final p in path) {
      int steps = p.steps;
      while (steps > 0) {
        CubePos nextPos = newPos(pos);
        if (cellAt(nextPos) == '#') {
          break;
        }
        pos = nextPos;
        steps--;
      }
      if (p.turn != Vec.zero) {
        final int facingIndex = dirs.indexOf(pos.facing);
        if (p.turn == Vec.right) {
          pos = CubePos(pos.face, pos.pos, dirs[(facingIndex + 1) % 4]);
        } else {
          pos = CubePos(pos.face, pos.pos, dirs[(facingIndex + 3) % 4]);
        }
      }
    }
    return password(faceOffset[pos.face]! + pos.pos, pos.facing);
  }

  Grid<String> face(Grid<String> grid, Vec start, int size) {
    final face = Grid<String>(size, size, ' ');
    for (int row = 0; row < size; row++) {
      for (int col = 0; col < size; col++) {
        face.setValue(
            Vec(col, row), grid.value(Vec(col + start.xInt, row + start.yInt)));
      }
    }
    return face;
  }

  Grid<String> parseGrid(String input) {
    final gridData =
        input.split('\n\n').first.split('\n').map((l) => l.split('')).toList();
    final width = gridData.map((r) => r.length).max;
    final height = gridData.length;
    final grid = Grid<String>(width, height, ' ');
    for (int y = 0; y < grid.height; y++) {
      final row = gridData[y];
      for (int x = 0; x < grid.width; x++) {
        if (x < row.length) {
          grid.setValue(Vec(x, y), gridData[y][x]);
        }
      }
    }
    return grid;
  }

  List<Path> parsePath(String input) {
    final pathData = input.split('\n\n').last.trim();
    final pathReg = RegExp(r'(\d+)([RL])?');
    final matches = pathReg.allMatches(pathData);
    return matches
        .map((m) => Path(
            int.parse(m.group(1)!),
            m.group(2) == null
                ? Vec.zero
                : m.group(2)! == 'L'
                    ? Vec.left
                    : Vec.right))
        .toList();
  }

  int password(Vec pos, Vec facing) =>
      1000 * (pos.yInt + 1) + 4 * (pos.xInt + 1) + dirs.indexOf(facing);

  Vec wrapped(Grid<String> grid, Vec pos) {
    return Vec(pos.xInt % grid.width, pos.yInt % grid.height);
  }

  Vec move(Grid<String> grid, Vec pos, Vec dir, int steps) {
    while (steps > 0) {
      Vec newPos = wrapped(grid, pos + dir);
      while (grid.value(newPos) == ' ') {
        newPos = wrapped(grid, newPos + dir);
      }
      if (grid.value(newPos) == '#') {
        return pos;
      }
      pos = newPos;
      steps--;
    }
    return pos;
  }

  final List<Vec> dirs = [Vec.right, Vec.down, Vec.left, Vec.up];
}

enum Face { left, right, down, up, front, back }

class Path {
  Path(this.steps, this.turn);

  final int steps;
  final Vec turn;
}

class CubePos {
  CubePos(this.face, this.pos, this.facing);

  final Face face;
  final Vec pos;
  final Vec facing;
}

class CubeEdge {
  final Face face;
  final Vec facing;

  CubeEdge(this.face, this.facing);
}
