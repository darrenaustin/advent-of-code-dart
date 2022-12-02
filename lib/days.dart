import 'package:advent_of_code_dart/days2015.dart';
import 'package:advent_of_code_dart/days2016.dart';
import 'package:advent_of_code_dart/days2021.dart';
import 'package:advent_of_code_dart/days2022.dart';

import 'day.dart';

final Map<int, List<AdventDay>> yearDays = <int, List<AdventDay>> {
  2015: adventOfCode2015Days,
  2016: adventOfCode2016Days,
  2021: adventOfCode2021Days,
  2022: adventOfCode2022Days,
};

final List<AdventDay> allAdventOfCodeDays = <AdventDay>[
  ...adventOfCode2015Days,
  ...adventOfCode2016Days,
  ...adventOfCode2021Days,
  ...adventOfCode2022Days,
];
