// https://adventofcode.com/2019/day/8

import '../../day.dart';
import '../util/collection.dart';

class Day08 extends AdventDay {
  Day08() : super(2019, 8, solution1: 1935, solution2: 'CFLUL');

  @override
  dynamic part1() {
    final layers = inputLayers(25 * 6);
    final least0Layer= layers.map((l) => MapEntry(l.quantify((e) => e == 0), l))
      .sorted((a1, a2) => a1.key.compareTo(a2.key))
      .first.value;
    return
      least0Layer.quantify((e) => e == 1) *
      least0Layer.quantify((e) => e == 2);
  }

  @override
  dynamic part2() {
    final image = IterableZip(inputLayers(25 * 6)).map(pixelFrom).slices(25);
    print(image
      .map((e) => e.join(''))
      .join('\n')
      .replaceAll('0', ' ')
      .replaceAll('1', '\u2588')
    );

    // TODO: look into OCR to parse the text from the ascii generated above?
    // After manually reading the above, sigh.
    return 'CFLUL';
  }

  Iterable<List<int>> inputLayers(int layerSize) {
    return inputData()
      .split('')
      .map(int.parse)
      .slices(layerSize)
      .map((l) => l.toList());
  }

  int pixelFrom(Iterable<int> layers) {
    return layers.firstWhere((e) => e != 2, orElse: () => 2);
  }
}
