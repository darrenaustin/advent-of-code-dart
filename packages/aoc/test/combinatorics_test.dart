import 'package:aoc/src/util/string.dart';
import 'package:aoc/util/combinatorics.dart';
import 'package:test/test.dart';

main() {
  test('permutations', () {
    expect(permutations([]), [[]]);
    expect(permutations([1]), [[1]]);
    expect(permutations([1, 2]), [[1, 2], [2, 1]]);
    expect(permutations([1, 2, 3]), [
      [1, 2, 3],
      [2, 1, 3],
      [3, 1, 2],
      [1, 3, 2],
      [2, 3, 1],
      [3, 2, 1]]);
    expect(permutations('abcde'.chars).length, 120);
  });
}