import 'collection.dart';

Iterable<Iterable<T>> combinations<T>(Iterable<T> elements, int length) sync* {
  if (elements.isEmpty && length != 0) {
    return;
  } else if (length == 0) {
    yield <T>[];
  } else {
    final T element = elements.first;
    for (final Iterable<T> subset in combinations<T>(elements.skip(1), length - 1)) {
      yield <T>[element, ...subset];
    }
    for (final Iterable<T> subset in combinations<T>(elements.skip(1), length)) {
      yield subset;
    }
  }
}

Iterable<Iterable<Iterable<T>>> partitions<T>(Iterable<T> elements, int numPartitions) sync* {
  if (numPartitions == 1) {
    yield [elements];
  } else if (numPartitions == elements.length) {
    yield [...elements.map((e) => [e])];
  } else {
    final head = elements.first;
    final tail = elements.skip(1);
    for (final p in partitions(tail, numPartitions - 1)) {
      yield [[head], ...p];
    }
    for (final p in partitions(tail, numPartitions)) {
      for (final i in range(p.length)) {
        yield [...p.take(i), [head, ...p.elementAt(i)], ...p.skip(i + 1)];
      }
    }
  }
}
