// https://adventofcode.com/2023/day/19

import 'dart:math';

import 'package:aoc/aoc.dart';
import 'package:aoc/util/collection.dart';
import 'package:aoc/util/string.dart';
import 'package:collection/collection.dart';

main() => Day19().solve();

class Day19 extends AdventDay {
  Day19() : super(2023, 19, name: 'Aplenty');

  @override
  dynamic part1(String input) {
    final [flowInput, partsInput] = input.split('\n\n');
    final flows = parseFlows(flowInput);
    return parseParts(partsInput)
        .where((p) => approved(p, flows))
        .map((p) => p.values.sum)
        .sum;
  }

  @override
  dynamic part2(String input) {
    final flows = parseFlows(input.split('\n\n')[0]);

    var sum = 0;
    final open = {
      (
        'in',
        {
          'x': (1, 4000),
          'm': (1, 4000),
          'a': (1, 4000),
          's': (1, 4000),
        }
      )
    };
    while (open.isNotEmpty) {
      var (flowName, constraints) = open.removeFirst();
      if (flowName == 'R') {
        continue;
      } else if (flowName == 'A') {
        sum += constraints.values.map((e) => e.$2 - e.$1 + 1).product;
      } else {
        // Run through flow
        final flow = flows[flowName]!;
        for (final rule in flow) {
          switch (parseRule(rule)) {
            case (String comp, bool lessThan, int amount, String sendTo):
              {
                // comparison
                var (succeedMin, succeedMax) = constraints[comp]!;
                var (failMin, failMax) = constraints[comp]!;
                if (lessThan) {
                  succeedMax = min(succeedMax, amount - 1);
                  failMin = max(failMin, amount);
                } else {
                  succeedMin = max(succeedMin, amount + 1);
                  failMax = min(failMax, amount);
                }

                // Add a new entry to test the success path
                final newConstraints =
                    Map<String, (int, int)>.from(constraints);
                newConstraints[comp] = (succeedMin, succeedMax);
                open.add((sendTo, newConstraints));

                // Update the fail constraints and continue with this flow
                constraints[comp] = (failMin, failMax);
              }
            case null:
              {
                // Send to next flow
                open.add((rule, constraints));
              }
          }
        }
      }
    }
    return sum;
  }

  Map<String, Iterable<String>> parseFlows(String input) {
    final flows = <String, Iterable<String>>{};
    for (final l in input.lines) {
      final match = RegExp(r'(\w+)\{(.*)\}').firstMatch(l)!;
      final name = match.group(1)!;
      final flow = match.group(2)!.split(',');
      flows[name] = flow;
    }
    return flows;
  }

  Iterable<Map<String, int>> parseParts(String input) {
    final parts = <Map<String, int>>[];
    for (final l in input.lines) {
      final part = <String, int>{};
      final matches = RegExp(r'\{?(x|m|a|s)=(\d+)(,|\})?').allMatches(l);
      for (final m in matches) {
        part[m.group(1)!] = int.parse(m.group(2)!);
      }
      parts.add(part);
    }
    return parts;
  }

  (String, bool, int, String)? parseRule(String input) {
    final match = RegExp(r'(\w+)(<|>)(\d+):(\w+)').firstMatch(input);
    if (match != null) {
      final component = match.group(1)!;
      final lessThan = match.group(2)! == '<';
      final amount = int.parse(match.group(3)!);
      final sendTo = match.group(4)!;
      return (component, lessThan, amount, sendTo);
    }
    return null;
  }

  bool approved(Map<String, int> part, Map<String, Iterable<String>> flows) {
    var flowName = 'in';
    while (flowName != 'R' && flowName != 'A') {
      flowName = evaluateFlow(part, flows[flowName]!);
    }
    return flowName == 'A';
  }

  String evaluateFlow(Map<String, int> part, Iterable<String> flow) {
    for (final rule in flow) {
      final match = RegExp(r'(\w+)(<|>)(\d+):(\w+)').firstMatch(rule);
      if (match != null) {
        // comparison
        final comp = match.group(1)!;
        final lessThan = match.group(2)! == '<';
        final amount = int.parse(match.group(3)!);
        final sentTo = match.group(4)!;

        final partComp = part[comp]!;
        final cond = lessThan ? (partComp < amount) : (partComp > amount);
        if (cond) {
          return sentTo;
        }
      } else {
        // just a flow name
        return rule;
      }
    }
    throw Exception('Didn\'t match any rule!');
  }
}
