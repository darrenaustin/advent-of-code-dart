// https://adventofcode.com/2019/day/8

import 'package:aoc/aoc.dart';
import 'package:aoc/util/collection.dart';
import 'package:aoc/util/string.dart';
import 'package:collection/collection.dart';

main() => Day08().solve();

class Day08 extends AdventDay {
  Day08() : super(2019, 8, name: 'Space Image Format');

  @override
  dynamic part1(String input) {
    final layers = parseLayers(input, 25 * 6);
    final least0Layer = layers
        .map((l) => MapEntry(l.quantify((e) => e == 0), l))
        .sorted((a1, a2) => a1.key.compareTo(a2.key))
        .first
        .value;
    return least0Layer.quantify((e) => e == 1) *
        least0Layer.quantify((e) => e == 2);
  }

  @override
  dynamic part2(String input) {
    final image =
        IterableZip(parseLayers(input, 25 * 6)).map(pixelFrom).slices(25);
    print('\n');
    print(image
        .map((e) => e.join(' '))
        .join('\n')
        .replaceAll('0', ' ')
        .replaceAll('1', '#'));
    print('\n');

    // Look into OCR to parse the text from the ascii generated above?
    // Answer after manually reading the above, sigh.
    return 'CFLUL';
  }

  Iterable<List<int>> parseLayers(String input, int layerSize) {
    return input.chars.map(int.parse).slices(layerSize);
  }

  int pixelFrom(Iterable<int> layers) {
    return layers.firstWhere((e) => e != 2, orElse: () => 2);
  }
}
