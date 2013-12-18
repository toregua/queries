part of queries.collections;

abstract class IEnumerable<TSource> implements HasIterator<TSource> {
  Iterator<TSource> get iterator;

  TSource aggregate(TSource func(TSource result, TSource element), [TSource seed]);

  bool all(bool predicate(TSource element));

  bool any([bool predicate(TSource element)]);

  Iterable<TSource> asIterable();

  IQueryable<TSource> asQueryable();

  num average([num selector(TSource element)]);

  /**
   * IEnumerable<TResult> cast<TResult>()
   */
  IEnumerable<dynamic> cast();

  IEnumerable<TSource> concat(HasIterator<TSource> other);

  bool contains(TSource value, [IEqualityComparer<TSource> comparer]);

  int count([bool predicate(TSource element)]);

  IEnumerable<TSource> defaultIfEmpty([TSource defaultValue]);

  IEnumerable<TSource> distinct([IEqualityComparer<TSource> comparer]);

  TSource elementAt(int index);

  TSource elementAtOrDefault(int index);

  IEnumerable<TSource> except(HasIterator<TSource> other, [IEqualityComparer<TSource> comparer]);

  TSource first([bool predicate(TSource element)]);

  TSource firstOrDefault([bool predicate(TSource element)]);

  /**
   * IEnumerable<Grouping<TKey, TElement>> groupBy<TKey, TElement>(TKey keySelector(TSource element), [TElement elementSelector(TSource source), EqualityComparer<TKey> comparer])
   */
  IEnumerable<IGrouping<dynamic, dynamic>> groupBy(dynamic keySelector(TSource element), [dynamic elementSelector(TSource source), IEqualityComparer<dynamic> comparer]);

  /**
   * IEnumerable<TResult> groupJoin<TInner, TKey, TResult>(HasIterator<TInner> inner, TKey outerKeySelector(TSource outerElement), TKey innerKeySelector(TInner innerElement), TResult resultSelector(TSource outerElement, IEnumerable<TInner> innerElements), [EqualityComparer<TKey> comparer])
   */
  IEnumerable<dynamic> groupJoin(HasIterator<dynamic> inner, dynamic outerKeySelector(TSource element), dynamic innerKeySelector(dynamic element), dynamic resultSelector(TSource outerElement, IEnumerable<dynamic> innerElements), [IEqualityComparer<dynamic> comparer]);

  IEnumerable<TSource> intersect(HasIterator<TSource> other, [IEqualityComparer<TSource> comparer]);

  /**
   * IEnumerable<TResult> join<TInner, TKey, TResult>(HasIterator<TInner> inner, TKey outerKeySelector(TSource outerElement), TKey innerKeySelector(TInner innerElement), TResult resultSelector(TSource outerElement, TInner innerElement), [EqualityComparer<TKey> comparer])
   */
  IEnumerable<dynamic> join(HasIterator<dynamic> inner, dynamic outerKeySelector(TSource outerElement), dynamic innerKeySelector(dynamic innerElement), dynamic resultSelector(TSource outerElement, dynamic innerElement), [IEqualityComparer<dynamic> comparer]);

  TSource last([bool predicate(TSource element)]);

  TSource lastOrDefault([bool predicate(TSource element)]);

  num max([num selector(TSource element)]);

  num min([num selector(TSource element)]);

  /**
   * IEnumerable<TResult> ofType<TResult>()
   */
  IEnumerable<dynamic> ofType();

  /**
   * IOrderedEnumerable<TSource> orderBy<TKey>(TKey keySelector(TSource element), [Comparator<TKey> comparer])
   */
  IOrderedEnumerable<TSource> orderBy(dynamic keySelector(TSource element), [Comparator<dynamic> comparer]);

  /**
   * IOrderedEnumerable<TSource> orderByDescending<TKey>(TKey keySelector(TSource element), [Comparator<TKey> comparer])
   */
  IOrderedEnumerable<TSource> orderByDescending(dynamic keySelector(TSource element), [Comparator<dynamic> comparer]);

  /**
   * IEnumerable<TResult> select<TResult>(TResult selector(TSource element))
   */
  IEnumerable<dynamic> select(dynamic selector(TSource element));

  /**
   * IEnumerable<TResult> selectMany<TResult>(IEnumerable<TResult> selector(TSource source))
   */
  IEnumerable<dynamic> selectMany(IEnumerable<dynamic> selector(TSource element));

  bool sequenceEqual(HasIterator<TSource> other, [IEqualityComparer<TSource> comparer]);

  TSource single([bool predicate(TSource element)]);

  TSource singleOrDefault([bool predicate(TSource element)]);

  IEnumerable<TSource> skip(int count);

  IEnumerable<TSource> skipWhile(bool predicate(TSource element));

  num sum([num selector(TSource element)]);

  IEnumerable<TSource> take(int count);

  IEnumerable<TSource> takeWhile(bool predicate(TSource element));

  ICollection<TSource> toCollection();

  /**
   * Dictionary<TKey, TElement> toDictionary(TKey keySelector(TSource source), [TElement elementSelector(TSource source), EqualityComparer<TKey> comparer])
   */
  IDictionary<dynamic, dynamic> toDictionary(dynamic keySelector(TSource source), [dynamic elementSelector(TSource source), IEqualityComparer<dynamic> comparer]);

  List<dynamic> toList();

  /**
   * Lookup<TKey, TElement> toLookup(TKey keySelector(TSource source), [TElement elementSelector(TSource source), EqualityComparer<TKey> comparer])
   */
  ILookup<dynamic, dynamic> toLookup(dynamic keySelector(TSource source), [dynamic elementSelector(TSource source), IEqualityComparer<dynamic> comparer]);

  IEnumerable<TSource> union(HasIterator<TSource> other, [IEqualityComparer<TSource> comparer]);

  IEnumerable<TSource> where(bool predicate(dynamic element));
}
