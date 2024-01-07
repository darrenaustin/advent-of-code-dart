// https://adventofcode.com/2020/day/4

import 'package:aoc/aoc.dart';

main() => Day04().solve();

typedef FieldValidator = bool Function(String);

class Day04 extends AdventDay {
  Day04() : super(2020, 4, name: 'Passport Processing');

  @override
  dynamic part1(String input) =>
      parsePasswords(input).where(hasRequiredFields).length;

  @override
  dynamic part2(String input) =>
      parsePasswords(input).where(hasValidRequiredFields).length;

  static List<Map<String, String>> parsePasswords(String input) {
    final keyValueRegexp = RegExp(r'(\S+):(\S+)');
    final entries = input.split('\n\n');
    return entries.map((entry) {
      final keyValues = keyValueRegexp.allMatches(entry);
      return Map.fromEntries(
          keyValues.map((kv) => MapEntry(kv.group(1)!, kv.group(2)!)));
    }).toList();
  }

  static bool hasRequiredFields(Map<String, String> entry) {
    final requiredFields = ['byr', 'iyr', 'eyr', 'hgt', 'hcl', 'ecl', 'pid'];
    return requiredFields.every((field) => entry.containsKey(field));
  }

  static bool hasValidRequiredFields(Map<String, String> entry) {
    FieldValidator validYear(int startYear, int endYear) => (value) {
          final year = int.tryParse(value);
          return year != null && startYear <= year && year <= endYear;
        };

    final requiredFields = <String, FieldValidator>{
      'byr': validYear(1920, 2002),
      'iyr': validYear(2010, 2020),
      'eyr': validYear(2020, 2030),
      'hgt': (value) {
        final heightRegexp = RegExp(r'^(\d+)(cm|in)$');
        final match = heightRegexp.firstMatch(value);
        if (match != null) {
          final height = int.tryParse(match.group(1)!);
          if (height != null) {
            if (match.group(2)! == 'cm') {
              return 150 <= height && height <= 193;
            } else {
              return 59 <= height && height <= 76;
            }
          }
        }
        return false;
      },
      'hcl': (value) => RegExp(r'^#[0-9a-f]{6}$').hasMatch(value),
      'ecl': (value) =>
          RegExp(r'^(amb|blu|brn|gry|grn|hzl|oth)$').hasMatch(value),
      'pid': (value) => RegExp(r'^\d{9}$').hasMatch(value),
    };

    return requiredFields.entries.every((keyValue) =>
        entry.containsKey(keyValue.key) &&
        keyValue.value(entry[keyValue.key]!));
  }
}
