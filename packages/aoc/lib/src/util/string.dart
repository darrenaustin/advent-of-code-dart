extension StringExtension on String {
  List<String> get chars => split('');

  List<String> get lines => split('\n');
}

extension RegExpExtension on RegExp {
  Iterable<String> allStringMatches(String input) =>
    allMatches(input).map((m) => m.group(0)!);
}
