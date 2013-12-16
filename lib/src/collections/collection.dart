part of queries.collections;

class Collection<TElement> extends Object with _Collection<TElement>, Queryable<TElement> {
  Collection([List<TElement> items]) {
    if(items == null) {
      items = <TElement>[];
    }

    _items = items;
  }
}

abstract class _Collection<TElement> implements ICollection<TElement>, IList<TElement>, IReadOnlyCollection<TElement>, IReadOnlyList<TElement> {
  dynamic _items;

  bool get isReadOnly {
    return false;
  }

  List<TElement> get items {
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
    _items[index] = item;
  }

  void add(TElement element) {
    _items.add(element);
  }

  ReadOnlyCollection<TElement> asReadOnly() {
    return new ReadOnlyCollection(_items);
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
    _items.clear();
  }

  int indexOf(TElement item, [int start = 0]) {
    return _items.indexOf(item, start);
  }

  void insert(int index, TElement item) {
    _items.insert(index, item);
  }

  bool remove(TElement item) {
    return _items.remove(item);
  }

  TElement removeAt(int index) {
    return _items.removeAt(index);
  }

  String toString() {
    return _items.toString();
  }
}

abstract class ICollection<TElement> implements IQueryable<TElement> {
  bool get isReadOnly;

  int get length;

  void add(TElement item);

  void clear();

  void copyTo(List<TElement> list, int index);

  bool remove(TElement item);
}

abstract class IReadOnlyCollection<TElement> implements IQueryable<TElement> {
  int get length;
}

class ReadOnlyCollection<TElement> extends _Collection<TElement> with Queryable<TElement> {
  ReadOnlyCollection(List<TElement> items) {
    if(items == null) {
      throw new ArgumentError("items: $items");
    }

    _items = items;
  }

  ReadOnlyCollection.unsafe(dynamic items) {
    if(items == null) {
      throw new ArgumentError("items: $items");
    }

    _items = items;
  }

  bool get isReadOnly {
    return true;
  }

  List<TElement> get items {
    throw new UnsupportedError("items()");
  }

  void operator []=(int index, TElement item) {
    throw new UnsupportedError("operator []=");
  }

  void add(TElement element) {
    throw new UnsupportedError("add()");
  }

  void clear() {
    throw new UnsupportedError("clear()");
  }

  void insert(int index, TElement item) {
    throw new UnsupportedError("insert()");
  }

  bool remove(TElement item) {
    throw new UnsupportedError("remove()");
  }

  TElement removeAt(int index) {
    throw new UnsupportedError("removeAt()");
  }
}
