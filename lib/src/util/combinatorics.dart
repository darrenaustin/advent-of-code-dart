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
