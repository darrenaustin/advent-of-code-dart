// https://adventofcode.com/2022/day/11

import 'package:aoc/aoc.dart';
import 'package:aoc/util/collection.dart';
import 'package:aoc/util/math.dart';
import 'package:collection/collection.dart';

class Day11 extends AdventDay {
  Day11() : super(2022, 11, solution1: 78960, solution2: 14561971968);

  @override
  dynamic part1() {
    final monkeys = inputMonkeys();
    for (int r = 0; r < 20; r++) {
      round(monkeys);
    }
    return monkeyBusiness(monkeys);
  }

  @override
  dynamic part2() {
    final monkeys = inputMonkeys();
    final easeMod = monkeys.map((m) => m.testMod).reduce(lcm);
    for (int r = 0; r < 10000; r++) {
      round(monkeys, easeMod);
    }
    return monkeyBusiness(monkeys);
  }

  void round(List<Monkey> monkeys, [int? easeMod]) {
    for (final monkey in monkeys) {
      monkey.inspectItems((item, monkey) {
        monkeys[monkey].items.add(item);
      }, easeMod);
    }
  }

  int monkeyBusiness(List<Monkey> monkeys) =>
    monkeys
      .map((m) => m.numInspected)
      .sorted((a, b) => b - a)
      .take(2)
      .product;

  List<Monkey> inputMonkeys() {
    List<Monkey> monkeys = [];
    final monkeyData = input().split('Monkey ').skip(1).map((s) => s.split('\n'));
    for (final data in monkeyData) {
      monkeys.add(Monkey(
        id: int.parse(data[0].split(':')[0]),
        items: data[1].split(': ')[1].split(',').map(int.parse).toList(),
        operation: parseOperation(data[2].split(': ')[1]),
        testMod: int.parse(data[3].split(' ').last),
        trueMonkey: int.parse(data[4].split(' ').last),
        falseMonkey: int.parse(data[5].split(' ').last),
      ));
    }
    return monkeys;
  }

  int Function(int) parseOperation(String operationStr) {
    final parts = operationStr.split('= ')[1].split(' ');
    final op = parts[1];
    final int? opNum = int.tryParse(parts[2]);

    switch (op) {
      case '+':
        if (opNum != null) {
          return (x) => x + opNum;
        } else {
          return (x) => x + x;
        }
      case '*':
        if (opNum != null) {
          return (x) => x * opNum;
        } else {
          return (x) => x * x;
        }
    }
    throw('Unknown operation: $operationStr');
  }
}

class Monkey {
  Monkey({required this.id, required this.items, required this.operation, required this.testMod, required this.trueMonkey, required this.falseMonkey});

  final int id;
  final List<int> items;
  final int Function(int) operation;
  final int testMod;
  final int trueMonkey;
  final int falseMonkey;

  int numInspected = 0;

  void inspectItems(void Function(int item, int monkey) throwItem, int? easeMod) {
    while (items.isNotEmpty) {
      int item = operation(items.removeAt(0));
      if (easeMod != null) {
        item %= easeMod;
      } else {
        item = item ~/ 3;
      }
      numInspected += 1;
      throwItem(item, item % testMod == 0 ? trueMonkey : falseMonkey);
    }
  }
}
