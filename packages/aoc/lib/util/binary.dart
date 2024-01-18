extension BinaryIntExtension on int {
  List<int> get bits => toRadixString(2).split('').map(int.parse).toList();
}
