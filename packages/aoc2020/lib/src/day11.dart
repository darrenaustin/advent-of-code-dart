// https://adventofcode.com/2020/day/11

import 'package:aoc/aoc.dart';
import 'package:aoc/util/grid.dart';
import 'package:aoc/util/string.dart';
import 'package:aoc/util/vec.dart';
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
    return seats.values().where(isSeatOccupied).length;
  }

  bool isSeatOccupied(String cell) => cell == '#';
  bool isSpace(String cell) => cell == '.';

  Grid<String> adjacentSeatRules(Grid<String> seats) {
    final nextSeats = seats.copy();
    for (final loc in seats.locations()) {
      switch (seats.value(loc)) {
        case 'L':
          // If there are no adjacent occupied seats, it becomes occupied
          if (seats.neighborValues(loc).none(isSeatOccupied)) {
            nextSeats.setValue(loc, '#');
          }
          break;

        case '#':
          // If there are at least 4 occupied adjacent seats, it becomes empty
          if (seats.neighborValues(loc).where(isSeatOccupied).length >= 4) {
            nextSeats.setValue(loc, 'L');
          }
          break;
      }
    }
    return nextSeats;
  }

  Grid<String> visiblyAdjacentSeatRules(Grid<String> seats) {
    final nextSeats = seats.copy();
    for (final loc in seats.locations()) {
      switch (seats.value(loc)) {
        case 'L':
          // If there are no visibly adjacent occupied seats, it becomes occupied
          // if (seats.visiblyAdjacent(x, y, isSpace).none(isSeatOccupied)) {
          if (visiblyAdjacent(seats, loc, isSpace).none(isSeatOccupied)) {
            nextSeats.setValue(loc, '#');
          }
          break;

        case '#':
          // If there are at least 5 visibly occupied adjacent seats, it becomes empty
          // if (seats.visiblyAdjacent(x, y, isSpace).where(isSeatOccupied).length >= 5) {
          if (visiblyAdjacent(seats, loc, isSpace)
                  .where(isSeatOccupied)
                  .length >=
              5) {
            nextSeats.setValue(loc, 'L');
          }
          break;
      }
    }
    return nextSeats;
  }

  Iterable<String> visiblyAdjacent(
      Grid<String> seats, Vec location, bool Function(String) invisibleTest) {
    String? firstVisibleInDirection(Vec directionOffset) {
      Vec closest = location + directionOffset;
      while (
          seats.validLocation(closest) && invisibleTest(seats.value(closest))) {
        closest += directionOffset;
      }
      return seats.validLocation(closest) ? seats.value(closest) : null;
    }

    return Vec.aroundDirs.map((p) => firstVisibleInDirection(p)).whereNotNull();
  }
}
