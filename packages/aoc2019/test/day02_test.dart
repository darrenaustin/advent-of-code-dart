import 'package:aoc2019/src/day02.dart';
import 'package:aoc2019/src/intcode.dart';
import 'package:test/test.dart';

main() {
  group('2019 Day 02', () {
    group('part 1', () {
      test('examples', () {
        int runProgram(String program, int resultPos) {
          final machine = Intcode.from(program: program);
          while (!machine.execute()) {}
          return machine[resultPos];
        }

        expect(runProgram('1,9,10,3,2,3,11,0,99,30,40,50', 0), 3500);
        expect(runProgram('1,0,0,0,99', 0), 2);
        expect(runProgram('2,3,0,3,99', 3), 6);
        expect(runProgram('2,4,4,5,99,0', 5), 9801);
        expect(runProgram('1,1,1,4,99,5,6,0,99', 0), 30);
      });

      test('solution', () => Day02().testPart1());
    });

    group('part 2', () {
      test('solution', () => Day02().testPart2());
    });
  });
}
