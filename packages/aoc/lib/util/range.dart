Iterable<int> range(int startOrEnd, [int? end]) =>
    Range(startOrEnd, end).iterable();

Iterable<int> rangeinc(int startOrEnd, [int? end]) =>
    Range.inc(startOrEnd, end).iterable();

class Range {
  const Range(int startOrEnd, [int? end])
      : start = (end != null) ? startOrEnd : 0,
        end = end ?? startOrEnd;

  factory Range.inc(int startOrEnd, [int? end]) {
    final start = (end != null) ? startOrEnd : 0;
    end ??= startOrEnd;
    final step = (end - start).sign;
    return Range(start, end + (step == 0 ? 1 : step));
  }

  final int start;
  final int end;

  int get _step => (end - start).sign;

  bool contains(num value) =>
      _step > 0 ? start <= value && value < end : end < value && value <= start;

  Iterable<int> iterable() sync* {
    final step = _step;
    int value = start;
    if (step > 0) {
      while (value < end) {
        yield value;
        value += step;
      }
    } else {
      while (end < value) {
        yield value;
        value += step;
      }
    }
  }

  @override
  String toString() => 'Range($start..$end)';
}
