part of queries;

abstract class IQueryable<TSource> implements IEnumerable<TSource> {
  Type get elementType;

  // Expression get expression;

  // IQueryProvider get provider;

  /**
   * Returns the accumulated result from all elements by the provided
   * accumulator function.
   *
   * Parameters:
   *  [TSource] func([TSource] result, [TSource] element)
   *  Function that produces the accumulated result based on previously
   *  accumulated result and current value.
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
   * With specified criteria, returns [:true:] if any element matches the
   * specified criteria, otherwise returns [:false:].
   *  OR
   * Without criteria, returns [:true:] if the sequence contains at least one
   * element; otherwise, [:false:].
   *
   * Parameters:
   *  [bool] predicate([TSource] element)
   *  Function that defines criteria and determines whether the specified
   *  element meets this criteria.
   *
   *  Exceptions:
   */
  bool any([bool predicate(TSource element)]);

  /**
   * Returns the [Iterable]<[TSource]> sequence obtained from the current
   * sequence.
   *
   * Parameters:
   *
   * Exceptions:
   */
  Iterable<TSource> asIterable();

  /**
   * Returns the [IQueryable]<[TSource]> sequence obtained from the current
   * sequence.
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
   * Performs type conversion of elements in the specified type and returns
   * the sequence of the specified type.
   *
   * Attention:
   *  Unsupported before the support of generics methods.
   *
   * Parameters:
   *
   * Exceptions:
   *  [TypeError]
   *  Error during the type conversion.
   */
  IQueryable<dynamic> cast();

  /**
   * Returns the result of concatenation of elements of the current and the
   * other sequence.
   *
   * Parameters:
   *  [HasIterator]<[TSource]> other
   *  Sequence for concatenation with the current sequence.
   *
   * Exceptions:
   *  [ArgumentError]
   *  [other] is [:null:]
   */
  IQueryable<TSource> concat(HasIterator<TSource> other);

  /**
   * Returns [:true:] if sequence contains the given value; otherwise, [:false:].
   *
   * Parameters:
   *
   * Exceptions:
   */
  bool contains(TSource value, [IEqualityComparer<TSource> comparer]);

  /**
   * With specified criteria, returns the number of elements that matches a
   * specified criteria.
   *  OR
   * Without criteria, returns the number of elements in seqeunce.
   *
   * Parameters:
   *  [bool] predicate([TSource] element)
   *  Function that defines a set of criteria and determines whether the
   *  specified element meets those criteria.
   *
   * Exceptions:
   */
  int count([bool predicate(TSource element)]);

  /**
   * Returns the default value if sequence is empty.
   *
   * Parameters:
   *  [TSource] defaultValue
   *  Value that specifies the default value.
   *
   * Exceptions:
   */
  IQueryable<TSource> defaultIfEmpty([TSource defaultValue]);

  /**
   * Returns the sequence consisting of the elements of the current sequence
   * without the duplicate elements.
   *
   * Parameters:
   *  [IEqualityComparer]<[TSource]> comparer
   *  Function to support the comparison of elements for equality.
   *
   * Exceptions:
   */
  IQueryable<TSource> distinct([IEqualityComparer<TSource> comparer]);

  /**
   * Returns the element at the specified position.
   *
   * Parameters:
   *  [int] index
   *  Value that specifies the position.
   *
   * Exceptions:
   *  [ArgumentError]
   *  [index] is [:null:]
   *
   *  [RangeError]
   *  [index] out of range
   */
  TSource elementAt(int index);

  /**
   * Returns the element at the specified position.
   *  OR
   * Returns the default value if the index specifies the position out of range.
   *
   * Note:
   *  Default value for nullable types is [:null:].
   *
   * Parameters:
   *  [int] index
   *   Value that specifies the position.
   *
   * Exceptions:
   */
  TSource elementAtOrDefault(int index);

  /**
   * Returns the sequence consisting of the elements of the current sequence
   * except for the elements of the other sequence.
   *
   * Parameters:
   *  [HasIterator]<[TSource]> other
   *  Sequence for exclusion from the current sequence.
   *
   * Exceptions:
   *  [ArgumentError]
   *  [other] is [:null:]
   */
  IQueryable<TSource> except(HasIterator<TSource> other, [IEqualityComparer<TSource> comparer]);

