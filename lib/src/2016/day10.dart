// https://adventofcode.com/2016/day/10

import 'package:advent_of_code_dart/src/util/collection.dart';

import '../../day.dart';

class Day10 extends AdventDay {
  Day10() : super(2016, 10, solution1: 56, solution2: 7847);

  @override
  dynamic part1() {
    final Factory factory = Factory(inputDataLines());
    return factory.runInstructions(<int>{61, 17});
  }

  @override
  dynamic part2() {
    final Factory factory = Factory(inputDataLines());
    factory.runInstructions();
    return
      factory.output[0]!.first *
      factory.output[1]!.first *
      factory.output[2]!.first;
  }
}

final RegExp valueReg = RegExp(r'value (\d+) goes to bot (\d+)');
final RegExp ruleReg = RegExp(r'bot (\d+) gives low to (output|bot) (\d+) and high to (output|bot) (\d+)');

class Factory {
  Factory(List<String> instructions) {
    for (final instruction in instructions) {
      final valueData = valueReg.firstMatch(instruction);
      if (valueData != null) {
        final int chip = int.parse(valueData.group(1)!);
        final int bot = int.parse(valueData.group(2)!);
        final botChips = bots.getOrElse(bot, [])..add(chip);
        bots[bot] = botChips;
      } else {
        final Rule rule = Rule.from(instruction);
        rules[rule.bot] = rule;
      }
    }
  }

  int? runInstructions([Set<int>? targetComparison]) {
    bool done = false;
    while (!done) {
      final fullBots = (bots.entries.where((kv) => kv.value.length > 1)).map((kv) => kv.key);
      if (fullBots.isNotEmpty) {
        final int bot = fullBots.first;
        final Rule rule = rules[bot]!;
        final chips = bots[bot]!..sort();
        final lowChip = chips.first;
        final highChip = chips.last;

        // Check to see if we are comparing the target chips
        if (targetComparison != null &&
            targetComparison.contains(lowChip) &&
            targetComparison.contains(highChip)) {
          // Found the target bot
          return bot;
        }

        // Transfer the chips
        if (rule.lowBot != null) {
          bots[rule.lowBot!] = bots.getOrElse(rule.lowBot!, [])..add(lowChip);
        }
        if (rule.lowOutput != null) {
          output[rule.lowOutput!] = output.getOrElse(rule.lowOutput!, [])..add(lowChip);
        }
        if (rule.highBot != null) {
          bots[rule.highBot!] = bots.getOrElse(rule.highBot!, [])..add(highChip);
        }
        if (rule.highOutput != null) {
          output[rule.highOutput!] = output.getOrElse(rule.highOutput!, [])..add(highChip);
        }
        bots.remove(bot);
      } else {
        done = true;
      }
    }
    return null;
  }

  final Map<int, List<int>> bots = {};
  final Map<int, List<int>> output = {};
  final Map<int, Rule> rules = {};
}

class Rule {
  Rule(this.bot, this.lowBot, this.highBot, [this.lowOutput, this.highOutput]);

  factory Rule.from(String s) {
    final data = ruleReg.firstMatch(s);
    if (data == null) {
      throw('Invalid rule: $s');
    }
    final bot = int.parse(data.group(1)!);
    final lowOutput = data.group(2) == "output";
    final low = int.parse(data.group(3)!);
    final highOutput = data.group(4) == "output";
    final high = int.parse(data.group(5)!);

    return Rule(bot,
      lowOutput ? null : low, highOutput ? null : high,
      lowOutput ? low : null, highOutput ? high : null,
    );
  }

  final int bot;
  final int? lowBot;
  final int? highBot;
  final int? lowOutput;
  final int? highOutput;
}
