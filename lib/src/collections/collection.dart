part of queries.collections;

abstract class ICollection<TElement> implements IEnumerable<TElement> {
  bool get isReadOnly;

  int get length;

  void add(TElement item);

  void clear();

  bool containsValue(TElement item);

  void copyTo(List<TElement> list, int index);

  bool remove(TElement item);
}

class Collection<TElement> extends Object with _Collection<TElement>, Enumerable<TElement> {
  Collection([List<TElement> items]) {
    if(items == null) {
      items = <TElement>[];
    }

    _items = items;
  }
}

abstract class _Collection<TElement> implements ICollection<TElement>, IList<TElement>, IReadOnlyCollection<TElement>, IReadOnlyList<TElement> {
  List<TElement> _items;

  bool get isReadOnly {
    return false;
  }

  List<TElement> get items {
    if(isReadOnly) {
      throw new UnsupportedError("items");
    }

    return _items;
  }

  Iterator<TElement> get iterator {
    return _items.iterator;
  }

  int get length {
    return _items.length;
  }

  TElement operator [](int index) {
    return _items[index];
  }

  void operator []=(int index, TElement item) {
    if(isReadOnly) {
      throw new UnsupportedError("items=");
    }

    _items[index] = item;
  }

  void add(TElement element) {
    if(isReadOnly) {
      throw new UnsupportedError("add()");
    }

    _items.add(element);
  }

  void copyTo(List<TElement> list, int index) {
    if(list == null) {
      throw new ArgumentError("list: $list");
    }

    if(index == null) {
      throw new ArgumentError("index: $index");
    }

    var length = this.length;
    var rest = length - index;
    if(index < 0 || rest <= 0) {
      throw new RangeError("index: $index");
    }

    var end = index + rest;
    for(var i = index; i < end; i++) {
      list[i] = _items[i];
    }
  }

  void clear() {
    if(isReadOnly) {
      throw new UnsupportedError("clear()");
    }

    _items.clear();
  }

  bool containsValue(TElement item) {
    return _items.contains(item);
  }

  int indexOf(TElement item, [int start = 0]) {
    return _items.indexOf(item, start);
  }

  void insert(int index, TElement item) {
    if(isReadOnly) {
      throw new UnsupportedError("insert()");
    }

    _items.insert(index, item);
  }

  bool remove(TElement item) {
    if(isReadOnly) {
      throw new UnsupportedError("remove()");
    }

    return _items.remove(item);
  }

  TElement removeAt(int index) {
    if(isReadOnly) {
      throw new UnsupportedError("removeAt()");
    }

    return _items.removeAt(index);
  }

  String toString() {
    return _items.toString();
  }
}
