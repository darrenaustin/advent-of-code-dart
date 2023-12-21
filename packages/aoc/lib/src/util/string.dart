extension StringExtension on String {
  List<String> get chars => split('');

  List<String> get lines => split('\n');

  List<int> numbers() =>
      RegExp(r'-?\d+').allStringMatches(this).map(int.parse).toList();

  String repeat(int times, [String seperator = '']) =>
      List.generate(times, (_) => this).join(seperator);

  static final int _lowerA = 'a'.codeUnits[0];
  static final int _lowerZ = 'z'.codeUnits[0];
  static final int _upperA = 'A'.codeUnits[0];
  static final int _upperZ = 'Z'.codeUnits[0];

  bool isLowerCase() => chars
      .every((c) => _lowerA <= c.codeUnits[0] && c.codeUnits[0] <= _lowerZ);
  bool isUpperCase() => chars
      .every((c) => _upperA <= c.codeUnits[0] && c.codeUnits[0] <= _upperZ);
}

extension RegExpExtension on RegExp {
  Iterable<String> allStringMatches(String input) =>
      allMatches(input).map((m) => m.group(0)!);

  Iterable<String> allOverlappingStringMatches(String input) {
    final matches = <String>[];
    int index = 0;
    var match = allMatches(input, index).firstOrNull;
    while (match != null) {
      matches.add(match.group(0)!);
      index = match.start + 1;
      match = allMatches(input, index).firstOrNull;
    }
    return matches;
  }
}
