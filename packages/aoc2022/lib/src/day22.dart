// https://adventofcode.com/2022/day/22

import 'package:aoc/aoc.dart';
import 'package:aoc/util/grid2.dart';
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
    final startOff = move(grid, Vec2.zero, Vec2.right, 1);

    Vec2 pos = move(grid, startOff, Vec2.left, 1);
    Vec2 facing = Vec2.right;

    for (final p in path) {
      int steps = p.steps;
      while (steps > 0) {
        Vec2 newPos = wrapped(grid, pos + facing);
        while (grid.cell(newPos) == ' ') {
          newPos = wrapped(grid, newPos + facing);
        }
        if (grid.cell(newPos) == '#') {
          break;
        }
        pos = newPos;
        steps--;
      }
      if (p.turn != Vec2.zero) {
        final int facingIndex = dirs.indexOf(facing);
        if (p.turn == Vec2.right) {
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

    final faceOffset = <Face, Vec2>{
      Face.down: Vec2(50, 0),
      Face.right: Vec2(100, 0),
      Face.front: Vec2(50, 50),
      Face.up: Vec2(50, 100),
      Face.left: Vec2(0, 100),
      Face.back: Vec2(0, 150),
    };

    final edges = <Face, Map<Vec2, CubeEdge>>{
      Face.up: {
        Vec2.up: CubeEdge(Face.front, Vec2.up),
        Vec2.down: CubeEdge(Face.back, Vec2.left),
        Vec2.left: CubeEdge(Face.left, Vec2.left),
        Vec2.right: CubeEdge(Face.right, Vec2.left),
      },
      Face.down: {
        Vec2.up: CubeEdge(Face.back, Vec2.right),
        Vec2.down: CubeEdge(Face.front, Vec2.down),
        Vec2.left: CubeEdge(Face.left, Vec2.right),
        Vec2.right: CubeEdge(Face.right, Vec2.right),
      },
      Face.left: {
        Vec2.up: CubeEdge(Face.front, Vec2.right),
        Vec2.down: CubeEdge(Face.back, Vec2.down),
        Vec2.left: CubeEdge(Face.down, Vec2.right),
        Vec2.right: CubeEdge(Face.up, Vec2.right),
      },
      Face.right: {
        Vec2.up: CubeEdge(Face.back, Vec2.up),
        Vec2.down: CubeEdge(Face.front, Vec2.left),
        Vec2.left: CubeEdge(Face.down, Vec2.left),
        Vec2.right: CubeEdge(Face.up, Vec2.left),
      },
      Face.front: {
        Vec2.up: CubeEdge(Face.down, Vec2.up),
        Vec2.down: CubeEdge(Face.up, Vec2.down),
        Vec2.left: CubeEdge(Face.left, Vec2.down),
        Vec2.right: CubeEdge(Face.right, Vec2.up),
      },
      Face.back: {
        Vec2.up: CubeEdge(Face.left, Vec2.up),
        Vec2.down: CubeEdge(Face.right, Vec2.down),
        Vec2.left: CubeEdge(Face.down, Vec2.down),
        Vec2.right: CubeEdge(Face.up, Vec2.up),
      },
    };

    Vec2 mapPos(Vec2 pos, Vec2 fromDir, Vec2 toDir) {
      final wrappedX = pos.xInt < 0 ? faceSize - 1 : pos.xInt >= faceSize ? 0 : pos.xInt;
      final wrappedY = pos.yInt < 0 ? faceSize - 1 : pos.yInt >= faceSize ? 0 : pos.yInt;
      final wrapped = Vec2.int(wrappedX, wrappedY);
      if (fromDir == toDir) {
        return wrapped;
      }
      if (fromDir == Vec2.up) {
        if (toDir == Vec2.right) {
          return Vec2(0, wrapped.x);
        }
        throw('Huh?');
      } else if (fromDir == Vec2.down) {
        if (toDir == Vec2.left) {
          return Vec2(faceSize - 1, wrapped.x);
        }
        throw('Huh?');
      } else if (fromDir == Vec2.left) {
        if (toDir == Vec2.down) {
          return Vec2(wrapped.y, 0);
        } else if (toDir == Vec2.right) {
          return Vec2(0, faceSize - wrapped.y - 1);
        }
        throw('Huh?');
      } else if (fromDir == Vec2.right) {
        if (toDir == Vec2.up) {
          return Vec2.int(wrapped.yInt, faceSize - 1);
        } else if (toDir == Vec2.left) {
          return Vec2.int(faceSize - 1, faceSize - wrapped.yInt - 1);
        }
        throw('Huh?');
      }
      throw('Huh?');
    }

    bool validFaceCell(Vec2 p) => (0 <= p.x && p.x < faceSize && 0 <= p.y && p.y < faceSize);

    CubePos newPos(CubePos start) {
      final nextPos = start.pos + start.facing;
      if (validFaceCell(nextPos)) {
        return CubePos(start.face, nextPos, start.facing);
      }
      final edge = edges[start.face]![start.facing]!;
      return CubePos(edge.face, mapPos(nextPos, start.facing, edge.facing), edge.facing);
    }

    String cellAt(CubePos pos) => grid.cell(faceOffset[pos.face]! + pos.pos);

    CubePos pos = CubePos(Face.down, Vec2.zero, Vec2.right);
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
      if (p.turn != Vec2.zero) {
        final int facingIndex = dirs.indexOf(pos.facing);
        if (p.turn == Vec2.right) {
          pos = CubePos(pos.face, pos.pos, dirs[(facingIndex + 1) % 4]);
        } else {
          pos = CubePos(pos.face, pos.pos, dirs[(facingIndex + 3) % 4]);
        }
      }
    }
    return password(faceOffset[pos.face]! + pos.pos, pos.facing);
  }

  Grid<String> face(Grid<String> grid, Vec2 start, int size) {
    final face = Grid<String>(size, size, ' ');
    for (int row = 0; row < size; row++) {
      for (int col = 0; col < size; col++) {
        face.setCell(Vec2.int(col, row),
            grid.cell(Vec2.int(col + start.xInt, row + start.yInt)));
      }
    }
    return face;
  }

  Grid<String> parseGrid(String input) {
    final gridData = input.split('\n\n').first.split('\n').map((l) => l.split('')).toList();
    final width = gridData.map((r) => r.length).max;
    final height = gridData.length;
    final grid = Grid<String>(width, height, ' ');
    for (int y = 0; y < grid.height; y++) {
      final row = gridData[y];
      for (int x = 0; x < grid.width; x++) {
        if (x < row.length) {
          grid.setCell(Vec2.int(x, y), gridData[y][x]);
        }
      }
    }
    return grid;
  }

  List<Path> parsePath(String input) {
    final pathData = input.split('\n\n').last.trim();
    final pathReg = RegExp(r'(\d+)([RL])?');
    final matches = pathReg.allMatches(pathData);
    return matches.map((m) => Path(int.parse(m.group(1)!),
      m.group(2) == null ? Vec2.zero : m.group(2)! == 'L' ? Vec2.left : Vec2.right)).toList();
  }

  int password(Vec2 pos, Vec2 facing) => 1000 * (pos.yInt + 1) + 4 * (pos.xInt + 1) + dirs.indexOf(facing);

  Vec2 wrapped(Grid<String> grid, Vec2 pos) {
    return Vec2.int(pos.xInt % grid.width, pos.yInt % grid.height);
  }

  Vec2 move(Grid<String> grid, Vec2 pos, Vec2 dir, int steps) {
    while (steps > 0) {
      Vec2 newPos = wrapped(grid, pos + dir);
      while (grid.cell(newPos) == ' ') {
        newPos = wrapped(grid, newPos + dir);
      }
      if (grid.cell(newPos) == '#') {
        return pos;
      }
      pos = newPos;
      steps--;
    }
    return pos;
  }

  final List<Vec2> dirs = [Vec2.right, Vec2.down, Vec2.left, Vec2.up];
}

enum Face { left, right, down, up, front, back }

class Path {
  Path(this.steps, this.turn);

  final int steps;
  final Vec2 turn;
}

class CubePos {
  CubePos(this.face, this.pos, this.facing);

  final Face face;
  final Vec2 pos;
  final Vec2 facing;
}

class CubeEdge {
  final Face face;
  final Vec2 facing;

  CubeEdge(this.face, this.facing);
}
