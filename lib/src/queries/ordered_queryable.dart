part of queries;

abstract class IOrderedQueryable<TElement> implements IQueryable<TElement> {
  /**
   * OrderedQueryable<TElement> createOrderedQueryable<TKey>(TKey keySelector(TElement element), bool descending, [Comparator<TKey> comparer]);
   */
  IOrderedQueryable<TElement> createOrderedQueryable(dynamic keySelector(TElement element), bool descending, [Comparator<dynamic> comparer]);

  /**
   * OrderedQueryable<TElement> thenBy<TKey>(TKey keySelector(TElement element), [Comparator<<TKey>> comparer]);
   */
  IOrderedQueryable<TElement> thenBy(dynamic keySelector(TElement element), [Comparator<dynamic> comparer]);

  /**
   * OrderedQueryable<TElement> thenByDescending<TKey>(TKey keySelector(TElement element), [Comparator<<TKey>> comparer]);
   */
  IOrderedQueryable<TElement> thenByDescending(dynamic keySelector(TElement element), [Comparator<dynamic> comparer]);
}

abstract class _OrderedQueryable<TElement> extends Object with Queryable<TElement> implements IOrderedQueryable<TElement> {
  /**
   * OrderedQueryable<TElement> createOrderedQueryable<TKey>(TKey keySelector(TElement element), bool descending, [Comparator<TKey> comparer]);
   */
  IOrderedQueryable<TElement> createOrderedQueryable(dynamic keySelector(TElement element), bool descending, [Comparator<dynamic> comparer]) {
    // return new ThenByIterator<TElement, TKey>(this, keySelector, descending, comparer);
    return new _ThenByIterator<TElement, dynamic>(this, keySelector, descending, comparer);
  }

  /**
   * OrderedQueryable<TElement> thenBy<TKey>(TKey keySelector(TElement element), [Comparator<<TKey>> comparer]);
   */
  IOrderedQueryable<TElement> thenBy(dynamic keySelector(TElement element), [Comparator<dynamic> comparer]) {
    // return createOrderedQueryable<TKey>(keySelector, false, comparer);
    return new _ThenByIterator<TElement, dynamic>(this, keySelector, false, comparer);
  }

  /**
   * OrderedQueryable<TElement> thenByDescending<TKey>(TKey keySelector(TElement element), [Comparator<<TKey>> comparer]);
   */
  IOrderedQueryable<TElement> thenByDescending(dynamic keySelector(TElement element), [Comparator<dynamic> comparer]) {
    // return createOrderedQueryable<TKey>(keySelector, true, comparer);
    return new _ThenByIterator<TElement, dynamic>(this, keySelector, true, comparer);
  }
}
