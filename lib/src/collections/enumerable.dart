part of queries.collections;

abstract class IEnumerable<TSource> implements HasIterator<TSource> {
  /**
   * Returns iterator of sequence.
   */
  Iterator<TSource> get iterator;

  /**
   * Accumulates the result produced by the provided function from each element
   * in sequence.
   *
   * Parameters:
   *  [TSource] func([TSource] result, [TSource] element)
   *  Function that produces the cumulative result.
   *
   *  [TSource] seed
   *  Initial result of accumulator.
   *
   * Exceptions:
   *  [ArgumentError]
   *  [func] is [:null:]
   *
   *  [StateError]
   *  The sequence is empty.
   */
  TSource aggregate(TSource func(TSource accumulator, TSource element), [TSource seed]);

  /**
   * Returns [:true:] if all elements matches the specified criteria, or if the
   * sequence is empty; otherwise, [:false:].
   *
   * Parameters:
   *  [bool] predicate([TSource] element
   *  Function that defines criteria and determines whether the specified
   *  element meets this criteria.
   *
   * Exceptions:
   *  [ArgumentError]
   *  [predicate] is [:null:]
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
   *  Function that defines criteria and determines whether the specified
   *  element meets this criteria.
   */
  bool any([bool predicate(TSource element)]);

  /**
   * Returns [Iterable] sequence obtained from the current sequence.
   *
   * Parameters:
   *
   * Exceptions:
   */
  Iterable<TSource> asIterable();

  /**
   * Returns [IQueryable] sequence obtained from the current sequence.
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
   *  [num] selector([TSource] element)
   *  Function to support transform elements.
   *
   * Exceptions:
   *  [StateError]
   *  The sequence is empty.
   */
  num average([num selector(TSource element)]);

  /**
   * Cast all elements in sequence into sequence of the specified type.
   *
   * Attention:
   *   Unsupported before the support of generics methods.
   *
   * Parameters:
   *
   * Exceptions:
   *  [TypeError]
   *  Cannot cast to the specified type at least one of the elements.
   */
  IEnumerable<dynamic> cast();

  IEnumerable<TSource> concat(HasIterator<TSource> other);

  bool contains(TSource value, [IEqualityComparer<TSource> comparer]);

  /**
   * Returns the number of elements that matches a specified criteria.
   *
   * Parameters:
   *  [bool] predicate([TSource] element)
   *  Function that defines a set of criteria and determines whether the
   *  specified element meets those criteria.
   */
  int count([bool predicate(TSource element)]);

  IEnumerable<TSource> defaultIfEmpty([TSource defaultValue]);

  IEnumerable<TSource> distinct([IEqualityComparer<TSource> comparer]);

  TSource elementAt(int index);

  TSource elementAtOrDefault(int index);

  IEnumerable<TSource> except(HasIterator<TSource> other, [IEqualityComparer<TSource> comparer]);

  TSource first([bool predicate(TSource element)]);

  TSource firstOrDefault([bool predicate(TSource element)]);

  IEnumerable<IGrouping<dynamic, dynamic>> groupBy(dynamic keySelector(TSource element), [dynamic elementSelector(TSource source), IEqualityComparer<dynamic> comparer]);

  IEnumerable<dynamic> groupJoin(HasIterator<dynamic> inner, dynamic outerKeySelector(TSource element), dynamic innerKeySelector(dynamic element), dynamic resultSelector(TSource outerElement, IEnumerable<dynamic> innerElements), [IEqualityComparer<dynamic> comparer]);

  IEnumerable<TSource> intersect(HasIterator<TSource> other, [IEqualityComparer<TSource> comparer]);

  IEnumerable<dynamic> join(HasIterator<dynamic> inner, dynamic outerKeySelector(TSource outerElement), dynamic innerKeySelector(dynamic innerElement), dynamic resultSelector(TSource outerElement, dynamic innerElement), [IEqualityComparer<dynamic> comparer]);

  TSource last([bool predicate(TSource element)]);

  TSource lastOrDefault([bool predicate(TSource element)]);

  num max([num selector(TSource element)]);

  num min([num selector(TSource element)]);

  IEnumerable<dynamic> ofType();

  IOrderedEnumerable<TSource> orderBy(dynamic keySelector(TSource element), [Comparator<dynamic> comparer]);

