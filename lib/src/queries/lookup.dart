part of queries;

abstract class ILookup<TKey, TElement> implements IQueryable<IGrouping<TKey, TElement>> {
  IQueryable<TElement> operator [](TKey key);

  bool containsKey(TKey key);

  int get length;
}

class Lookup<TKey, TElement> extends Object with Queryable implements ILookup<TKey, TElement> {
  IGrouping<TKey, TElement> _current;

  Dictionary<TKey, IGrouping<TKey, TElement>> _groupings;

  Iterator<IGrouping<TKey, TElement>> _resultIterator;

  Lookup._internal(this._groupings);

  IGrouping<TKey, TElement> get current {
    return _current;
  }

  Iterator<IGrouping<TKey, TElement>> get iterator {
    return _groupings.values.iterator;
  }

  int get length {
    return _groupings.length;
  }

  IQueryable<TElement> operator [](TKey key) {
    var grouping = _groupings[key];
    if(grouping != null) {
      return grouping;
    }

    return new EmptyIterator<TElement>();
  }

  /**
   * IQueryable<TResult> applyResultSelector<TResult>(TResult resultSelector(TKey key, IQueryable<TElement> elements)) {
   */
  IQueryable<dynamic> applyResultSelector(dynamic resultSelector(TKey key, IQueryable<TElement> elements)) {
    if(resultSelector == null) {
      throw new ArgumentError("resultSelector: $resultSelector");
    }

    return select((g) => resultSelector(g.key, g.elements));
  }

  bool containsKey(TKey key) {
    return _groupings.containsKey(key);
  }
}
