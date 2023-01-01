// https://adventofcode.com/2022/day/10

import 'package:aoc/aoc.dart';

main() => Day10().solve();

class Day10 extends AdventDay {
  Day10() : super(
    2022, 10, name: '',
  );

  @override
  dynamic part1(String input) => 'Need to migrate';

  @override
  dynamic part2(String input) => 'Need to migrate';
}

// https://adventofcode.com/2022/day/10
// 
// import 'package:aoc/aoc.dart';
// 
// class Day10 extends AdventDay {
//   Day10() : super(2022, 10, solution1: 14620, solution2: 'BJFRHRFU');
// 
//   @override
//   dynamic part1() {
//     int signalSum = 0;
//     final sampleCycles = {20, 60, 100, 140, 180, 220};
// 
//     void onTick(int cycle, int x) {
//       if (sampleCycles.contains(cycle)) {
//         signalSum += cycle * x;
//       }
//     }
// 
//     CPU(onTick).executeInstructions(inputDataLines());
//     return signalSum;
//   }
// 
//   @override
//   dynamic part2() {
//     final crt = CRT();
//     CPU((int _, int x) => crt.tick(x)).executeInstructions(inputDataLines());
// 
//     // Don't have an OCR for this, so report from manual inspection of output.
//     print(crt);
//     return 'BJFRHRFU';
//   }
// }
// 
// class CPU {
//   CPU(this.onTick);
// 
//   final void Function(int cycle, int x) onTick;
// 
//   int cycle = 0;
//   int x = 1;
// 
//   void nextCycle() {
//     cycle += 1;
//     onTick(cycle, x);
//   }
// 
//   void executeInstructions(List<String> instructions) {
//     for (final op in instructions) {
//       if (op == "noop") {
//         nextCycle();
//       } else {
//         int value = int.parse(op.split(' ')[1]);
//         nextCycle();
//         nextCycle();
//         x += value;
//       }
//     }
//   }
// }
// 
// class CRT {
// 
//   CRT([this.width = 40]);
// 
//   final int width;
// 
//   final StringBuffer _lines = StringBuffer();
//   int _pixel = 0;
// 
//   void tick(int spriteX) {
//     final paintPixel = (_pixel - spriteX).abs() < 2;
//     final pixelChar = paintPixel ? '\u2588' : ' ';
//     _lines.write(pixelChar);
//     _pixel += 1;
//     if (_pixel >= width) {
//       _lines.writeln();
//       _pixel = 0;
//     }
//   }
// 
//   @override
//   String toString() {
//     return _lines.toString();
//   }
// }
// 