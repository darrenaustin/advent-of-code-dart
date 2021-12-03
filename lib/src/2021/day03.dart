// https://adventofcode.com/2021/day/3

import '../../day.dart';

class Day03 extends AdventDay {
  Day03() : super(2021, 3, solution1: 3309596, solution2: 2981085);

  @override
  dynamic part1() {
    final diagnostics = inputDataLines().map((l) => l.split(''));
    final gamma = <String>[];
    final epsilon = <String>[];

    for (int i = 0; i < diagnostics.first.length; i++) {
      final bits = diagnostics.map((e) => e[i]);
      if (bits.where((e) => e == '0').length >
          bits.where((e) => e == '1').length) {
        gamma.add('0');
        epsilon.add('1');
      } else {
        gamma.add('1');
        epsilon.add('0');
      }
    }
    return int.parse(gamma.join(), radix: 2) *
           int.parse(epsilon.join(), radix: 2);
  }

  @override
  dynamic part2() {
    final diagnostics = inputDataLines().map((l) => l.split(''));
    var oxygen = diagnostics;
    var co2 = diagnostics;

    for (int i = 0; i < diagnostics.first.length; i++) {
      if (oxygen.length > 1) {
        final bits = oxygen.map((e) => e[i]);
        final zeros = bits.where((e) => e == '0').length;
        final ones = bits.where((e) => e == '1').length;
        if (zeros <= ones) {
          oxygen = oxygen.where((e) => e[i] == '1');
        } else {
          oxygen = oxygen.where((e) => e[i] == '0');
        }
      }
      if (co2.length > 1) {
        final bits = co2.map((e) => e[i]);
        final zeros = bits.where((e) => e == '0').length;
        final ones = bits.where((e) => e == '1').length;
        if (zeros <= ones) {
          co2 = co2.where((e) => e[i] == '0');
        } else {
          co2 = co2.where((e) => e[i] == '1');
        }
      }
    }

    return int.parse(oxygen.first.join(), radix: 2) *
           int.parse(co2.first.join(), radix: 2);
  }
}
