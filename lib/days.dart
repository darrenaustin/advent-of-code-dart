
import 'package:aoc/aoc.dart';
import 'package:aoc2015/aoc2015.dart';

final allYearDays = <int, Map<int, AdventDay>> {
  2015: aoc2015Days,
};

final List<AdventDay> allDays = <AdventDay>[
  ...aoc2015Days.values,
];