  /**
   * With specified criteria, returns the first element of the sequence that
   * matches the specified criteria.
   *  OR
   * Without criteria returns the first element.
   *
   * Parameters:
   *  [bool] predicate([TSource] element
   *  Function that defines criteria and determines whether the specified
   *  element meets this criteria.
   *
   * Exceptions:
   *  [StateError]
   *  The sequence is empty.
   *    OR
   *  No one element matches specified criteria.
   */
  TSource first([bool predicate(TSource element)]);

  /**
   * With specified criteria, returns the first element of the sequence that
   * matches the specified criteria; otherwise, default value.
   *  OR
   * Without criteria, returns the first element of the sequence; otherwise,
   * default value.
   *
   * Note:
   *  Default value for nullable types is [:null:].
   *
   * Parameters:
   *  [bool] predicate([TSource] element
   *  Function that defines criteria and determines whether the specified
   *  element meets this criteria.
   *
   * Exceptions:
   */
  TSource firstOrDefault([bool predicate(TSource element)]);

  /**
   * Combines the elements into groups of elements according to key and returns
   * the immutable collection of groups with their key and elements.
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
  IQueryable<IGrouping<dynamic, dynamic>> groupBy(dynamic keySelector(TSource element), [dynamic elementSelector(TSource source), IEqualityComparer<dynamic> comparer]);

  /**
   * Combines the elements of the current sequence and the inner sequence
   * according to key and returns the result sequence.
   *
   * Parameters:
   *  [HasIterator]<[TInner]> inner
   *  Inner sequence of elements.
   *
   *  [TKey] outerKeySelector([TSource] outerElement)
   *  Function that obtains a key of the element of the outer sequence.
   *
   *  [TKey] innerKeySelector([TInner] innerElement)
   *  Function that obtains a key of the element of the inner sequence.
   *
   *  [TResult] resultSelector([TSource] outerElement, [TInner] innerElement)
   *  Function to support the transform combination of outer and inner elements
   *  to the certain result.
   *
   *  [IEqualityComparer]<[TSource]> comparer
   *  Function to support the comparison of elements for equality.
   *
   * Exceptions:
   *  [ArgumentError]
   *  [inner] is [:null:]
   *
   *  [ArgumentError]
   *  [outerKeySelector] is [:null:]
   *
   *  [ArgumentError]
   *  [innerKeySelector] is [:null:]
   *
   *  [ArgumentError]
   *  [resultSelector] is [:null:]
   */
  IQueryable<dynamic> groupJoin(HasIterator<dynamic> inner, dynamic outerKeySelector(TSource element), dynamic innerKeySelector(dynamic element), dynamic resultSelector(TSource outerElement, IEnumerable<dynamic> innerElements), [IEqualityComparer<dynamic> comparer]);

  /**
   * Returns distinct values from the current sequence that are not also found
   * in the other sequence.
   *
   * Parameters:
   *  [HasIterator]<[TSource]> other
   *  Sequence for concatenation with the current sequence.
   *
   *  [IEqualityComparer]<[TSource]> comparer
   *  Function to support the comparison of elements for equality.
   *
   *  Exceptions:
   *  [ArgumentError]
   *  [other] is [:null:]
   */
  IQueryable<TSource> intersect(HasIterator<TSource> other, [IEqualityComparer<TSource> comparer]);

