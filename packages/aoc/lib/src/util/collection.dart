extension IterableIntExtension on Iterable<int> {
  int get product => fold<int>(1, (int p, int e) => p * e);

  int minBy(Comparator<int> comparator) =>
      reduce((int m, int e) => comparator(e, m) < 0 ? e : m);
}

extension IterableDoubleExtension on Iterable<double> {
  double get product => fold<double>(1, (double p, double e) => p * e);

  double minBy(Comparator<double> comparator) =>
      reduce((double m, double e) => comparator(e, m) < 0 ? e : m);
}

extension IterableExtensions<T> on Iterable<T> {
  int quantify(bool Function(T) test) => where(test).length;

  Iterable<Iterable<T>> slicesWhere(bool Function(T, T) test) sync* {
    if (length < 2) {
      yield this;
    } else {
      final Iterator<T> iterator = this.iterator..moveNext();
      T previous = iterator.current;
      List<T> slice = <T>[previous];
      while (iterator.moveNext()) {
        if (test(previous, iterator.current)) {
          yield slice;
          slice = <T>[];
        }
        previous = iterator.current;
        slice.add(previous);
      }
      yield slice;
    }
  }
}

extension IterableComparableExtension<T extends Comparable<T>> on Iterable<T> {
  T minBy(Comparator<T> comparator) =>
      reduce((T m, T e) => comparator(e, m) < 0 ? e : m);
}

Iterable<int> range(int startOrEnd, [int? end, int? step]) sync* {
  int value = (end != null) ? startOrEnd : 0;
  end ??= startOrEnd;
  step ??= (end - value).sign;
  if ((end - value).sign != step.sign) {
    // Invalid range, so just return empty iterable.
    return;
  }
  while (step > 0 ? value < end : end < value) {
    yield value;
    value += step;
  }
}

Iterable<T> iterate<T>(T Function(T) fn, T value) sync* {
  while (true) {
    yield value;
    value = fn(value);
  }
}

extension DefaultMap<K, V> on Map<K, V> {
  V getOrElse(K key, V defaultValue) {
    if (containsKey(key)) {
      return this[key]!;
    }
    return defaultValue;
  }
}

/// Returns a map of element to element count for the given iterable.
Map<T, int> frequencies<T>(Iterable<T> elements) {
  return elements.fold({}, (counts, element) {
    counts[element] = (counts[element] ?? 0) + 1;
    return counts;
  });
}

extension ListExtension<T> on List<T> {
  Iterable<int> indicesWhere(bool Function(T) test) {
    final indices = <int>[];
    int index = indexWhere(test);
    while (index != -1) {
      indices.add(index);
      index = indexWhere(test, index + 1);
    }
    return indices;
  }

  List<T> repeat(int times) => [
        for (int i = 0; i < times; i++) ...this,
      ];
}

extension SetExtension<T> on Set<T> {
  T removeFirst() {
    final value = first;
    remove(value);
    return value;
  }
}
