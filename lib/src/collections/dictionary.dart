part of queries.collections;

class Dictionary<TKey, TValue> extends _Dictionary<TKey, TValue> with Enumerable<KeyValuePair<TKey, TValue>> {
  Dictionary([IEqualityComparer<TKey> comparer]) {
    if (comparer == null) {
      comparer = new EqualityComparer<TKey>();
    }

    _comparer = comparer;
    _source = new LinkedHashMap(equals: comparer.equals, hashCode: comparer.getHashCode);
  }

  Dictionary.fromDictionary(IDictionary<TKey, TValue> dictionary, [IEqualityComparer<TKey> comparer]) {
    if (dictionary == null) {
      throw new ArgumentError("dictionary: $dictionary");
    }

    if (comparer == null) {
      comparer = new EqualityComparer<TKey>();
    }

    _comparer = comparer;
    _source = new LinkedHashMap(equals: comparer.equals, hashCode: comparer.getHashCode);
    for (var kvp in dictionary.asIterable()) {
      _source[kvp.key] = kvp.value;
    }
  }

  Dictionary.fromMap(Map<TKey, TValue> map, [IEqualityComparer<TKey> comparer]) {
    if (map == null) {
      throw new ArgumentError("map: $map");
    }

    if (comparer == null) {
      comparer = new EqualityComparer<TKey>();
    }

    _comparer = comparer;
    _source = new LinkedHashMap(equals: comparer.equals, hashCode: comparer.getHashCode);
    _source.addAll(map);
  }

  DictionaryKeyCollection<TKey, TValue> get keys {
    return new DictionaryKeyCollection<TKey, TValue>(this);
  }

  DictionaryValueCollection<TKey, TValue> get values {
    return new DictionaryValueCollection<TKey, TValue>(this);
  }
}

class DictionaryKeyCollection<TKey, TValue> extends Object with Enumerable<TKey> implements ICollection<TKey> {
  Dictionary<TKey, TValue> _dictionary;

  Iterable<TKey> _items;

  DictionaryKeyCollection(Dictionary<TKey, TValue> dictionary) {
    if (dictionary == null) {
      throw new ArgumentError("dictionary: $dictionary");
    }

    _dictionary = dictionary;
    _items = dictionary._source.keys;
  }

  bool get isReadOnly {
    return _dictionary.isReadOnly;
  }

  Iterator<TKey> get iterator {
    return _items.iterator;
  }

  int get length {
    return _items.length;
  }

  void add(TKey item) {
    throw new UnsupportedError("add()");
  }

  void clear() {
    _dictionary.clear();
  }

  bool containsValue(TKey value) {
    var iterator = this.iterator;
    while (iterator.moveNext()) {
      if (value == iterator.current) {
        return true;
      }
    }

    return false;
  }

  // TODO: copyTo()
  void copyTo(List<TKey> list, int index) {
    throw new UnimplementedError("copyTo()");
  }

  bool remove(TKey item) {
    return _dictionary.removeKey(item);
  }

  String toString() {
    return _items.toString();
  }
}

class DictionaryValueCollection<TKey, TValue> extends Object with Enumerable<TValue> implements ICollection<TValue> {
  Dictionary<TKey, TValue> _dictionary;

  Iterable<TValue> _items;

  DictionaryValueCollection(Dictionary<TKey, TValue> dictionary) {
    if (dictionary == null) {
      throw new ArgumentError("dictionary: $dictionary");
    }

    _dictionary = dictionary;
    _items = dictionary._source.values;
  }

  bool get isReadOnly {
    return _dictionary.isReadOnly;
  }

  Iterator<TValue> get iterator {
    return _items.iterator;
  }

  int get length {
    return _items.length;
  }

  void add(TValue item) {
    throw new UnsupportedError("add()");
  }

  void clear() {
    _dictionary.clear();
  }

  bool containsValue(TValue value) {
    var iterator = this.iterator;
    while (iterator.moveNext()) {
      if (value == iterator.current) {
        return true;
      }
    }

    return false;
  }

