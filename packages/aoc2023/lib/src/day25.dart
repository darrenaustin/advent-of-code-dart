// https://adventofcode.com/2023/day/25

import 'package:aoc/aoc.dart';
import 'package:aoc/util/string.dart';
import 'package:collection/collection.dart';

main() => Day25().solve();

class Day25 extends AdventDay {
  Day25() : super(2023, 25, name: 'Snowverload');

  @override
  dynamic part1(String input) {
    final graph = parseGraph(input);

    // I solved this with manually inspecting a GraphViz translation of
    // the graph and then manually making the cuts needed (see commented out
    // solvePart1WithGraphViz below).
    //
    // After looking into several min-cut algorithms, I saw this fascinating
    // solution on reddit and decided to implement it below.
    //
    // From: https://www.reddit.com/r/adventofcode/comments/18qbsxs/comment/kevcrwo/?utm_source=share&utm_medium=web2x&context=3
    //
    // Even this unoptimized solution runs fairly quickly on my aging
    // laptop (~75ms). Thanks Max!

    final unconnected = Map.fromEntries(graph.keys.map((k) => MapEntry(k, 0)));
    while (unconnected.values.sum != 3) {
      final maxUnconnected = unconnected.entries
          .reduce((maxVert, e) => e.value > maxVert.value ? e : maxVert);
      final v = maxUnconnected.key;
      unconnected.remove(v);
      for (final adj in graph[v]!.where((a) => unconnected.containsKey(a))) {
        unconnected[adj] = unconnected[adj]! + 1;
      }
    }
    return unconnected.length * (graph.keys.length - unconnected.length);
  }

  Map<String, Set<String>> parseGraph(String input) {
    final graph = <String, Set<String>>{};
    for (final l in input.lines) {
      final [name, values] = l.split(': ');
      final connected = values.split(' ');
      graph[name] = (graph[name] ?? <String>{})..addAll(connected);
      for (final c in connected) {
        graph[c] = (graph[c] ?? <String>{})..add(name);
      }
    }
    return graph;
  }

  // // Helper function to write a GraphViz dot file for a graph.
  // void writeGraphVizFile(
  //     String fileName, Map<String, Set<String>> graph) async {
  //   final buffer = StringBuffer();
  //   buffer.writeln('strict graph {');
  //   for (final entry in graph.entries) {
  //     buffer.write('  ${entry.key} -- {');
  //     buffer.write(entry.value.join(' '));
  //     buffer.writeln('}');
  //   }
  //   buffer.writeln('}');

  //   File(fileName).writeAsStringSync(buffer.toString());

  //   // Command to turn the dot file into a PDF:
  //   // dot aoc25.dot -Kneato -Tpdf -o aoc25.pdf
  // }

  // int solvePart1WithGraphViz(String input) {
  //   final graph = <String, Set<String>>{};
  //   final edges = <(String, String)>{};
  //   for (final l in input.lines) {
  //     final [name, values] = l.split(': ');
  //     final connected = values.split(' ');
  //     graph[name] = (graph[name] ?? <String>{})..addAll(connected);
  //     for (final c in connected) {
  //       if (!edges.contains((name, c)) && !edges.contains((c, name))) {
  //         edges.add((name, c));
  //       }
  //     }
  //   }
  //   writeGraphVizFile('aoc25.dot', graph);

  //   // Manually inspecting the generated PDF yeilds splits at:
  //   //
  //   // ncg - gsk
  //   // mrd - rjs
  //   // gmr - ntx
  //   //
  //   // will break it in two groups.
  //   final cuts = [('ncg', 'gsk'), ('mrd', 'rjs'), ('gmr', 'ntx')];
  //   for (final (n1, n2) in cuts) {
  //     if (!edges.remove((n1, n2))) {
  //       edges.remove((n2, n1));
  //     }
  //   }

  //   // Construct a new graph from the edges
  //   graph.clear();
  //   for (final (n1, n2) in edges) {
  //     graph[n1] = (graph[n1] ?? <String>{})..add(n2);
  //     graph[n2] = (graph[n2] ?? <String>{})..add(n1);
  //   }
  //   writeGraphVizFile('aoc25-cut.dot', graph);

  //   // Compute the connected set from the cut edges.
  //   var connectedSets = <Set<String>>[];
  //   for (final (n1, n2) in edges) {
  //     final needToMerge =
  //         connectedSets.where((s) => s.contains(n1) || s.contains(n2)).toList();
  //     if (needToMerge.isEmpty) {
  //       // Just add a new set for this edge
  //       connectedSets.add({n1, n2});
  //     } else {
  //       final merged = <String>{n1, n2};
  //       for (final s in needToMerge) {
  //         merged.addAll(s);
  //         connectedSets.remove(s);
  //       }
  //       connectedSets.add(merged);
  //     }
  //   }
  //   assert(connectedSets.length == 2);
  //   return connectedSets.map((s) => s.length).product;
  // }

  @override
  dynamic part2(String input) => AdventDay.lastStarSolution;
}
