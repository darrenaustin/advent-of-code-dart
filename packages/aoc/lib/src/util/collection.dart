import 'package:collection/collection.dart';

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

  (T, T)? onlyDifference() {
    final diffs = {...this};
    if (diffs.length != 2) {
      return null;
    }
    if (length == 2) {
      return (first, last);
    }

    // Determine which is the odd one out
    int matchFirst = 0;
    int matchLast = 0;
    for (final e in this) {
      if (e == diffs.first) {
        matchFirst++;
      } else {
        matchLast++;
      }
      if (matchFirst > 1 || matchLast > 1) {
        return (matchFirst > 1)
            ? (diffs.last, diffs.first)
            : (diffs.first, diffs.last);
      }
    }
    return null;
  }

  bool allSame() => {...this}.length < 2;
}

extension IterableComparableExtension<T extends Comparable<T>> on Iterable<T> {
  T minBy(Comparator<T> comparator) =>
      reduce((T m, T e) => comparator(e, m) < 0 ? e : m);
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

extension ListComparableExtension<T extends Comparable> on List<T> {
  int maxIndex() {
    int maxIndex = 0;
    for (int i = 1; i < length; i++) {
      if (this[maxIndex].compareTo(this[i]) < 0) {
        maxIndex = i;
      }
    }
    return maxIndex;
  }
}

extension SetExtension<T> on Set<T> {
  bool equals(Set<T> other) {
    if (identical(this, other)) {
      return true;
    }
    if (length != other.length) {
      return false;
    }
    for (final value in this) {
      if (!other.contains(value)) {
        return false;
      }
    }
    return true;
  }

  T removeFirst() {
    final value = first;
    remove(value);
    return value;
  }
}
