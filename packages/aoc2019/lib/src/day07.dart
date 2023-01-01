// https://adventofcode.com/2019/day/7

import 'package:aoc/aoc.dart';

main() => Day07().solve();

class Day07 extends AdventDay {
  Day07() : super(
    2019, 7, name: '',
  );

  @override
  dynamic part1(String input) => 'Need to migrate';

  @override
  dynamic part2(String input) => 'Need to migrate';
}

// https://adventofcode.com/2019/day/7
// 
// import 'package:aoc/aoc.dart';
// import 'package:aoc/util/collection.dart';
// import 'package:collection/collection.dart';
// 
// import 'intcode.dart';
// 
// class Day07 extends AdventDay {
//   Day07() : super(2019, 7, solution1: 24405, solution2: 8271623);
// 
//   @override
//   dynamic part1() {
//     final program = inputData();
// 
//     int runAmps(List<int> phases, [initialInput = 0]) {
//       var input = initialInput;
//       for (final phase in phases) {
//         final machine = Intcode.from(program: program, input: [phase, input]);
//         while (!machine.execute()) {}
//         input = machine.output.last;
//       }
//       return input;
//     }
// 
//     return permutations(range(5).toSet()).map(runAmps).max;
//   }
// 
//   @override
//   dynamic part2() {
//     final program = inputData();
// 
//     int runAmps(List<int> phases, [initialInput = 0]) {
//       final inputs = phases.map((p) => [p]).toList();
//       final machines = <Intcode>[];
//       for (int i = 0; i < phases.length; i++) {
//         machines.add(Intcode.from(
//             program: program,
//             input: inputs[i],
//             output: inputs[(i + 1) % phases.length]
//         ));
//       }
//       inputs[0].add(initialInput);
//       while (!machines.every((m) => m.complete)) {
//         for (final m in machines) {
//           m.execute();
//         }
//       }
//       return machines.last.output.last;
//     }
// 
//     return permutations(range(5, 10).toSet()).map(runAmps).max;
//   }
// 
//   Iterable<List<int>> permutations(Set <int>elements) {
//     if (elements.isEmpty) {
//       return [];
//     }
//     if (elements.length == 1) {
//       return [[elements.first]];
//     }
//     final perms = <List<int>>[];
//     for (final element in elements) {
//       perms.addAll(
//         permutations(elements.difference({element}))
//           .map((es) => <int>[element, ...es])
//       );
//     }
//     return perms;
//   }
// }
// 