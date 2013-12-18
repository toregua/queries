part of queries;

abstract class IOrderedQueryable<TElement> implements IOrderedEnumerable<TElement>, IQueryable<TElement> {
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