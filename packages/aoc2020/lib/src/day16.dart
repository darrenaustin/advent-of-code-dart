// https://adventofcode.com/2020/day/16

import 'package:aoc/aoc.dart';
import 'package:aoc/util/collection.dart';
import 'package:aoc/util/string.dart';
import 'package:collection/collection.dart';

main() => Day16().solve();

class Day16 extends AdventDay {
  Day16() : super(2020, 16, name: 'Ticket Translation');

  @override
  dynamic part1(String input) {
    final notes = parseNotes(input);
    final validNums = notes.validNumbers();

    // Generate list of invalid numbers from all the nearby tickets
    final invalidNums = <int>[];
    for (final ticket in notes.nearbyTickets) {
      invalidNums.addAll(ticket.where((e) => !validNums.contains(e)));
    }
    return invalidNums.sum;
  }

  @override
  dynamic part2(String input) {
    final notes = parseNotes(input)..removeInvalidTickets();
    final numFields = notes.myTicket.length;

    // Determine which fields are valid for each rule
    final validFieldIndices = <String, Set<int>>{};
    for (int f = 0; f < numFields; f++) {
      final candidateNums = notes.nearbyTickets.map((ticket) => ticket[f]);
      for (var rule in notes.rules) {
        if (candidateNums.every((n) => rule.validNum(n))) {
          validFieldIndices[rule.name] =
              (validFieldIndices[rule.name] ?? <int>{})..add(f);
        }
      }
    }

    // Remove determined fields (where there is only one possible index) from
    // the other fields possibilities, until there is only one field for each
    // index
    var determinedFields = validFieldIndices.values
        .where((v) => v.length == 1)
        .map((e) => e.first)
        .toSet();
    while (determinedFields.length < numFields) {
      for (var indices in validFieldIndices.values) {
        if (indices.length != 1) {
          indices.removeAll(determinedFields);
        }
      }
      determinedFields = validFieldIndices.values
          .where((v) => v.length == 1)
          .map((e) => e.first)
          .toSet();
    }

    final departureIndices = validFieldIndices.entries
        .where((kv) => kv.key.startsWith('departure'))
        .map((kv) => kv.value.first);
    final departureValues = departureIndices.map((i) => notes.myTicket[i]);
    return departureValues.product;
  }

  TicketNotes parseNotes(String input) {
    final ruleRegex = RegExp(r'^(.+): (\d+)-(\d+) or (\d+)-(\d+)$');
    final textGroups = input.split('\n\n');
    assert(textGroups.length == 3);
    final rules = textGroups[0].split('\n').map((e) {
      final ruleMatch = ruleRegex.firstMatch(e);
      if (ruleMatch == null) {
        throw Exception('Unable to parse ticket rule: $e');
      }
      return TicketRule(
          ruleMatch.group(1)!,
          Range(int.parse(ruleMatch.group(2)!), int.parse(ruleMatch.group(3)!)),
          Range(
              int.parse(ruleMatch.group(4)!), int.parse(ruleMatch.group(5)!)));
    }).toList();

    final myTicket =
        textGroups[1].lines.skip(1).first.split(',').map(int.parse).toList();

    final nearbyTickets = textGroups[2]
        .lines
        .skip(1)
        .where((e) => e.isNotEmpty)
        .map((e) => e.split(',').map(int.parse).toList())
        .toList();

    return TicketNotes(rules, myTicket, nearbyTickets);
  }
}

class TicketNotes {
  TicketNotes(this.rules, this.myTicket, this.nearbyTickets);

  final List<TicketRule> rules;
  final List<int> myTicket;
  final List<List<int>> nearbyTickets;

  Set<int> validNumbers() {
    return rules.fold(
        <int>{},
        (Set<int> validNums, rule) => validNums
          ..addAll(rule.range1.values())
          ..addAll(rule.range2.values()));
  }

  void removeInvalidTickets() {
    // Remove any tickets with invalid numbers
    final validNums = validNumbers();
    nearbyTickets
        .removeWhere((ticket) => ticket.any((n) => !validNums.contains(n)));
  }
}

class TicketRule {
  TicketRule(this.name, this.range1, this.range2);

  final String name;
  final Range range1;
  final Range range2;

  bool validNum(int num) => range1.contains(num) || range2.contains(num);
}

class Range {
  Range(this.start, this.end);
  final int start;
  final int end;

  bool contains(int num) => start <= num && num <= end;

  Iterable<int> values() sync* {
    for (int i = start; i <= end; ++i) {
      yield i;
    }
  }
}
