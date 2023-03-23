// https://adventofcode.com/2020/day/6

import 'package:aoc/aoc.dart';
import 'package:aoc/util/string.dart';
import 'package:collection/collection.dart';

main() => Day06().solve();

class Day06 extends AdventDay {
  Day06() : super(
    2020, 6, name: 'Custom Customs',
    solution1: 6310, solution2: 3193,
  );

  @override
  dynamic part1(String input) => parseAnswers(input)
    .map(numAnsweredQuestions)
    .sum;

  @override
  dynamic part2(String input) => parseAnswers(input)
    .map(numFullyAnsweredQuestions)
    .sum;

  List<List<String>> parseAnswers(String input) => input
    .split('\n\n')
    .map((group) => group.lines.toList())
    .toList();

  int numAnsweredQuestions(List<String> groupAnswers) =>
    groupAnswers.join().chars.toSet().length;

  int numFullyAnsweredQuestions(List<String> groupAnswers) =>
    groupAnswers
      .map((answers) => answers.chars.toSet())
      .reduce((common, answers) => common.intersection(answers))
      .length;
}
