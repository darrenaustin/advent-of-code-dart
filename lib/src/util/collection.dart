export 'package:collection/collection.dart';

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

Iterable<int> range(int startOrEnd, [int? end, int step = 1]) sync* {
  int value = (end != null) ? startOrEnd : 0;
  end ??= startOrEnd;
  if (end > value) {
    while (value < end) {
      yield value;
      value += step;
    }
  } else {
    while (value > end) {
      yield value;
      value -= step;
    }
  }
}

extension DefaultMap<K, V> on Map<K, V> {
  V getOrElse(K key, V defaultValue) {
    if (containsKey(key)) {
      return this[key]!;
    } else {
      return defaultValue;
    }
  }
}
