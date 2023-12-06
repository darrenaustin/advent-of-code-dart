// ignore_for_file: public_member_api_docs, sort_constructors_first
// https://adventofcode.com/2023/day/5

import 'dart:math';

import 'package:aoc/aoc.dart';
import 'package:aoc/util/string.dart';
import 'package:collection/collection.dart';

main() => Day05().solve();

class Day05 extends AdventDay {
  Day05() : super(2023, 5, name: 'If You Give A Seed A Fertilizer');

  @override
  dynamic part1(String input) {
    final dataParts = input.split('\n\n');
    final seedNumbers =
        RegExp(r'\d+').allStringMatches(dataParts[0]).map(int.parse);
    final maps = dataParts.skip(1).map(RangeMapping.parse).toList();
    return seedNumbers.map((s) => applyAllMaps(s, maps)).min;
  }

  @override
  dynamic part2(String input) {
    final dataParts = input.split('\n\n');
    final seedData =
        RegExp(r'\d+').allStringMatches(dataParts[0]).map(int.parse).toList();
    final maps = dataParts.skip(1).map(RangeMapping.parse).toList();

    final seedRanges = <Range>[];
    for (int i = 0; i < seedData.length; i += 2) {
      seedRanges.add(
          Range(start: seedData[i], end: seedData[i + 1] + seedData[i] - 1));
    }
    final locRanges = applyAllMapsToRanges(seedRanges, maps);
    return locRanges.map((r) => r.start).min;
  }

  int applyAllMaps(int source, List<List<RangeMapping>> maps) =>
      maps.fold(source, mapValue);

  int mapValue(int source, List<RangeMapping> mappings) {
    for (final mapping in mappings) {
      if (mapping.source.start <= source && source <= mapping.source.end) {
        return source + mapping.delta;
      }
    }
    return source;
  }

  List<Range> applyAllMapsToRanges(
      List<Range> seeds, List<List<RangeMapping>> maps) {
    var values = seeds;
    for (final rangeGroup in maps) {
      final newValues = <Range>[];
      for (final value in values) {
        newValues.addAll(mapRange(value, rangeGroup));
      }
      values = newValues;
    }
    return values;
  }

  List<Range> mapRange(Range source, List<RangeMapping> mappings) {
    var sources = [source];
    final translatedRanges = <Range>[];
    for (final mapping in mappings) {
      if (sources.isNotEmpty) {
        final newSources = <Range>[];
        final mappingSource = mapping.source;
        for (final source in sources) {
          final (inside, outside) = mappingSource.intersect(source);
          if (inside != null) {
            translatedRanges.add(Range(
                start: inside.start + mapping.delta,
                end: inside.end + mapping.delta));
          }
          newSources.addAll(outside);
        }
        sources = newSources;
      }
    }
    translatedRanges.addAll(sources);
    return translatedRanges;
  }
}

class Range {
  Range({required this.start, required this.end});

  final int start;
  final int end;

  (Range? inside, List<Range> outside) intersect(Range r) {
    if (r.end < start || end < r.start) {
      // r is completely outside this range.
      return (null, [r]);
    }
    if (start <= r.start && r.end <= end) {
      // r is completely in this range
      return (r, []);
    }

    final inside = Range(start: max(start, r.start), end: min(end, r.end));
    final outside = <Range>[
      if (r.start < start) Range(start: r.start, end: start - 1),
      if (end < r.end) Range(start: end + 1, end: r.end),
    ];
    return (inside, outside);
  }

  @override
  bool operator ==(covariant Range other) {
    if (identical(this, other)) return true;

    return other.start == start && other.end == end;
  }

  @override
  int get hashCode => start.hashCode ^ end.hashCode;

  @override
  String toString() => 'Range(start: $start, end: $end)';
}

class RangeMapping {
  RangeMapping({required this.source, required this.destination});

  final Range source;
  final Range destination;
  int get delta => destination.start - source.start;

  static List<RangeMapping> parse(String input) {
    return input.lines
        .skip(1)
        .map((e) => RegExp(r'\d+').allStringMatches(e).map(int.parse).toList())
        .map(
          (ns) => RangeMapping(
              source: Range(start: ns[1], end: ns[1] + ns[2] - 1),
              destination: Range(start: ns[0], end: ns[0] + ns[2] - 1)),
        )
        .toList();
  }
}
