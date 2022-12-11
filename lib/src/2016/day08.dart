// https://adventofcode.com/2016/day/8

import '../../day.dart';
import '../util/grid2.dart';
import '../util/vec2.dart';

class Day08 extends AdventDay {
  Day08() : super(2016, 8, solution1: 116, solution2:'UPOJFLBCEZ');

  @override
  dynamic part1() {
    final Screen screen = Screen();
    for (final instruction in inputDataLines()) {
      runInstruction(screen, instruction);
    }
    return screen.numLit();
  }

  @override
  dynamic part2() {
    // don't have an OCR for this, so manual inspection of the
    // screen output from part1 is:
    return 'UPOJFLBCEZ';
  }

  final RegExp rectRx = RegExp(r'rect (\d+)x(\d+)');
  final RegExp colRx =  RegExp(r'rotate column x=(\d+) by (\d+)');
  final RegExp rowRx =  RegExp(r'rotate row y=(\d+) by (\d+)');

  void runInstruction(Screen screen, String instruction) {
    var match = rectRx.firstMatch(instruction);
    if (match != null) {
      screen.rect(int.parse(match.group(1)!), int.parse(match.group(2)!));
      return;
    }
    match = colRx.firstMatch(instruction);
    if (match != null) {
      screen.rotateColumn(int.parse(match.group(1)!), int.parse(match.group(2)!));
      return;
    }
    match = rowRx.firstMatch(instruction);
    if (match != null) {
      screen.rotateRow(int.parse(match.group(1)!), int.parse(match.group(2)!));
      return;
    }
    throw('Unknown instruction: $instruction');
  }
}

class Screen {
  Screen() : _grid = Grid<String>(50, 6, ".");

  final Grid<String> _grid;

  void rect(int width, int height) {
    for (int h = 0; h < height; h++) {
      for (int w = 0; w < width; w++) {
        _grid.setCell(Vec2.int(w, h), '#');
      }
    }
  }

  void rotateColumn(int col, int amount) {
    for (int times = 0; times < amount; times++) {
      String bottom = _grid.cell(Vec2.int(col, _grid.height - 1));
      for (int h = _grid.height - 1; h > 0; h--) {
        _grid.setCell(Vec2.int(col, h), _grid.cell(Vec2.int(col, h - 1)));
      }
      _grid.setCell(Vec2.int(col, 0), bottom);
    }
  }

  void rotateRow(int row, int amount) {
    for (int times = 0; times < amount; times++) {
      String right = _grid.cell(Vec2.int(_grid.width - 1, row));
      for (int w = _grid.width - 1; w > 0; w--) {
        _grid.setCell(Vec2.int(w, row), _grid.cell(Vec2.int(w - 1, row)));
      }
      _grid.setCell(Vec2.int(0, row), right);
    }
  }

  int numLit() {
    return _grid.cellsWhere((String s) => s == '#').length;
  }

  @override
  String toString() {
    return _grid.toString();
  }

}
