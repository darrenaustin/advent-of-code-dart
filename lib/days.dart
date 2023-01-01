import 'package:aoc/aoc.dart';
import 'package:aoc2015/aoc2015.dart';
import 'package:aoc2016/aoc2016.dart';
import 'package:aoc2017/aoc2017.dart';
import 'package:aoc2018/aoc2018.dart';
import 'package:aoc2019/aoc2019.dart';
import 'package:aoc2020/aoc2020.dart';
import 'package:aoc2021/aoc2021.dart';
import 'package:aoc2022/aoc2022.dart';

final allYearDays = <int, Map<int, AdventDay>> {
  2015: aoc2015Days,
  2016: aoc2016Days,
  2017: aoc2017Days,
  2018: aoc2018Days,
  2019: aoc2019Days,
  2020: aoc2020Days,
  2021: aoc2021Days,
  2022: aoc2022Days,
};

final List<AdventDay> allDays = <AdventDay>[
  ...aoc2015Days.values,
  ...aoc2016Days.values,
  ...aoc2017Days.values,
  ...aoc2018Days.values,
  ...aoc2019Days.values,
  ...aoc2020Days.values,
  ...aoc2021Days.values,
  ...aoc2022Days.values,
];
