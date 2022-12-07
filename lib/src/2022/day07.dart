// https://adventofcode.com/2022/day/7

import 'package:collection/collection.dart';

import '../../day.dart';

class Day07 extends AdventDay {
  Day07() : super(2022, 7, solution1: 1118405, solution2: 12545514);

  @override
  dynamic part1() {
    return fileSystem()
      .allNodes()
      .where((n) => n.isDir)
      .map((n) => n.size)
      .where((n) => n <= 100000)
      .sum;
  }

  @override
  dynamic part2() {
    final FSEntry root = fileSystem();
    final int freeSpace = 70000000 - root.size;
    final int targetSpace = 30000000 - freeSpace;

    return root
      .allNodes()
      .where((n) => n.isDir && n.size >= targetSpace)
      .map((n) => n.size)
      .min;
  }

  FSEntry fileSystem() {
    final commandDelimiter = RegExp(r'\n?\$ ');
    final cdCommandRegExp = RegExp(r'cd (.*)');
    final fileRegExp = RegExp(r'(\d+) (.*)');

    final FSEntry root = FSEntry.dir('/', null);
    FSEntry cwd = root;

    final commandGroups = inputData().split(commandDelimiter).skip(1).map((s) => s.split('\n'));
    for (final commandGroup in commandGroups) {
      final command = commandGroup.first;
      final cdMatch = cdCommandRegExp.firstMatch(command);
      if (cdMatch != null) {
        String dir = cdMatch.group(1)!;
        while (dir.startsWith('..')) {
          cwd = cwd.parent!;
          dir = dir.substring(2);
        }
        if (dir.isNotEmpty) {
          cwd = cwd.children?[dir] ?? cwd;
        }
      } else if (command == 'ls') {
        for (final entry in commandGroup.skip(1)) {
          if (entry.startsWith('dir')) {
            final dirName = entry.substring(4);
            cwd.children![dirName] ??= FSEntry.dir(dirName, cwd);
          } else {
            final fileData = fileRegExp.firstMatch(entry)!;
            final fileSize = int.parse(fileData.group(1)!);
            final fileName = fileData.group(2)!;
            cwd.children![fileName] ??= FSEntry.file(fileName, cwd, fileSize);
          }
        }
      } else {
        throw('Unknown command: $command');
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
