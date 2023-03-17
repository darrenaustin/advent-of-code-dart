// https://adventofcode.com/2022/day/7

import 'package:aoc/aoc.dart';
import 'package:aoc/util/string.dart';
import 'package:collection/collection.dart';

main() => Day07().solve();

class Day07 extends AdventDay {
  Day07() : super(
    2022, 7, name: 'No Space Left On Device',
    solution1: 1118405, solution2: 12545514,
  );

  @override
  dynamic part1(String input) =>
    fileSystem(input)
      .allNodes()
      .where((n) => n.isDir)
      .map((n) => n.size)
      .where((n) => n <= 100000)
      .sum;

  @override
  dynamic part2(String input) {
    final FSEntry root = fileSystem(input);
    final int freeSpace = 70000000 - root.size;
    final int targetSpace = 30000000 - freeSpace;

    return root
      .allNodes()
      .where((n) => n.isDir && n.size >= targetSpace)
      .map((n) => n.size)
      .min;
  }

  FSEntry fileSystem(String input) {
    final FSEntry root = FSEntry.dir('/', null);
    FSEntry cwd = root;

    for (final line in input.lines) {
      if (line.startsWith('\$ cd')) {
        final dirName = line.substring(5);
        if (dirName == '..') {
          cwd = cwd.parent ?? cwd;
        } else {
          cwd = cwd.children?[dirName] ?? cwd;
        }
      } else if (line == '\$ ls') {
        continue;
      } else if (line.startsWith('dir')) {
        final dirName = line.substring(4);
        cwd.children![dirName] ??= FSEntry.dir(dirName, cwd);
      } else {
        // It must be a file
        final fileParts = line.split(' ');
        final size = int.parse(fileParts[0]);
        final name = fileParts[1];
        cwd.children![name] ??= FSEntry.file(name, cwd, size);
      }
    }
    return root;
  }
}

class FSEntry {
  final String name;
  int size;
  final FSEntry? parent;
  Map<String, FSEntry>? children;

  FSEntry.dir(this.name, this.parent) : size = 0, children = {};
  FSEntry.file(this.name, this.parent, this.size) {
    parent?._increaseSize(size);
  }

  bool get isDir => children != null;
  bool get isFile => !isDir;

  // List all nodes in depth first order.
  Iterable<FSEntry> allNodes() sync* {
    yield(this);
    if (children != null) {
      for (final child in children!.values) {
        for (final n in child.allNodes()) {
          yield n;
        }
      }
    }
  }

  void _increaseSize(int delta) {
    size += delta;
    parent?._increaseSize(delta);
  }

  void printTree([String indent = ""]) {
    print('$indent- ${toString()}');
    if (children != null) {
      for (final child in children!.values) {
        child.printTree('$indent  ');
      }
    }
  }

  @override
  String toString() {
    return '$name (${children != null ? 'dir' : 'file'}, size = $size)';
  }
}