  // TODO: copyTo()
  void copyTo(List<TValue> list, int index) {
    throw new UnimplementedError("copyTo()");
  }

  bool remove(TValue item) {
    throw new UnsupportedError("remove()");
  }

  String toString() {
    return _items.toString();
  }
}

abstract class IDictionary<TKey, TValue> implements ICollection<KeyValuePair<TKey, TValue>>, IEnumerable<KeyValuePair<TKey, TValue>> {
  IEqualityComparer<TKey> get comparer;

  ICollection<TKey> get keys;

  ICollection<TValue> get values;

  TValue operator [](TKey key);

  void operator []=(TKey key, TValue value);

  void add(KeyValuePair<TKey, TValue> element);

  void clear();

  bool containsKey(TKey key);

  bool remove(KeyValuePair<TKey, TValue> element);

  bool removeKey(TKey key);

  Map<TKey, TValue> toMap();
}

abstract class _Dictionary<TKey, TValue> implements ICollection<KeyValuePair<TKey, TValue>>, IDictionary<TKey, TValue>, IReadOnlyCollection<KeyValuePair<TKey, TValue>>, IReadOnlyDictionary<TKey, TValue> {
  IEqualityComparer<TKey> _comparer;

  Map<TKey, TValue> _source;

  IEqualityComparer<TKey> get comparer {
    return _comparer;
  }

  bool get isReadOnly {
    return false;
  }

  Iterator<KeyValuePair<TKey, TValue>> get iterator {
    return _getIterator();
  }

  int get length {
    return _source.length;
  }

  TValue operator [](TKey key) {
    return _source[key];
  }

  void operator []=(TKey key, TValue value) {
    if (isReadOnly) {
      throw new UnsupportedError("operator []=");
    }

    _source[key] = value;
  }

  void add(KeyValuePair<TKey, TValue> element) {
    if (element == null) {
      throw new ArgumentError("element: $element");
    }

    if (isReadOnly) {
      throw new UnsupportedError("add()");
    }

    _source[element.key] = element.value;
  }

  void clear() {
    if (isReadOnly) {
      throw new UnsupportedError("clear())");
    }

    _source.clear();
  }

  bool containsKey(TKey key) {
    return _source.containsKey(key);
  }

  bool containsValue(KeyValuePair<TKey, TValue> item) {
    if (item == null) {
      throw new ArgumentError("item: $item");
    }

    var key = item.key;
    return _source.containsKey(key) && _source[key] == item.value;
  }

  // TODO: copyTo()
  void copyTo(List<KeyValuePair<TKey, TValue>> list, int index) {
    throw new UnimplementedError("copyTo()");
  }

  bool remove(KeyValuePair<TKey, TValue> element) {
    if (element == null) {
      throw new ArgumentError("element: $element");
    }

    if (isReadOnly) {
      throw new UnsupportedError("remove())");
    }

    return removeKey(element.key);
  }

  bool removeKey(TKey key) {
    if (isReadOnly) {
      throw new UnsupportedError("removeKey())");
    }

    var contains = _source.containsKey(key);
    if (contains) {
      _source.remove(key);
      return true;
    }

    return false;
  }

  LinkedHashMap<TKey, TValue> toMap() {
    var map = new LinkedHashMap(equals: _comparer.equals, hashCode: _comparer.getHashCode);
    map.addAll(_source);
    return map;
  }

  String toString() {
    return _source.toString();
  }

  Iterator<KeyValuePair<TKey, TValue>> _getIterator() {
    Iterator<TKey> keysIterator;
    var iterator = new _Iterator<KeyValuePair<TKey, TValue>>();
    iterator.action = () {
      while (true) {
        switch (iterator.state) {
          case 1:
            if (keysIterator.moveNext()) {
              var key = keysIterator.current;
              iterator.result = new KeyValuePair(key, _source[key]);
              return true;
            }

            keysIterator = null;
            iterator.state = -1;
            return false;
          case 0:
            keysIterator = _source.keys.iterator;
            iterator.state = 1;
            break;
          default:
            return false;
        }
      }
    };

    return iterator;
  }
}
