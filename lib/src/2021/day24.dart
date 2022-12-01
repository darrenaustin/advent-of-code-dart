// https://adventofcode.com/2021/day/24


// import 'package:advent_of_code_dart/src/util/collection.dart';

import '../../day.dart';

class Day24 extends AdventDay {
  Day24() : super(2021, 24);

  @override
  dynamic part1() {
    return null;
    // print(validModelNumber([7, 9, 9, 9, 7, 3, 9, 1, 9, 6, 9, 6, 4, 9]));
    // print(validModelNumber(51131616112781.toString().split('').map(int.parse).toList()));

    // final digitPrograms = inputData().split('inp ').map((p) => ('inp ' + p).split('\n').where((s) => s.isNotEmpty).toList()).skip(1).toList();
    // final expectedZ = digitPrograms.map((p) => p.firstWhere((l) => l.startsWith('div z')).endsWith('26') ? 0 : 1).toList();
    // print(digitPrograms);
    // print(expectedZ);
    //
    // final alu = ALU();
    // final digits = [9, 8, 7, 6, 5, 4, 3, 2, 1];
    //
    // final result = <int>[];
    // int initialZ = 0;
    // for (int d = 0; d < 14; d++) {
    //   final found = digits.firstWhere((candidate) {
    //     alu.run(digitPrograms[d], [candidate], initialZ);
    //     print('digit $d trying $candidate with $initialZ -> ${alu.z}');
    //     return alu.z == expectedZ[d];
    //   });
    //   result.add(found);
    //   initialZ = expectedZ[d];
    // }
    // print(result);

    // final program = inputDataLines();
    // final neededZ = <int>[];
    // final lines = program.iterator;
    // while (lines.moveNext()) {
    //   if (lines.current.startsWith('div z')) {
    //     neededZ.add(lines.current == 'div z 26' ? 0 : 1);
    //   }
    // }
    // print(neededZ);

    //
    // final digitProgs = <List<String>>[];
    // List<String>? digitProg;
    // for (final line in inputDataLines()) {
    //   if (line.startsWith('inp')) {
    //     if (digitProg != null) {
    //       digitProgs.add(digitProg);
    //     }
    //     digitProg = [line];
    //   } else {
    //     digitProg!.add(line);
    //   }
    // }
    // digitProgs.add(digitProg!);
    //
    // final alu = ALU();
    // var pzs = {0};
    // final zsFor = <Set<int>>[];
    // for (int d = 0; d < 14; d++) {
    //   final zs = <int>{};
    //   for (final pz in pzs) {
    //     for (int i = 1; i <= 9; i++) {
    //       alu.run(digitProgs[d], [i], pz);
    //       zs.add(alu.z);
    //     }
    //   }
    //   zsFor.add(zs);
    //   pzs = zs;
    //   print('options for digit $d: ${zs.length}');
    // }

  //
  //   final alu = ALU();
  //   final digitZs = <Map<int, Map<int, int>>>[];
  //   for (int d = 0; d < 14; d++) {
  //     final zs = <int, Map<int, int>>{};
  //     for (int pz = 0; pz < 3 * 26; pz++) {
  //       for (int i = 1; i <= 9; i++) {
  //         alu.run(digitProgs[d], [i], pz);
  //         zs[i] = (zs[i] ?? {})..[pz] = alu.z;
  //       }
  //     }
  //     digitZs.add(zs);
  //   }
  //
  //   Map<int, Map<int, int>> filterZOut(Map<int, Map<int, int>> m, Set<int> outValues) {
  //     final result = <int, Map<int, int>>{};
  //
  //     for (int digit in m.keys) {
  //       final matchingOut = Map.fromEntries(m[digit]!.entries.where((kv) => outValues.contains(kv.value)));
  //       if (matchingOut.isNotEmpty) {
  //         result[digit] = matchingOut;
  //       }
  //     }
  //     return result;
  //   }
  //
  //   var validOut = {0};
  //   for (int d = 13; d >= 0; d--) {
  //     digitZs[d] = filterZOut(digitZs[d], validOut);
  //     validOut = <int>{};
  //     for (final digit in digitZs[d].keys) {
  //       validOut.addAll(digitZs[d][digit]!.keys);
  //     }
  //     print('digit $d: ${digitZs[d]}');
  //     print('  validOut = $validOut');
  //   }
  }

  @override
  dynamic part2() {
    return null;
  }

  bool validModelNumber(List<int> digits) {
    final alu = ALU();
    alu.run(inputDataLines(), digits);
    print('z = ${alu.z}');
    return alu.z == 0;
  }
}

class ALU {

  static const varNames = { 'w': 0, 'x': 1, 'y': 2, 'z':3 };

  int get w => vars[varNames['w']!];
  int get x => vars[varNames['x']!];
  int get y => vars[varNames['y']!];
  int get z => vars[varNames['z']!];

  void run(List<String> instructions, List<int> input, [int initialZ = 0]) {
    for (int v = 0; v < vars.length; v++) {
      vars[v] = 0;
    }
    vars[varNames['z']!] = initialZ;

    for (final line in instructions) {
      final parts = line.split(' ');
      switch (parts[0]) {
        case 'inp':
          print('digit ${input.first}');
          vars[_variable(parts[1])] = input.removeAt(0);
          break;
        case 'add':
          vars[_variable(parts[1])] += _value(parts[2]);
          if (parts[1] == 'z' && parts[2] == 'y') {
            print('     => z = $z');
          }
          break;
        case 'mul':
          vars[_variable(parts[1])] *= _value(parts[2]);
          break;
        case 'div':
          vars[_variable(parts[1])] ~/= _value(parts[2]);
          break;
        case 'mod':
          vars[_variable(parts[1])] %= _value(parts[2]);
          break;
        case 'eql':
          final variable = _variable(parts[1]);
          vars[variable] = vars[variable] == _value(parts[2]) ? 1 : 0;
          break;
        default:
          throw Exception('Unknown instruction $line');
      }
      // print('$parts : $vars');
    }
  }

  final vars = List<int>.filled(4, 0);

  int _variable(String name) {
    if (varNames.containsKey(name)) {
      return varNames[name]!;
    }
    throw Exception('Unknown variable $name');
  }

  int _value(String param) {
    if (varNames.containsKey(param)) {
      return vars[varNames[param]!];
    }
    // Parse the int
    return int.parse(param);
  }

}
