part of queries;

abstract class IQueryable<TSource> implements IEnumerable<TSource> {
  Type get elementType;

  Expression get expression;

  IQueryProvider get provider;

  /**
   * Accumulates the result produced by the provided function over all elements
   * in sequence.
   *
   * Parameters:
   *  [TSource] func([TSource] result, [TSource] element)
   *    Function that produces the cumulative result.
   *  [TSource] seed
   *    Initial result of accumulator.
   *
   * Exceptions:
   *  [ArgumentError]
   *    [func] is [:null:]
   *
   *  [StateError]
   *    The source sequence is empty.
   */
  TSource aggregate(TSource func(TSource accumulator, TSource element), [TSource seed]);

  /**
   * Returns [:true:] if all elements matches the specified criteria, or if the
   * sequence is empty; otherwise, [:false:].
   *
   * Parameters:
   *  [bool] predicate([TSource] element):
   *    Function that defines criteria and determines whether the specified
   *    element meets this criteria.
   *
   * Exceptions:
   *  [ArgumentError]
   *    [predicate] is [:null:]
   */
  bool all(bool predicate(TSource element));

  /**
   * Returns [:true:] if any element matches the specified criteria,
   * otherwise returns [:false:].
   * If the criteria is not specified, returns [:true:] if the sequence contains
   * at least one element; otherwise, [:false:].
   *
   * Parameters:
   *  [bool] predicate([TSource] element)
   *    Function that defines criteria and determines whether the specified
   *    element meets this criteria.
   */
  bool any([bool predicate(TSource element)]);

  /**
   * Returns [Iterable] sequence converted from the current sequence.
   *
   * Parameters:
   *
   * Exceptions:
   */
  Iterable<TSource> asIterable();

  /**
   * Returns [IQueryable] sequence converted from the current sequence.
   *
   * Parameters:
   *
   * Exceptions:
   */
  IQueryable<TSource> asQueryable();

  /**
   * Returns the sum of values of each element divided by the size of the
   * sequence.
   *
   * Parameters:
   *  num selector(TSource element)
   *   Function to support transform elements.
   *
   * Exceptions:
   *  [StateError]
   *    The sequence is empty.
   */
  num average([num selector(TSource element)]);

  /**
   * Cast all elements in sequence to the specified type.
   * **Unsupported before the advent of generics methods.**
   *
   * Parameters:
   *
   * Exceptions:
   *   [TypeError]
   *     Cannot cast to the specified type at least one of the elements.
   */
  IQueryable<dynamic> cast();

  IQueryable<TSource> concat(HasIterator<TSource> other);

  bool contains(TSource value, [IEqualityComparer<TSource> comparer]);

  int count([bool predicate(TSource element)]);

  IQueryable<TSource> defaultIfEmpty([TSource defaultValue]);

  IQueryable<TSource> distinct([IEqualityComparer<TSource> comparer]);

  TSource elementAt(int index);

  TSource elementAtOrDefault(int index);

  IQueryable<TSource> except(HasIterator<TSource> other, [IEqualityComparer<TSource> comparer]);

  TSource first([bool predicate(TSource element)]);

  TSource firstOrDefault([bool predicate(TSource element)]);

  /**
   * IQueryable<Grouping<TKey, TElement>> groupBy<TKey, TElement>(TKey keySelector(TSource element), [TElement elementSelector(TSource source), EqualityComparer<TKey> comparer])
   */
  IQueryable<IGrouping<dynamic, dynamic>> groupBy(dynamic keySelector(TSource element), [dynamic elementSelector(TSource source), IEqualityComparer<dynamic> comparer]);

  /**
   * IQueryable<TResult> groupJoin<TInner, TKey, TResult>(HasIterator<TInner> inner, TKey outerKeySelector(TSource outerElement), TKey innerKeySelector(TInner innerElement), TResult resultSelector(TSource outerElement, IEnumerable<TInner> innerElements), [EqualityComparer<TKey> comparer])
   */
  IQueryable<dynamic> groupJoin(HasIterator<dynamic> inner, dynamic outerKeySelector(TSource element), dynamic innerKeySelector(dynamic element), dynamic resultSelector(TSource outerElement, IEnumerable<dynamic> innerElements), [IEqualityComparer<dynamic> comparer]);

  IQueryable<TSource> intersect(HasIterator<TSource> other, [IEqualityComparer<TSource> comparer]);

  /**
   * IQueryable<TResult> join<TInner, TKey, TResult>(HasIterator<TInner> inner, TKey outerKeySelector(TSource outerElement), TKey innerKeySelector(TInner innerElement), TResult resultSelector(TSource outerElement, TInner innerElement), [EqualityComparer<TKey> comparer])
   */
  IQueryable<dynamic> join(HasIterator<dynamic> inner, dynamic outerKeySelector(TSource outerElement), dynamic innerKeySelector(dynamic innerElement), dynamic resultSelector(TSource outerElement, dynamic innerElement), [IEqualityComparer<dynamic> comparer]);

  TSource last([bool predicate(TSource element)]);

  TSource lastOrDefault([bool predicate(TSource element)]);

  num max([num selector(TSource element)]);

  num min([num selector(TSource element)]);

  /**
   * IQueryable<TResult> ofType<TResult>()
   */
  IQueryable<dynamic> ofType();

  /**
   * IOrderedQueryable<TSource> orderBy<TKey>(TKey keySelector(TSource element), [Comparator<TKey> comparer])
   */
  IOrderedQueryable<TSource> orderBy(dynamic keySelector(TSource element), [Comparator<dynamic> comparer]);

  /**
   * IOrderedQueryable<TSource> orderByDescending<TKey>(TKey keySelector(TSource element), [Comparator<TKey> comparer])
   */
  IOrderedQueryable<TSource> orderByDescending(dynamic keySelector(TSource element), [Comparator<dynamic> comparer]);

  /**
   * IQueryable<TResult> select<TResult>(TResult selector(TSource element))
   */
  IQueryable<dynamic> select(dynamic selector(TSource element));

  /**
   * IQueryable<TResult> selectMany<TResult>(IQueryable<TResult> selector(TSource source))
   */
  IQueryable<dynamic> selectMany(IQueryable<dynamic> selector(TSource element));

  bool sequenceEqual(HasIterator<TSource> other, [IEqualityComparer<TSource> comparer]);

  TSource single([bool predicate(TSource element)]);

  TSource singleOrDefault([bool predicate(TSource element)]);

  IQueryable<TSource> skip(int count);

  IQueryable<TSource> skipWhile(bool predicate(TSource element));

  num sum([num selector(TSource element)]);

  IQueryable<TSource> take(int count);

  IQueryable<TSource> takeWhile(bool predicate(TSource element));

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

  IQueryable<TSource> union(HasIterator<TSource> other, [IEqualityComparer<TSource> comparer]);

  IQueryable<TSource> where(bool predicate(dynamic element));
}

abstract class Queryable<TSource> implements IQueryable<TSource> {
}
