// https://adventofcode.com/2022/day/5

import 'package:aoc/aoc.dart';

main() => Day05().solve();

class Day05 extends AdventDay {
  Day05() : super(
    2022, 5, name: '',
  );

  @override
  dynamic part1(String input) => 'Need to migrate';

  @override
  dynamic part2(String input) => 'Need to migrate';
}

// https://adventofcode.com/2022/day/5
// 
// import 'package:aoc/aoc.dart';
// 
// class Day05 extends AdventDay {
//   Day05() : super(2022, 5, solution1: 'CNSZFDVLJ', solution2: 'QNDWLMGNS');
// 
//   @override
//   dynamic part1() {
//     final Dock dock = Dock(input())..executeMoves();
//     return dock.stacks.map((s) => s.last).join();
//   }
// 
//   @override
//   dynamic part2() {
//     final Dock dock = Dock(input())..executeBulkMoves();
//     return dock.stacks.map((s) => s.last).join();
//   }
// }
// 
// class Dock {
//   Dock(String input) {
//     final inputParts = input.split('\n\n');
//     final dockInput = inputParts[0].split('\n');
//     final instructionInput = inputParts[1].trim().split('\n');
// 
//     final String stackNums = dockInput.last;
//     final numStacks = int.parse(stackNums.trim().split(RegExp(r'\s+')).last);
//     stacks = List.generate(numStacks, (index) => <String>[]);
//     for (final row in dockInput.reversed.skip(1)) {
//       int stack = 0;
//       int itemIndex = 1;
//       while (itemIndex < row.length) {
//         final String item = row[itemIndex];
//         if (item != ' ') {
//           stacks[stack].add(item);
//         }
//         itemIndex += 4;
//         stack += 1;
//       }
//     }
// 
//     moves = instructionInput
//      .map((m) => RegExp(r'move (\d+) from (\d+) to (\d+)').firstMatch(m)!)
//      .map((m) => Move(int.parse(m.group(1)!), int.parse(m.group(2)!), int.parse(m.group(3)!)))
//      .toList();
//   }
// 
//   late final List<List<String>> stacks;
//   late final List<Move> moves;
// 
//   void executeMoves() {
//     for (final move in moves) {
//       for (int n = 0; n < move.amount; n++) {
//         final item = stacks[move.from - 1].removeLast();
//         stacks[move.to - 1].add(item);
//       }
//     }
//   }
// 
//   void executeBulkMoves() {
//     for (final move in moves) {
//       final items = <String>[];
//       for (int n = 0; n < move.amount; n++) {
//         items.add(stacks[move.from - 1].removeLast());
//       }
//       stacks[move.to - 1].addAll(items.reversed);
//     }
//   }
// }
// 
// class Move {
//   Move(this.amount, this.from, this.to);
// 
//   final int amount;
//   final int from;
//   final int to;
// }
// 