  /**
   * Returns the combination of elements of the current (outer) sequence with
   * the inner sequence based on matching keys.
   *
   * Parameters:
   *  [HasIterator]<[TInner]> inner
   *  Inner sequence of elements.
   *
   *  [TKey] outerKeySelector([TSource] outerElement)
   *  Function that obtains a key of the element of the outer sequence.
   *
   *  [TKey] innerKeySelector([TInner] innerElement)
   *  Function that obtains a key of the element of the inner sequence.
   *
   *  [TResult] resultSelector([TSource] outerElement, [TInner] innerElement)
   *  Function to support the transform combination of outer and inner elements
   *  to the certain result.
   *
   *  [IEqualityComparer]<[TSource]> comparer
   *  Function to support the comparison of elements for equality.
   *
   * Exceptions:
   *  [ArgumentError]
   *  [inner] is [:null:]
   *
   *  [ArgumentError]
   *  [outerKeySelector] is [:null:]
   *
   *  [ArgumentError]
   *  [innerKeySelector] is [:null:]
   *
   *  [ArgumentError]
   *  [resultSelector] is [:null:]
   */
  IQueryable<dynamic> join(HasIterator<dynamic> inner, dynamic outerKeySelector(TSource outerElement), dynamic innerKeySelector(dynamic innerElement), dynamic resultSelector(TSource outerElement, dynamic innerElement), [IEqualityComparer<dynamic> comparer]);

  /**
   * With specified criteria, returns the last element of the sequence that
   * matches the specified criteria.
   *  OR
   * Without criteria returns the last element.
   *
   * Parameters:
   *  [bool] predicate([TSource] element
   *  Function that defines criteria and determines whether the specified
   *  element meets this criteria.
   *
   * Exceptions:
   *  [StateError]
   *  The sequence is empty.
   *    OR
   *  No one element matches specified criteria.
   */
  TSource last([bool predicate(TSource element)]);

  /**
   * With specified criteria, returns the last element of the sequence that
   * matches the specified criteria; otherwise, default value.
   *  OR
   * Without criteria, returns the last element of the sequence; otherwise,
   * default value.
   *
   * Note:
   *  Default value for nullable types is [:null:].
   *
   * Parameters:
   *  [bool] predicate([TSource] element
   *  Function that defines criteria and determines whether the specified
   *  element meets this criteria.
   *
   * Exceptions:
   */
  TSource lastOrDefault([bool predicate(TSource element)]);

  /**
   * Returns the maximum value of element in the sequence.
   *
   * Parameters:
   *  [num] selector([TSource] element)
   *  Function to support transform elements.
   *
   * Exceptions:
   *  [StateError]
   *  The sequence is empty.
   */
  num max([num selector(TSource element)]);

  /**
   * Returns the sequence of specified type that consists only from elements of
   * specified type.
   *
   * Attention:
   *  Unsupported before the support of generics methods.
   *
   * Parameters:
   *
   * Exceptions:
   */
  num min([num selector(TSource element)]);

  /**
   * Returns the sequence of specified type that consists only from elements of
   * specified type.
   *
   * Attention:
   *  Unsupported before the support of generics methods.
   *
   * Parameters:
   *
   * Exceptions:
   */
  IQueryable<dynamic> ofType();

  /**
   * Returns the sequence sorted in ascending order according to a key.
   *
   * Parameters:
   *  [TKey] keySelector([TSource] source)
   *  Function that obtains a key of the source element.
   *
   *  [Comparator]<[TSource]> comparer
   *  Function to support the comparison of elements for ordering.
   *
   * Exceptions:
   *  [ArgumentError]
   *  [keySelector] is [:null:]
   */
  IOrderedQueryable<TSource> orderBy(dynamic keySelector(TSource element), [Comparator<dynamic> comparer]);

  /**
   * Returns the sequence sorted in descending order according to a key.
   *
   * Parameters:
   *  [TKey] keySelector([TSource] source)
   *  Function that obtains a key of the source element.
   *
   *  [Comparator]<[TSource]> comparer
   *  Function to support the comparison of elements for ordering.
   *
   * Exceptions:
   *  [ArgumentError]
   *  [keySelector] is [:null:]
   */
  IOrderedQueryable<TSource> orderByDescending(dynamic keySelector(TSource element), [Comparator<dynamic> comparer]);

  /**
   * Applies the transform function to each element and returns the sequence of
   * those transformed elements.
   *
   * Parameters:
   *  [TResult] selector([TSource] element)
   *  Function to support transform elements.
   *
   * Exceptions:
   *  [StateError]
   *  [selector] is [:null:].
   *
   */
  IQueryable<dynamic> select(dynamic selector(TSource element));

