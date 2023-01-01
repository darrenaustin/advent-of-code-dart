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

// Heap's Algorithm
Iterable<Iterable<T>> permutations<T>(Iterable<T> elements) sync* {
  final List<T> toPermute = List.from(elements);
  final int numElements = toPermute.length;
  final c = List.generate(numElements, (_) => 0);
  yield elements;
  int i = 0;
  while (i < numElements) {
    if (c[i] < i) {
      if (i.isEven) {
        final temp = toPermute[0];
        toPermute[0] = toPermute[i];
        toPermute[i] = temp;
      } else {
        final temp = toPermute[c[i]];
        toPermute[c[i]] = toPermute[i];
        toPermute[i] = temp;
      }
      yield List.from(toPermute);
      c[i] += 1;
      i = 0;
    } else {
      c[i] = 0;
      i += 1;
    }
  }
}
