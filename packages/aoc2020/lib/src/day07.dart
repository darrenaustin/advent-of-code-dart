// https://adventofcode.com/2020/day/7

import 'package:aoc/aoc.dart';
import 'package:aoc/util/string.dart';
import 'package:collection/collection.dart';

main() => Day07().solve();

class Day07 extends AdventDay {
  Day07() : super(2020, 7, name: 'Handy Haversacks');

  @override
  dynamic part1(String input) {
    final rules = parseRules(input);
    return rules.keys.where((bag) => canHold('shiny gold', bag, rules)).length;
  }

  @override
  dynamic part2(String input) => countContents('shiny gold', parseRules(input));

  Map<String, Bag> parseRules(String input) {
    final ruleRegexp = RegExp(r'^(.+) bags contain (.*).$');
    final contentRegexp = RegExp(r'(\d+) (.+?) bag');

    final rules = <String, Bag>{};
    final rulesText = input.lines;
    for (final ruleText in rulesText) {
      final ruleMatch = ruleRegexp.firstMatch(ruleText);
      if (ruleMatch != null) {
        final bagColor = ruleMatch.group(1)!;
        final bagContentsText = ruleMatch.group(2)!;
        late final Map<String, int> bagContents;
        if (bagContentsText != 'no other bags') {
          final contentsMatches = contentRegexp.allMatches(bagContentsText);
          bagContents = Map.fromEntries(contentsMatches.map((match) =>
              MapEntry(match.group(2)!, int.parse(match.group(1)!))));
        } else {
          bagContents = {};
        }
        rules[bagColor] = Bag(bagColor, bagContents);
      } else {
        throw Exception('Unable to parse rule: $rulesText');
      }
    }
    return rules;
  }

  bool canHold(String bagColor, String containerColor, Map<String, Bag> rules) {
    final container = rules[containerColor]!;
    return container.contents.containsKey(bagColor) ||
        container.contents.keys.any((color) => canHold(bagColor, color, rules));
  }

  int countContents(String bagColor, Map<String, Bag> rules) {
    final rule = rules[bagColor]!;
    return rule.contents.keys
        .map((color) =>
            rule.contents[color]! * (countContents(color, rules) + 1))
        .sum;
  }
}

class Bag {
  Bag(this.color, this.contents);

  final String color;
  final Map<String, int> contents;
}
