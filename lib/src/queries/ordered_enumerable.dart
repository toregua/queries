part of queries;

abstract class IOrderedEnumerable<TElement> implements IEnumerable<TElement> {
  /**
   * OrderedEnumerable<TElement> createOrderedQueryable<TKey>(TKey keySelector(TElement element), bool descending, [Comparator<TKey> comparer]);
   */
  IOrderedEnumerable<TElement> createOrderedQueryable(dynamic keySelector(TElement element), bool descending, [Comparator<dynamic> comparer]);

  /**
   * OrderedEnumerable<TElement> thenBy<TKey>(TKey keySelector(TElement element), [Comparator<<TKey>> comparer]);
   */
  IOrderedEnumerable<TElement> thenBy(dynamic keySelector(TElement element), [Comparator<dynamic> comparer]);

  /**
   * OrderedEnumerable<TElement> thenByDescending<TKey>(TKey keySelector(TElement element), [Comparator<<TKey>> comparer]);
   */
  IOrderedEnumerable<TElement> thenByDescending(dynamic keySelector(TElement element), [Comparator<dynamic> comparer]);
}

abstract class _OrderedEnumerable<TElement> extends Object with Enumerable<TElement> implements IOrderedEnumerable<TElement> {
  /**
   * OrderedEnumerable<TElement> createOrderedQueryable<TKey>(TKey keySelector(TElement element), bool descending, [Comparator<TKey> comparer]);
   */
  IOrderedEnumerable<TElement> createOrderedQueryable(dynamic keySelector(TElement element), bool descending, [Comparator<dynamic> comparer]) {
    // return new ThenByIterator<TElement, TKey>(this, keySelector, descending, comparer);
    return new _ThenByIterator<TElement, dynamic>(this, keySelector, descending, comparer);
  }

  /**
   * OrderedEnumerable<TElement> thenBy<TKey>(TKey keySelector(TElement element), [Comparator<<TKey>> comparer]);
   */
  IOrderedEnumerable<TElement> thenBy(dynamic keySelector(TElement element), [Comparator<dynamic> comparer]) {
    // return createOrderedQueryable<TKey>(keySelector, false, comparer);
    return new _ThenByIterator<TElement, dynamic>(this, keySelector, false, comparer);
  }

  /**
   * OrderedEnumerable<TElement> thenByDescending<TKey>(TKey keySelector(TElement element), [Comparator<<TKey>> comparer]);
   */
  IOrderedEnumerable<TElement> thenByDescending(dynamic keySelector(TElement element), [Comparator<dynamic> comparer]) {
    // return createOrderedQueryable<TKey>(keySelector, true, comparer);
    return new _ThenByIterator<TElement, dynamic>(this, keySelector, true, comparer);
  }
}
