// https://adventofcode.com/2015/day/20

import 'dart:math';

import 'package:aoc/aoc.dart';
import 'package:collection/collection.dart';

class Day20 extends AdventDay {
  Day20() : super(2015, 20, solution1: 665280, solution2: 705600);

  @override
  dynamic part1() {
    int numPresents(int houseNum) {
      return divisors(houseNum).map((int e) => e * 10).sum;
    }

    final int targetPresents = int.parse(inputData());
    int house = 1;
    while (numPresents(house) <= targetPresents) {
      house++;
    }
    return house;
  }

  @override
  dynamic part2() {
    int numPresents(int houseNum) {
      return divisors(houseNum)
        .where((int e) => houseNum ~/ e <= 50)
        .map((int e) => e * 11)
        .sum;
    }

    final int targetPresents = int.parse(inputData());
    int house = 1;
    while (numPresents(house) <= targetPresents) {
      house++;
    }
    return house;
  }

  Iterable<int> divisors(int n) sync* {
    if (n == 1) {
      yield 1;
      return;
    }
    final double rootN = sqrt(n);
    for (int d = 1; d <= rootN; d++) {
      if (rootN == d) {
        yield d;
      } else if (n % d == 0) {
        yield d;
        yield n ~/ d;
      }
    }
  }
}
