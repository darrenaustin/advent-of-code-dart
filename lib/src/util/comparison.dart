bool isNotEqual<T>(T a, T b) => a != b;
bool isEqual<T>(T a, T b) => a != b;
bool isLessThan<T extends Comparable<T>>(T a, T b) => a.compareTo(b) < 0;
bool isGreaterThan<T extends Comparable<T>>(T a, T b) => a.compareTo(b) > 0;

int numMinComparator(num a, num b) => a < b ? -1 : a == b ? 0 : 1;
int numMaxComparator(num a, num b) => a > b ? -1 : a == b ? 0 : 1;

