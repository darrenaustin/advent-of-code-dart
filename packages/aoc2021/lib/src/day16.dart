// https://adventofcode.com/2021/day/16

import 'dart:math';

import 'package:aoc/aoc.dart';

main() => Day16().solve();

class Day16 extends AdventDay {
  Day16() : super(
    2021, 16, name: 'Packet Decoder',
    solution1: 984, solution2: 1015320896946,
  );

  @override
  dynamic part1(String input) {
    int packetVersionSum(Packet packet) {
      int sum = packet.version;
      for (final child in packet.children ?? []) {
        sum += packetVersionSum(child);
      }
      return sum;
    }

    return packetVersionSum(Packet.parse(BitStream(input)));
  }

  @override
  dynamic part2(String input) {
    return Packet.parse(BitStream(input)).eval();
  }
}

class Packet {
  Packet({
    required this.version,
    required this.type,
    this.value,
    this.children,
  });

  factory Packet.parse(BitStream bits) {
    final version = bits.next(3);
    final type = bits.next(3);
    int? value;
    List<Packet>? children;
    switch (type) {
      case 4:
        // Literal number.
        value = _parseLiteralNumber(bits);
        break;
      default:
        // Operator with sub-packets.
        final lengthType = bits.next();
        switch (lengthType) {
          case 0:
            // Total length of children.
            final childrenLength = bits.next(15);
            final startingStreamLength = bits.length;
            children = [];
            while (startingStreamLength - bits.length < childrenLength) {
              children.add(Packet.parse(bits));
            }
            break;
          case 1:
            // Total number of children.
            final numChildren = bits.next(11);
            children = [];
            for (int i = 0; i < numChildren; i++){
              children.add(Packet.parse(bits));
            }
            break;
        }
        break;
    }

    return Packet(version: version, type: type, value: value, children: children);
  }

  final int version;
  final int type;
  final int? value;
  final List<Packet>? children;

  int eval() {
    switch (type) {
      case 0:
        {
          // Sum
          int sum = 0;
          for (final child in children ?? <Packet>[]) {
            sum += child.eval();
          }
          return sum;
        }

      case 1:
        // Product
        {
          int product = 1;
          for (final child in children ?? <Packet>[]) {
            product *= child.eval();
          }
          return product;
        }

      case 2:
        // Minimum
        {
          int? value;
          for (final child in children ?? <Packet>[]) {
            final childValue = child.eval();
            value = (value == null) ? childValue : min(value, childValue);
          }
          return value!;
        }

      case 3:
        // Maximum
        {
          int? value;
          for (final child in children ?? <Packet>[]) {
            final childValue = child.eval();
            value = (value == null) ? childValue : max(value, childValue);
          }
          return value!;
        }

      case 4:
        // Literal
        return value!;

      case 5:
        // Greater than
        return children![0].eval() > children![1].eval() ? 1 : 0;

      case 6:
        // Less than
        return children![0].eval() < children![1].eval() ? 1 : 0;

      case 7:
        // Equal
        return children![0].eval() == children![1].eval() ? 1 : 0;
    }
    throw Exception('Unknown packet type');
  }

  static int _parseLiteralNumber(BitStream bits) {
    int number = 0;
    while (bits.next() == 1) {
      number = number << 4 | bits.next(4);
    }
    number = number << 4 | bits.next(4);
    return number;
  }
}

class BitStream {

  BitStream(String hexDigits) : _bits = [] {
    for (final d in hexDigits.split('')) {
      int value = int.parse(d, radix: 16);
      _bits.addAll(value
        .toRadixString(2)
        .padLeft(4, '0')
        .split('')
        .map((b) => b == '1' ? 1 : 0)
      );
    }
  }

  final List<int> _bits;

  bool get isEmpty => _bits.isEmpty;
  bool get isNotEmpty => _bits.isNotEmpty;
  int get length => _bits.length;

  int next([int numBits = 1]) {
    int result = 0;
    while (numBits > 0) {
      result = result << 1 | _bits.removeAt(0);
      numBits--;
    }
    return result;
  }
}
