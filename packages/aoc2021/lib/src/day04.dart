// https://adventofcode.com/2021/day/4

import 'package:aoc/aoc.dart';
import 'package:aoc/util/grid2.dart';
import 'package:aoc/util/string.dart';
import 'package:aoc/util/vec.dart';
import 'package:collection/collection.dart';

main() => Day04().solve();

class Day04 extends AdventDay {
  Day04() : super(
    2021, 4, name: 'Giant Squid',
    solution1: 39902, solution2: 26936,
  );

  @override
  dynamic part1(String input) {
    final boards = parseBoards(input);
    for (final n in parseDrawNumbers(input)) {
      for (final b in boards) {
        removeNumber(b, n);
        if (winning(b)) {
          return score(b, n);
        }
      }
    }
  }

  @override
  dynamic part2(String input) {
    final boards = parseBoards(input);
    Iterable<Grid<int?>> boardsLeft = boards;
    for (final n in parseDrawNumbers(input)) {
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

  Iterable<int> parseDrawNumbers(String input) =>
    input.lines.first.split(',').map(int.parse);

  List<Grid<int?>> parseBoards(String input) => input
    .split('\n\n')
    .skip(1)
    .map((boardData) => Grid<int?>.from(boardData
        .lines
        .map((l) => l.trim().split(RegExp(r'\s+'))
        .map((n) => int.parse(n.trim())).toList())
        .toList(),
      null
    ))
    .toList();

  final List<List<Vec2>> winningGroups = [
    // Diagonals don't count, so just lines for rows and columns.
    ...List.generate(5, (r) => List.generate(5, (c) => Vec2.int(c, r))),
    ...List.generate(5, (c) => List.generate(5, (r) => Vec2.int(c, r))),
  ];

  void removeNumber(Grid<int?> board, int number) =>
    board.updateCellsWhere((n) => n == number, (_) => null);

  bool winning(Grid<int?> board) =>
    winningGroups.any((g) => g.every((p) => board.cell(p) == null));

  int score(Grid<int?> board, int winningNumber) =>
    board.cells().whereNotNull().sum * winningNumber;
}
