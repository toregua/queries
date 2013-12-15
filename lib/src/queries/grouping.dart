part of queries;

abstract class IGrouping<TKey, TElement> implements IQueryable<TElement> {
  TKey get key;
}

class _Grouping<TKey, TElement> extends _QueryableIterator<TElement> implements IGrouping<TKey, TElement> {
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