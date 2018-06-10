part of queries;

abstract class IGrouping<TKey, TElement> implements IEnumerable<TElement> {
  TKey get key;
}

class _Grouping<TKey, TElement> extends _EnumerableIterator<TElement> implements IGrouping<TKey, TElement> {
  dynamic _source;

  TKey _key;

  _Grouping(TKey key, HasIterator<TElement> elements) : super(elements) {
    _key = key;
  }

  Iterator<TElement> get iterator {
    return _source.iterator;
  }

  TKey get key => _key;
}
