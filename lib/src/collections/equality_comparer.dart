part of queries.collections;

abstract class IEqualityComparer<T> {
  bool equals(T a, T b);

  int getHashCode(T object);
}

class EqualityComparer<T> implements IEqualityComparer<T> {
  bool equals(T a, T b) {
    return a == b;
  }

  int getHashCode(T object) {
    return object.hashCode;
  }
}
