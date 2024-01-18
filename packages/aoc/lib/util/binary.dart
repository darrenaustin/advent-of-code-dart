extension BinaryIntExtension on int {
  List<int> get bits {
    if (this < 0) {
      throw ArgumentError.value(this, null, 'Number must be positive');
    }
    return toRadixString(2).split('').map(int.parse).toList();
  }
}
