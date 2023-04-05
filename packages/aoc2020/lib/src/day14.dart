// https://adventofcode.com/2020/day/14

import 'dart:math';

import 'package:aoc/aoc.dart';
import 'package:aoc/util/string.dart';
import 'package:collection/collection.dart';

main() => Day14().solve();

class Day14 extends AdventDay {
  Day14() : super(
    2020, 14, name: 'Docking Data',
    solution1: 18630548206046, solution2: 4254673508445,
  );

  @override
  dynamic part1(String input) =>
    executeBitmask(parseInstructions(input)).values.sum;

  @override
  dynamic part2(String input) =>
    executeAddressDecode(parseInstructions(input)).values.sum;

  Iterable<Instruction> parseInstructions(String input) {
    final maskRegExp = RegExp(r'^mask\s*=\s*([X01]{36})$');
    final memRegExp = RegExp(r'mem\[(\d+)\]\s*=\s*(\d+)');
    return input.lines.map((e) {
      final maskLine = maskRegExp.firstMatch(e);
      if (maskLine != null) {
        return Instruction(mask: maskLine.group(1)!);
      }
      final memLine = memRegExp.firstMatch(e);
      if (memLine != null) {
        return Instruction(
          address: int.parse(memLine.group(1)!),
          value: int.parse(memLine.group(2)!)
        );
      }
      throw Exception('Unknown instruction: $e');
    });
  }

  Map<int, int> executeBitmask(Iterable<Instruction> instructions) {
    final memory = <int, int>{};
    var mask = DualBitMask();
    for (final instruction in instructions) {
      if (instruction.mask != null) {
        mask = DualBitMask(instruction.mask!);
      } else {
        memory[instruction.address!] = mask.apply(instruction.value!);
      }
    }
    return memory;
  }

  Map<int, int> executeAddressDecode(Iterable<Instruction> instructions) {
    final memory = <int, int>{};
    var mask = AddressMask();
    for (final instruction in instructions) {
      if (instruction.mask != null) {
        mask = AddressMask(instruction.mask!);
      } else {
        for (final address in mask.apply(instruction.address!)) {
          memory[address] = instruction.value!;
        }
      }
    }
    return memory;
  }
}

List<String> bits(int num, [int? maxBits]) {
  var bits = num.toRadixString(2);
  if (maxBits != null) {
    bits = bits.padLeft(maxBits, '0');
  }
  return bits.chars.toList();
}

class Instruction {
  Instruction({this.mask, this.address, this.value})
    : assert(mask != null || (address != null && value != null));

  final String? mask;
  final int? address;
  final int? value;
}

class DualBitMask {
  DualBitMask([String maskText = 'X']) :
    setMask = int.parse(maskText.replaceAll('X', '0'), radix: 2),
    clearMask = int.parse(maskText.chars.map((e) => e == '0' ? '1' : '0').join(), radix: 2);

  final int setMask;
  final int clearMask;

  int apply(int value) => (value | setMask) & ~clearMask;
}

class AddressMask {
  AddressMask([String? mask]) :
    setMask = (mask != null) ? int.parse(mask.replaceAll('X', '0'), radix: 2) : 0,
    floatingIndex = (mask != null) ? mask.chars.asMap().entries.where((e) => e.value == 'X').map((kv) => kv.key).toList() : [];

  final int setMask;
  final List<int> floatingIndex;

  Iterable<int> apply(int address) {
    final decodedAddresses = <int>[];
    final addressBits = bits(address | setMask, 36);
    final maxFloating = pow(2, floatingIndex.length);
    for (int floating = 0; floating < maxFloating; floating++) {
      final floatingBits = bits(floating, floatingIndex.length);
      for (var i = 0; i < floatingIndex.length; i++) {
        addressBits[floatingIndex[i]] = floatingBits[i];
      }
      decodedAddresses.add(int.parse(addressBits.join(), radix: 2));
    }
    return decodedAddresses;
  }
}
