// https://adventofcode.com/2020/day/19

import 'package:aoc/aoc.dart';
import 'package:aoc/util/string.dart';

main() => Day19().solve();

class Day19 extends AdventDay {
  Day19() : super(2020, 19, name: 'Monster Messages');

  @override
  dynamic part1(String input) {
    final inputGroups = input.split('\n\n').where((e) => e.isNotEmpty);
    final rules = inputRules(inputGroups.first);
    final messages = inputGroups.last.lines;
    return messages
      .where((e) => ruleMatch(0, e, rules))
      .length;
  }

  @override
  dynamic part2(String input) {
    final inputGroups = input.split('\n\n').where((e) => e.isNotEmpty);
    final rules = inputRules(inputGroups.first);

    // Update rule 8 and 11
    rules[8] = Rule(RuleType.sequences, sequences: [[42], [42, 8]]);
    rules[11] = Rule(RuleType.sequences, sequences: [[42, 31], [42, 11, 31]]);

    final messages = inputGroups.last.split('\n');
    return messages
      .where((e) => ruleMatch(0, e, rules))
      .length;
  }

  Map<int, Rule> inputRules(String rulesText) {
    final rules = <int, Rule>{};
    final ruleRegex = RegExp(r'^(\d+): (.*)$');
    final constRegex = RegExp(r'^"(.*)"$');
    final ruleLines = rulesText.split('\n').where((e) => e.isNotEmpty);
    for (final line in ruleLines) {
      var match = ruleRegex.firstMatch(line);
      if (match != null) {
        final ruleNum = int.parse(match.group(1)!);
        final ruleText = match.group(2)!;
        match = constRegex.firstMatch(ruleText);
        if (match != null) {
          rules[ruleNum] = Rule(RuleType.constant, value: match.group(1)!);
        } else {
          final sequences = ruleText.split(' | ').map((e) => e.split(' ').map(int.parse).toList()).toList();
          rules[ruleNum] = Rule(RuleType.sequences, sequences: sequences);
        }
      }
    }
    return rules;
  }

  bool ruleMatch(int ruleNum, String text, Map<int, Rule> rules) {
    Iterable<int> endMatchIndices(int ruleNum, String text) {
      final indices = <int>[];
      if (text.isNotEmpty) {
        final rule = rules[ruleNum]!;
        switch (rule.type) {
          case RuleType.constant:
            if (text.startsWith(rule.value!)) {
              indices.add(rule.value!.length);
            }
            break;
          case RuleType.sequences:
            for (final sequence in rule.sequences!) {
              final seqRules = sequence.toList();
              int currentRule = 1;
              Iterable<int> currentMatches = endMatchIndices(seqRules[0], text);
              while (currentMatches.isNotEmpty && currentRule < seqRules.length) {
                final nextMatches = <int>[];
                for (final i in currentMatches) {
                  nextMatches.addAll(endMatchIndices(seqRules[currentRule], text.substring(i)).map((e) => i + e));
                }
                currentMatches = nextMatches;
                currentRule++;
              }
              indices.addAll(currentMatches);
            }
            break;
        }
      }
      return indices;
    }

    return endMatchIndices(ruleNum, text).any((e) => e == text.length);
  }
}

enum RuleType { constant, sequences }

class Rule {
  Rule(this.type, {this.value, this.sequences});

  RuleType type;
  String? value;
  List<List<int>>? sequences;

  @override
  String toString() =>
    value ?? sequences!.map((e) => e.join(' ')).join(' | ');
}
