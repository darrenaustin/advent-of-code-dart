// https://adventofcode.com/2020/day/11

import 'package:aoc/aoc.dart';
import 'package:aoc/util/grid2.dart';
import 'package:aoc/util/string.dart';
import 'package:aoc/util/vec2.dart';
import 'package:collection/collection.dart';

main() => Day11().solve();

typedef SeatRules = Grid<String> Function(Grid<String>);

class Day11 extends AdventDay {
  Day11() : super(2020, 11, name: 'Seating System');

  @override
  dynamic part1(String input) =>
      numOccupiedSeatsAtEquilibrium(parseSeatChart(input), adjacentSeatRules);

  @override
  int? part2(String input) => numOccupiedSeatsAtEquilibrium(
      parseSeatChart(input), visiblyAdjacentSeatRules);

  Grid<String> parseSeatChart(String input) => Grid<String>.from(
        input.lines.map((e) => e.chars).toList(),
        '.',
      );

  dynamic numOccupiedSeatsAtEquilibrium(Grid<String> seats, SeatRules rules) {
    var equilibrium = false;
    while (!equilibrium) {
      final nextSeats = rules(seats);
      equilibrium = seats == nextSeats;
      seats = nextSeats;
    }
    return seats.cellsWhere(isSeatOccupied).length;
  }

  bool isSeatOccupied(String cell) => cell == '#';
  bool isSpace(String cell) => cell == '.';

  Grid<String> adjacentSeatRules(Grid<String> seats) {
    final nextSeats = seats.copy();
    for (final loc in seats.locations()) {
      switch (seats.cell(loc)) {
        case 'L':
          // If there are no adjacent occupied seats, it becomes occupied
          if (seats.neighbors(loc).none(isSeatOccupied)) {
            nextSeats.setCell(loc, '#');
          }
          break;

        case '#':
          // If there are at least 4 occupied adjacent seats, it becomes empty
          if (seats.neighbors(loc).where(isSeatOccupied).length >= 4) {
            nextSeats.setCell(loc, 'L');
          }
          break;
      }
    }
    return nextSeats;
  }

  Grid<String> visiblyAdjacentSeatRules(Grid<String> seats) {
    final nextSeats = seats.copy();
    for (final loc in seats.locations()) {
      switch (seats.cell(loc)) {
        case 'L':
          // If there are no visibly adjacent occupied seats, it becomes occupied
          // if (seats.visiblyAdjacent(x, y, isSpace).none(isSeatOccupied)) {
          if (visiblyAdjacent(seats, loc, isSpace).none(isSeatOccupied)) {
            nextSeats.setCell(loc, '#');
          }
          break;

        case '#':
          // If there are at least 5 visibly occupied adjacent seats, it becomes empty
          // if (seats.visiblyAdjacent(x, y, isSpace).where(isSeatOccupied).length >= 5) {
          if (visiblyAdjacent(seats, loc, isSpace)
                  .where(isSeatOccupied)
                  .length >=
              5) {
            nextSeats.setCell(loc, 'L');
          }
          break;
      }
    }
    return nextSeats;
  }

  Iterable<String> visiblyAdjacent(
      Grid<String> seats, Vec2 location, bool Function(String) invisibleTest) {
    String? firstVisibleInDirection(Vec2 directionOffset) {
      Vec2 closest = location + directionOffset;
      while (seats.validCell(closest) && invisibleTest(seats.cell(closest))) {
        closest += directionOffset;
      }
      return seats.validCell(closest) ? seats.cell(closest) : null;
    }

    return Vec2.aroundDirs
        .map((p) => firstVisibleInDirection(p))
        .whereNotNull();
  }
}
