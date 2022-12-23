// https://adventofcode.com/2021/day/4

import '../../day.dart';
import '../util/collection.dart';
import '../util/grid2.dart';
import '../util/vec2.dart';

class Day04 extends AdventDay {
  Day04() : super(2021, 4, solution1: 39902, solution2: 26936);

  @override
  dynamic part1() {
    final boards = inputBoards();
    for (final n in inputDrawNumbers()) {
      for (final b in boards) {
        removeNumber(b, n);
        if (winning(b)) {
          return score(b, n);
        }
      }
    }
  }

  @override
  dynamic part2() {
    final boards = inputBoards();
    Iterable<Grid<int?>> boardsLeft = boards;
    for (final n in inputDrawNumbers()) {
      if (boardsLeft.length == 1) {
        final board = boardsLeft.first;
        removeNumber(board, n);
        if (winning(board)) {
          return score(board, n);
        }
      } else {
        for (final b in boardsLeft) {
          removeNumber(b, n);
        }
        boardsLeft = boardsLeft.where((b) => !winning(b));
      }
    }
  }

  Iterable<int> inputDrawNumbers() {
    return inputDataLines().first.split(',').map((n) => int.parse(n));
  }

  Iterable<Grid<int?>> inputBoards() {
    List<Grid<int?>> boards = [];
    final boardsData = inputData().split('\n\n').skip(1);
    for (final boardData in boardsData) {
      final boardNumbers = boardData.split('\n').map((l) => l.trim().split(RegExp(r'\s+')).map((n) => int.parse(n.trim())).toList()).toList();
      final board = Grid<int?>(5, 5, null);
      for (int row = 0; row < 5; row++) {
        for (int col = 0; col < 5; col++) {
          board.setCell(Vec2.int(col, row), boardNumbers[row][col]);
        }
      }
      boards.add(board);
    }
    return boards;
  }

  final List<List<Vec2>> winningLocations = [
    ...List.generate(5, (r) => List.generate(5, (c) => Vec2.int(c, r))),
    ...List.generate(5, (c) => List.generate(5, (r) => Vec2.int(c, r))),
  ];

  void removeNumber(Grid<int?> board, int number) {
    board.updateCellsWhere((n) => n == number, (_) => null);
  }

  bool winning(Grid<int?> board) {
    return winningLocations.any((g) => g.every((v) => board.cell(v) == null));
  }

  int score(Grid<int?> board, int winningNumber) {
    return board.cellsWhere((n) => n != null).whereType<int>().sum * winningNumber;
  }
}
