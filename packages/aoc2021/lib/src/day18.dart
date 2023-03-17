// https://adventofcode.com/2021/day/18

import 'dart:math';

import 'package:aoc/aoc.dart';
import 'package:aoc/util/string.dart';

main() => Day18().solve();

class Day18 extends AdventDay {
  Day18() : super(
    2021, 18, name: 'Snailfish',
    solution1: 4641, solution2: 4624,
  );

  @override
  dynamic part1(String input) => input
    .lines
    .map(Pair.from)
    .reduce((sum, pair) => sum + pair)
    .magnitude();

  @override
  dynamic part2(String input) {
    final pairs = input.lines.map(Pair.from).toList();
    int maxMagnitude = 0;
    for (int a = 0; a < pairs.length - 1; a++) {
      for (int b = a + 1; b < pairs.length; b++) {
        maxMagnitude = max(maxMagnitude, (pairs[a] + pairs[b]).magnitude());
        maxMagnitude = max(maxMagnitude, (pairs[b] + pairs[a]).magnitude());
      }
    }
    return maxMagnitude;
  }
}

class Pair {
  Pair(dynamic left, dynamic right)
    : assert(left is int || left is Pair),
      assert(right is int || right is Pair),
      _left = left,
      _right = right;

  dynamic get left => _left;
  int? get leftNumber => _left is int ? _left as int : null;
  Pair? get leftPair => _left is Pair ? _left as Pair : null;
  set left(dynamic value) {
    assert(value is int || value is Pair);
    _left = value;
  }
  dynamic _left;

  dynamic get right => _right;
  int? get rightNumber => _right is int ? _right as int : null;
  Pair? get rightPair => _right is Pair ? _right as Pair : null;
  set right(dynamic value) {
    assert(value is int || value is Pair);
    _right = value;
  }
  dynamic _right;

  factory Pair.copy(Pair other) {
    final left = other.leftNumber ?? Pair.copy(other.leftPair!);
    final right = other.rightNumber ?? Pair.copy(other.rightPair!);
    return Pair(left, right);
  }

  factory Pair.from(String string) {
    Pair parsePair(List<String> chars) {
      int readNum(String separator) {
        final digits = <String>[];
        while (chars.first != separator) {
          digits.add(chars.removeAt(0));
        }
        return int.parse(digits.join());
      }

      if (chars.removeAt(0) != '[') {
        throw Exception('Expected a [ character');
      }
      dynamic left;
      dynamic right;
      if (chars.first == '[') {
        left = parsePair(chars);
      } else {
        left = readNum(',');
      }
      if (chars.removeAt(0) != ',') {
        throw Exception('Expected a , character');
      }
      if (chars.first == '[') {
        right = parsePair(chars);
      } else {
        right = readNum(']');
      }
      if (chars.removeAt(0) != ']') {
        throw Exception('Expected a ] character');
      }
      return Pair(left, right);
    }
    return parsePair(string.split(''));
  }

  factory Pair.split(int value) => Pair((value  / 2).floor(), (value / 2).ceil());

  void reduce() {
    while (_explodeIfNeeded(this) || _splitIfNeeded(this)) {}
  }

  bool _explodeIfNeeded(Pair p) {

    void addToLeftMost(int value, Pair p) {
      while (p.left is Pair) {
        p = p.leftPair!;
      }
      p.left = p.leftNumber! + value;
    }

    void addToRightMost(int value, Pair p) {
      while (p.right is Pair) {
        p = p.rightPair!;
      }
      p.right = p.rightNumber! + value;
    }

    void explodeLeft(Pair p, Iterator<Pair> parents) {
      final value = p.leftNumber!;
      while (parents.moveNext()) {
        if (parents.current.left == p) {
          p = parents.current;
        } else {
          if (parents.current.leftNumber != null) {
            parents.current.left = parents.current.leftNumber! + value;
          } else {
            addToRightMost(value, parents.current.left);
          }
          return;
        }
      }
    }

    void explodeRight(Pair p, Iterator<Pair> parents) {
      final value = p.rightNumber!;
      while (parents.moveNext()) {
        if (parents.current.right == p) {
          p = parents.current;
        } else {
          if (parents.current.rightNumber != null) {
            parents.current.right = parents.current.rightNumber! + value;
          } else {
            addToLeftMost(value, parents.current.right);
          }
          return;
        }
      }
    }

    bool explode(Pair p, List<Pair> parents) {
      if (parents.length >= 4) {
        assert(p.left is int && p.right is int);
        explodeLeft(p, parents.iterator);
        explodeRight(p, parents.iterator);
        final parent = parents.first;
        if (parent.left == p) {
          parent.left = 0;
        } else {
          parent.right = 0;
        }
        return true;
      } else {
        if ((p.leftPair != null && explode(p.leftPair!, [p, ...parents])) ||
            (p.rightPair != null && explode(p.rightPair!, [p, ...parents]))) {
          return true;
        }
      }
      return false;
    }
    return explode(p, []);
  }

  bool _splitIfNeeded(Pair p) {
    if (p.left is int) {
      if (p.leftNumber! >= 10) {
        p.left = Pair.split(p.leftNumber!);
        return true;
      }
    } else {
      if (_splitIfNeeded(p.leftPair!)) {
        return true;
      }
    }
    if (p.right is int) {
      if (p.rightNumber! >= 10) {
        p.right = Pair.split(p.rightNumber!);
        return true;
      }
    } else {
      if (_splitIfNeeded(p.rightPair!)) {
        return true;
      }
    }
    return false;
  }

  int magnitude() {
    return
      3 * (leftNumber ?? leftPair!.magnitude()) +
      2 * (rightNumber ?? rightPair!.magnitude());
  }

  Pair operator+ (Pair other) {
    return Pair(Pair.copy(this), Pair.copy(other))..reduce();
  }

  @override
  String toString() {
    return '[${leftNumber ?? leftPair!.toString()},${rightNumber ?? rightPair!.toString()}]';
  }
}
