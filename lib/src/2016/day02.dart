// https://adventofcode.com/2016/day/2

import '../../day.dart';
import '../util/vec2.dart';

class Day02 extends AdventDay {
  Day02() : super(2016, 2, solution1: '44558', solution2: '6BBAD');

  @override
  dynamic part1() {
    const List<List<String>> touchPad = [
      ['1', '2', '3'],
      ['4', '5', '6'],
      ['7', '8', '9'],
    ];
    return keycode(touchPad, Vector(1, 1), inputDirections());
  }

  @override
  dynamic part2() {
    const List<List<String>> touchPad = [
      [  '',  '', '1',  '',  ''],
      [  '', '2', '3', '4',  ''],
      [ '5', '6', '7', '8', '9'],
      [  '', 'A', 'B', 'C',  ''],
      [  '',  '', 'D',  '',  ''],
    ];
    return keycode(touchPad, Vector(0, 2), inputDirections());
  }

  Iterable<Iterable<String>> inputDirections() {
    return inputDataLines().map((s) => s.split(''));
  }

  String keycode(List<List<String>> touchPad, Vector keyPosition, Iterable<Iterable<String>> directions) {
    bool validPos(Vector pos) =>
        0 <= pos.x && pos.x < touchPad[0].length &&
        0 <= pos.y && pos.y < touchPad.length &&
        touchPad[pos.y.toInt()][pos.x.toInt()].isNotEmpty;

    List<String> pressed = [];
    for (Iterable<String> line in directions) {
      for (String dir in line) {
        final Vector newPosition = keyPosition + directionVector[dir]!;
        if (validPos(newPosition)) {
          keyPosition = newPosition;
        }
      }
      pressed.add(touchPad[keyPosition.y.toInt()][keyPosition.x.toInt()]);
    }
    return pressed.join();
  }
}

const Map<String, Vector> directionVector = {
  'U': Vector( 0, -1),
  'D': Vector( 0,  1),
  'L': Vector(-1,  0),
  'R': Vector( 1,  0),
};
