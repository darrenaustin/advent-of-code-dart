// https://adventofcode.com/2023/day/8

import 'package:aoc/aoc.dart';
import 'package:aoc/util/math.dart';
import 'package:aoc/util/string.dart';

main() => Day08().solve();

class Day08 extends AdventDay {
  Day08() : super(2023, 8, name: 'Haunted Wasteland');

  @override
  dynamic part1(String input) {
    final instructions = input.lines.first;
    final network = parseNetwork(input);
    return stepsTo('AAA', instructions, network, (n) => n == 'ZZZ');
  }

  @override
  dynamic part2(String input) {
    final instructions = input.lines.first;
    final network = parseNetwork(input);

    final startingNodes = network.keys.where((k) => k.endsWith('A')).toList();
    return startingNodes
        .map((n) => stepsTo(n, instructions, network, (n) => n.endsWith('Z')))
        .reduce(lcm);
  }

  int stepsTo(String node, String instructions,
      Map<String, (String, String)> network, bool Function(String) endTest) {
    var steps = 0;
    var currentInstruction = 0;
    while (!endTest(node)) {
      node = instructions[currentInstruction] == 'L'
          ? network[node]!.$1
          : network[node]!.$2;
      steps++;
      currentInstruction = (currentInstruction + 1) % instructions.length;
    }
    return steps;
  }

  Map<String, (String, String)> parseNetwork(String input) {
    return Map.fromEntries(input.lines.skip(2).map((l) {
      final match = RegExp(r'(...) = \((...), (...)\)').firstMatch(l)!;
      final nodeName = match.group(1)!;
      return MapEntry(nodeName, (match.group(2)!, match.group(3)!));
    }));
  }
}