  IOrderedEnumerable<TSource> orderByDescending(dynamic keySelector(TSource element), [Comparator<dynamic> comparer]);

  IEnumerable<dynamic> select(dynamic selector(TSource element));

  IEnumerable<dynamic> selectMany(IEnumerable<dynamic> selector(TSource element));

  bool sequenceEqual(HasIterator<TSource> other, [IEqualityComparer<TSource> comparer]);

  TSource single([bool predicate(TSource element)]);

  TSource singleOrDefault([bool predicate(TSource element)]);

  IEnumerable<TSource> skip(int count);

  IEnumerable<TSource> skipWhile(bool predicate(TSource element));

  /**
   * Returns the sum of values of each element.
   *
   * Parameters:
   *  [num] selector([TSource] element)
   *  Function to support transform elements.
   *
   * Exceptions:
   *  [ArgumentError]
   *  [selector] is [:null:]
   */
  num sum([num selector(TSource element)]);

  /**
   * Returns sequence of elements until count not reaches zero value.
   *
   * Parameters:
   *  [int] count
   *  Limit of the number of returned elements.
   *
   * Exceptions:
   *  [ArgumentError]
   *  [count] is [:null:]
   */
  IEnumerable<TSource> take(int count);

  /**
   * Returns sequence of elements until the elements matches the specified
   * criteria.
   *
   * Parameters:
   *  [bool] predicate([TSource] element)
   *  Function that defines criteria and determines whether the specified
   *  element meets this criteria.
   *
   * Exceptions:
   *  [ArgumentError]
   *  [predicate] is [:null:]
   */
  IEnumerable<TSource> takeWhile(bool predicate(TSource element));

  /**
   * Returns collection of elements.
   *
   * Parameters:
   *
   * Exceptions:
   */
  ICollection<TSource> toCollection();

  /**
   * Returns collection of keys where each key mapped to one element.
   *
   * Parameters:
   *  [TKey] keySelector([TSource] source)
   *  Function that obtains a key of the source element.
   *
   *  [TElement] elementSelector([TSource] source)
   *  Function to support the transform [TSource] element to [TElement] element.
   *
   *  [IEqualityComparer]<[TSource]> comparer
   *  Function to support the comparison of elements for equality.
   *
   * Exceptions:
   *  [ArgumentError]
   *  [keySelector] is [:null:]
   */
  IDictionary<dynamic, dynamic> toDictionary(dynamic keySelector(TSource source), [dynamic elementSelector(TSource source), IEqualityComparer<dynamic> comparer]);

  /**
   * Returns a list of elements which have been obtained from the sequence.
   *
   * Parameters:
   *
   * Exceptions:
   */
  List<dynamic> toList();

  /**
   * Returns immutable collection of keys where each key mapped to one or more
   * elements.
   *
   * Parameters:
   *  [TKey] keySelector([TSource] source)
   *  Function that obtains a key of the source element.
   *
   *  [TElement] elementSelector([TSource] source)
   *  Function to support the transform [TSource] element to [TElement] element.
   *
   *  [IEqualityComparer]<[TSource]> comparer
   *  Function to support the comparison of elements for equality.
   *
   * Exceptions:
   *  [ArgumentError]
   *  [keySelector] is [:null:]
   */
  ILookup<dynamic, dynamic> toLookup(dynamic keySelector(TSource source), [dynamic elementSelector(TSource source), IEqualityComparer<dynamic> comparer]);

  /**
   * Returns sequence that consists of the distinct elements from the current
   * and the provided sequence.
   *
   * Parameters:
   *  [HasIterator]<[TSource]> other
   *  Sequence for combination with the current elements.
   *
   *  [IEqualityComparer]<[TSource]> comparer
   *  Function to support the comparison of elements for equality.
   *
   * Exceptions:
   *  [ArgumentError]
   *  [other] is [:null:]
   */
  IEnumerable<TSource> union(HasIterator<TSource> other, [IEqualityComparer<TSource> comparer]);

  /**
   * Returns sequence of elements that matches the specified criteria.
   *
   * Parameters:
   *  [bool] predicate([TSource] element)
   *  Function that defines criteria and determines whether the specified
   *  element meets this criteria.
   *
   * Exceptions:
   *  [ArgumentError]
   *  [predicate] is [:null:]
   */
  IEnumerable<TSource> where(bool predicate(dynamic element));
}
