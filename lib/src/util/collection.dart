import 'comparison.dart';

extension IterableIntExtension on Iterable<int> {
  int sum() => fold<int>(0, (int s, int e) => s + e);

  int product() => fold<int>(1, (int p, int e) => p * e);

  int min() => extremeValue(numMinComparator);

  int max() => extremeValue(numMaxComparator);

  int extremeValue(Comparator<int> comparator) =>
      reduce((int m, int e) => comparator(e, m) < 0 ? e : m);
}

extension IterableDoubleExtension on Iterable<double> {
  double sum() => fold<double>(0, (double s, double e) => s + e);

  double product() => fold<double>(1, (double p, double e) => p * e);

  double min() => extremeValue(numMinComparator);

  double max() => extremeValue(numMaxComparator);

  double extremeValue(Comparator<double> comparator) =>
      reduce((double m, double e) => comparator(e, m) < 0 ? e : m);
}

extension IterableExtensions<T> on Iterable<T> {
  int quantify(bool Function(T) test) => where(test).length;

  Iterable<Iterable<T>> partition(int size) sync* {
    if (length <= size) {
      yield this;
    } else {
      final Iterator<T> iter = iterator;
      List<T> current = <T>[];
      int count = 0;
      while (iter.moveNext()) {
        current.add(iter.current);
        count++;
        if (count == size) {
          yield current;
          current = <T>[];
          count = 0;
        }
      }
      if (current.isNotEmpty) {
        yield current;
      }
    }
  }

  Iterable<Iterable<T>> partitionWhere(bool Function(T, T) test) sync* {
    if (length < 2) {
      yield this;
    } else {
      final Iterator<T> iter = iterator;
      iter.moveNext();
      T last = iter.current;
      List<T> current = <T>[last];
      while (iter.moveNext()) {
        if (test(last, iter.current)) {
          yield current;
          last = iter.current;
          current = <T>[last];
        } else {
          last = iter.current;
          current.add(last);
        }
      }
      yield current;
    }
  }
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
      value += step;
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
