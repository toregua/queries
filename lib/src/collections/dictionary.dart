part of queries.collections;

abstract class IDictionary<TKey, TValue> implements ICollection<KeyValuePair<TKey, TValue>> {
  IEqualityComparer<TKey> get comparer;

  ICollection<TKey> get keys;

  ICollection<TValue> get values;

  TValue operator [](TKey key);

  void operator []=(TKey key, TValue value);

  bool removeKey(TKey key);

  Map<TKey, TValue> toMap();
}

class Dictionary<TKey, TValue> extends Object with Queryable<KeyValuePair<TKey, TValue>> implements IDictionary<TKey, TValue>, IReadOnlyCollection<KeyValuePair<TKey, TValue>> {
  IEqualityComparer<TKey> _comparer;

  Map<TKey, TValue> _source;

  Dictionary([IEqualityComparer<TKey> comparer]) {
    if(comparer == null) {
      comparer = new EqualityComparer<TKey>();
    }

    _comparer = comparer;
    _source = new LinkedHashMap(equals : comparer.equals, hashCode : comparer.getHashCode);
  }

  Dictionary.fromDictionary(IDictionary<TKey, TValue> dictionary, [IEqualityComparer<TKey> comparer]) {
    if(dictionary == null) {
      throw new ArgumentError("dictionary: $dictionary");
    }

    if(comparer == null) {
      comparer = new EqualityComparer<TKey>();
    }

    _comparer = comparer;
    _source = new LinkedHashMap(equals : comparer.equals, hashCode : comparer.getHashCode);
    if(dictionary is Dictionary) {
      _source.addAll((dictionary as Dictionary)._source);
    } else {
      _source.addAll(dictionary.toMap());
    }
  }

  Dictionary.fromMap(Map<TKey, TValue> map, [IEqualityComparer<TKey> comparer]) {
    if(map == null) {
      throw new ArgumentError("map: $map");
    }

    if(comparer == null) {
      comparer = new EqualityComparer<TKey>();
    }

    _comparer = comparer;
    _source = new LinkedHashMap(equals : comparer.equals, hashCode : comparer.getHashCode);
    _source.addAll(map);
  }

  IEqualityComparer<TKey> get comparer {
    return _comparer;
  }

  bool get isReadOnly {
    return false;
  }

  Iterator<KeyValuePair<TKey, TValue>> get iterator {
    return _getIterator();
  }

  DictionaryKeyCollection<TKey, TValue> get keys {
    return new DictionaryKeyCollection<TKey, TValue>(this);
  }

  int get length {
    return _source.length;
  }

  DictionaryValueCollection<TKey, TValue> get values {
    return new DictionaryValueCollection<TKey, TValue>(this);
  }

  TValue operator [](TKey key) {
    return _source[key];
  }

  void operator []=(TKey key, TValue value) {
    _source[key] = value;
  }

  void add(KeyValuePair<TKey, TValue> element) {
    if(element == null) {
      throw new ArgumentError("element: $element");
    }

    _source[element.key] = element.value;
  }

  void clear() {
    _source.clear();
  }

  bool containsKey(TKey key) {
    return _source.containsKey(key);
  }

  bool containsValue(TValue value) {
    return _source.containsValue(value);
  }

  void copyTo(List<KeyValuePair<TKey, TValue>> list, int index) {
    if(list == null) {
      throw new ArgumentError("list: $list");
    }

    if(index == null) {
      throw new ArgumentError("index: $index");
    }

    if(index < 0) {
      throw new RangeError("index: $index");
    }

    var iterator = this.iterator;
    while(iterator.moveNext()) {
      list[index++] = iterator.current;
    }
  }

  bool remove(KeyValuePair<TKey, TValue> element) {
    if(element == null) {
      throw new ArgumentError("element: $element");
    }

    return removeKey(element.key);
  }

  bool removeKey(TKey key) {
    var exists = _source.containsKey(key);
    if(exists) {
      _source.remove(key);
      return true;
    }

    return false;
  }

  Map<TKey, TValue> toMap() {
    var map = new LinkedHashMap(equals : _comparer.equals, hashCode : _comparer.getHashCode);
    map.addAll(_source);
    return map;
  }

  Iterator<KeyValuePair<TKey, TValue>> _getIterator() {
    Iterator<TKey> keysIterator;
    var iterator = new _Iterator<KeyValuePair<TKey, TValue>>();
    iterator.action = () {
      while(true) {
        switch(iterator.state) {
          case 1:
            if(keysIterator.moveNext()) {
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

  String toString() {
    return _source.toString();
  }
}

class DictionaryKeyCollection<TKey, TValue> extends Object with Queryable<TKey> implements ICollection<TKey> {
  Dictionary<TKey, TValue> _dictionary;

  DictionaryKeyCollection(Dictionary<TKey, TValue> dictionary) {
    if(dictionary == null) {
      throw new ArgumentError("dictionary: $dictionary");
    }

    _dictionary = dictionary;
  }

  bool get isReadOnly {
    return true;
  }

  Iterator<TKey> get iterator {
    return _dictionary._source.keys.iterator;
  }

  int get length {
    return _dictionary._source.keys.length;
  }

  void add(TKey item) {
    throw new UnsupportedError("add()");
  }

  void clear() {
    throw new UnsupportedError("clear()");
  }

  void copyTo(List<TKey> list, int index) {
    throw new UnsupportedError("copyTo()");
  }

  bool remove(TKey item) {
    throw new UnsupportedError("remove()");
  }

  String toString() {
    return _dictionary._source.keys.toString();
  }
}

class DictionaryValueCollection<TKey, TValue> extends Object with Queryable<TValue> implements ICollection<TValue> {
  Dictionary<TKey, TValue> _dictionary;

  DictionaryValueCollection(Dictionary<TKey, TValue> dictionary) {
    if(dictionary == null) {
      throw new ArgumentError("dictionary: $dictionary");
    }

    _dictionary = dictionary;
  }

  bool get isReadOnly {
    return true;
  }

  Iterator<TValue> get iterator {
    return _dictionary._source.values.iterator;
  }

  int get length {
    return _dictionary._source.values.length;
  }

  void add(TValue item) {
    throw new UnsupportedError("add()");
  }

  void clear() {
    throw new UnsupportedError("clear()");
  }

  void copyTo(List<TValue> list, int index) {
    throw new UnsupportedError("copyTo()");
  }

  bool remove(TValue item) {
    throw new UnsupportedError("remove()");
  }

  String toString() {
    return _dictionary._source.values.toString();
  }
}