  /**
   * Combines the results of transformation, that applied to each element, into
   * the flat sequence of result elements and returns this sequence.
   *
   * Parameters:
   *  [TResult] selector([TSource] element)
   *  Function to support transform elements.
   *
   * Exceptions:
   *  [StateError]
   *  [selector] is [:null:].
   *
   */
  IQueryable<dynamic> selectMany(IEnumerable<dynamic> selector(TSource element));
  /**
   * Compares the elements of the current sequence and the other sequence, and
   * returns [:true:] if all elements equal; otherwise, [:false:].
   *
   * Parameters:
   *  [HasIterator]<[TSource]> other
   *  Sequence for concatenation with the current sequence.
   *
   *  [IEqualityComparer]<[TSource]> comparer
   *  Function to support the comparison of elements for equality.
   *
   *  Exceptions:
   *  [ArgumentError]
   *  [other] is [:null:]
   */
  bool sequenceEqual(HasIterator<TSource> other, [IEqualityComparer<TSource> comparer]);

  /**
   * With specified criteria, returns the single element that matches the
   * specified criteria.
   *  OR
   * Without criteria, returns single element.
   *
   * Parameters:
   *  [bool] predicate([TSource] element
   *  Function that defines criteria and determines whether the specified
   *  element meets this criteria.
   *
   * Exceptions:
   *  [StateError]
   *  The sequence is empty.
   *   OR
   *  With criteria, more than one element matches the specified criteria.
   *   OR
   *  Without criteria, the source sequence contains more than one element.
   */
  TSource single([bool predicate(TSource element)]);

  /**
   * With specified criteria, returns the single element that matches the
   * specified criteria; otherwise, default value.
   *  OR
   * Without criteria, returns single element; otherwise, default value.
   *
   * Note:
   *  Default value for nullable types is [:null:].
   *
   * Parameters:
   *  [bool] predicate([TSource] element)
   *  Function that defines criteria and determines whether the specified
   *  element meets this criteria.
   *
   * Exceptions:
   */
  TSource singleOrDefault([bool predicate(TSource element)]);

  /**
   * Skips the specified number of elements and returns the rest of the
   * sequence.
   *
   * Parameters:
   *  [int] count
   *  The number of elements to skip.
   *
   * Exceptions:
   *  [ArgumentError]
   *  [count] is [:null:]
   */
  IQueryable<TSource> skip(int count);

  /**
   * Skips the elements while the elements matches the specified criteria and
   * returns the rest of the sequence.
   *
   * Parameters:
   *  [bool] predicate([TSource] element)
   *  Function that defines criteria and determines whether the specified
   *  element meets this criteria.
   *
   * Exceptions:
   */
  IQueryable<TSource> skipWhile(bool predicate(TSource element));

  /**
   * Returns the sum of values of each element in sequence.
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
   * Takes the specified maximal number of elements and returns the sequence that
   * consist of these elements.
   *
   * Parameters:
   *  [int] count
   *  Maximal number of returned elements.
   *
   * Exceptions:
   *  [ArgumentError]
   *  [count] is [:null:]
   */
  IQueryable<TSource> take(int count);

  /**
   * Takes the elements while elements matches the specified criteria and
   * returns the sequence that consist of these elements.
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
  IQueryable<TSource> takeWhile(bool predicate(TSource element));

  /**
   * Returns the collection of elements.
   *
   * Parameters:
   *
   * Exceptions:
   */
  ICollection<TSource> toCollection();

  /**
   * Returns the collection of keys where each key mapped to one element.
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
   * Returns the list of elements.
   *
   * Parameters:
   *
   * Exceptions:
   */
  List<dynamic> toList();

  /**
   * Returns the immutable collection of groups where each key of the group
   * mapped to the group of the elements.
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
   * Returns the sequence that consists of the distinct elements from the current
   * and the other sequence.
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
  IQueryable<TSource> union(HasIterator<TSource> other, [IEqualityComparer<TSource> comparer]);

  /**
   * Returns the sequence of elements that matches the specified criteria.
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
  IQueryable<TSource> where(bool predicate(dynamic element));
}

abstract class Queryable<TSource> implements IQueryable<TSource> {
}
