import 'package:advent_of_code_dart/days2015.dart';
import 'package:advent_of_code_dart/days2016.dart';
import 'package:advent_of_code_dart/days2019.dart';
import 'package:advent_of_code_dart/days2020.dart';
import 'package:advent_of_code_dart/days2021.dart';
import 'package:advent_of_code_dart/days2022.dart';

import 'day.dart';

final allYearDays = <int, Map<int, AdventDay>> {
  2015: aoc2015Days,
  2016: aoc2016Days,
  2019: aoc2019Days,
  2020: aoc2020Days,
  2021: aoc2021Days,
  2022: aoc2022Days,
};

final List<AdventDay> allDays = <AdventDay>[
  ...aoc2015Days.values,
  ...aoc2016Days.values,
  ...aoc2019Days.values,
  ...aoc2020Days.values,
  ...aoc2021Days.values,
  ...aoc2022Days.values,
];
