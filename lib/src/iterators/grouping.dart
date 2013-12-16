part of queries.iterators;

class _Grouping<TKey, TElement> extends QueryableIterator<TElement> implements IGrouping<TKey, TElement> {
  HasIterator<TElement> _source;

  TKey _key;

  _Grouping(TKey key, HasIterator<TElement> elements) : super(elements) {
    _key = key;
  }

  TKey get key => _key;

  Iterator<TElement> get iterator {
    return _source.iterator;
  }
}