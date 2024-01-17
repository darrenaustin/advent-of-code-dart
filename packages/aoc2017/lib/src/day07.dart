// ignore_for_file: public_member_api_docs, sort_constructors_first
// https://adventofcode.com/2017/day/7

import 'package:aoc/aoc.dart';
import 'package:aoc/util/collection.dart';
import 'package:aoc/util/string.dart';
import 'package:collection/collection.dart';

main() => Day07().solve();

class Day07 extends AdventDay {
  Day07() : super(2017, 7, name: 'Recursive Circus');

  @override
  dynamic part1(String input) {
    final towers = parseTowers(input);

    String? parent(String node) =>
        towers.values.firstWhereOrNull((n) => n.children.contains(node))?.name;

    return towers.keys.firstWhere((n) => parent(n) == null);
  }

  @override
  dynamic part2(String input) {
    final towers = parseTowers(input);

    String? parent(String node) =>
        towers.values.firstWhereOrNull((n) => n.children.contains(node))?.name;

    int weight(String nodeName) {
      final node = towers[nodeName]!;
      return node.weight + node.children.map((n) => weight(n)).sum;
    }

    int? unbalancedAmount(String nodeName) {
      final node = towers[nodeName]!;
      final unbalancedChildAmount = node.children
          .map(unbalancedAmount)
          .firstWhereOrNull((n) => n != null);
      if (unbalancedChildAmount != null) {
        return unbalancedChildAmount;
      }

      final weights = node.children.map(weight).toList();
      final difference = weights.onlyDifference();
      if (difference != null) {
        final (off, baseline) = difference;
        final childIndex = weights.indexOf(off);
        final child = towers[node.children[childIndex]]!;
        return child.weight + (baseline - off);
      }
      return null;
    }

    final root = towers.keys.firstWhere((n) => parent(n) == null);
    return unbalancedAmount(root);
  }

  Map<String, Node> parseTowers(String input) => Map.fromEntries(
      input.lines.map((l) => Node.parse(l)).map((n) => MapEntry(n.name, n)));
}

class Node {
  Node(this.name, this.weight, this.children);

  factory Node.parse(String input) {
    final match = RegExp(r'([a-z]+) \((\d+)\)(.*)').firstMatch(input)!;
    final name = match.group(1)!;
    final weight = int.parse(match.group(2)!);
    final anyChildren = match.group(3);
    List<String>? children;
    if (anyChildren != null && anyChildren.startsWith(' -> ')) {
      children = anyChildren.substring(4).split(', ').toList();
    }
    return Node(name, weight, children ?? []);
  }

  final String name;
  final int weight;
  final List<String> children;

  @override
  String toString() =>
      'Node(name: $name, weight: $weight, children: $children)';
}
