part of queries;

abstract class Enumerable<TSource> implements IEnumerable<TSource> {
  static Enumerable<dynamic> range(int start, int count) {
    return new _RangeIterator<dynamic>(start, count);
  }

  static Enumerable<dynamic> repeat(dynamic element, int count) {
    return new _RepeatIterator<dynamic>(element, count);
  }

  /**
   * Returns the accumulated result from all elements by provided accumulator
   * function.
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
  TSource aggregate(TSource func(TSource accumulator, TSource element), [TSource seed]) {
    if(func == null) {
      throw new ArgumentError("func: $func");
    }

    TSource result = seed;
    var iterator = this.iterator;
    if(!iterator.moveNext()) {
      if(result == null) {
        throw new StateError("The source sequence is empty");
      }
    } else {
      if(result == null) {
        result = iterator.current;
      } else {
        result = func(result, iterator.current);
      }
    }

    while(iterator.moveNext()) {
      result = func(result, iterator.current);
    }

    return result;
  }

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
  bool all(bool predicate(TSource element)) {
    if(predicate == null) {
      throw new ArgumentError("predicate: $predicate");
    }

    var iterator = this.iterator;
    while(iterator.moveNext()) {
      if(!predicate(iterator.current)) {
        return false;
      }
    }

    return true;
  }

  /**
   * With specified criteria returns [:true:] if any element matches the
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
  bool any([bool predicate(TSource element)]) {
    var iterator = this.iterator;
    if(predicate == null) {
      if(iterator.moveNext()) {
        return true;
      } else {
        return false;
      }
    }

    while(iterator.moveNext()) {
      if(predicate(iterator.current)) {
        return true;
      }
    }

    return false;
  }

  /**
   * Returns the [Iterable] sequence obtained from the current sequence.
   *
   * Parameters:
   *
   * Exceptions:
   */
  Iterable<TSource> asIterable() {
    return new _Iterable<TSource>(iterator);
  }

  /**
   * Returns the [IQueryable] sequence obtained from the current sequence.
   *
   * Parameters:
   *
   * Exceptions:
   */
  IQueryable<TSource> asQueryable() {
    throw new UnimplementedError("asQueryable()");
  }

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
  num average([num selector(TSource element)]) {
    var count = 1;
    num sum;
    var iterator = this.iterator;
    if(selector == null) {
      if(!iterator.moveNext()) {
        throw new StateError("The source sequence is empty");
      } else {
        sum = iterator.current;
      }

      while(iterator.moveNext()) {
        count++;
        sum += iterator.current;
      }
    } else {
      if(!iterator.moveNext()) {
        throw new StateError("The source sequence is empty");
      } else {
        sum = selector(iterator.current);
      }

      while(iterator.moveNext()) {
        count++;
        sum += selector(iterator.current);
      }
    }

    return sum / count;
  }

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
  IEnumerable<dynamic> cast() {
    return new _CastIterator<dynamic>(this);
  }

  /**
   * Returns the result of concatenation of elements of the current and the
   * given sequence.
   *
   * Parameters:
   *  [HasIterator]<[TSource]> other
   *  Sequence for concatenation with the current sequence.
   *
   * Exceptions:
   *  [ArgumentError]
   *  [other] is [:null:]
   */
  IEnumerable<TSource> concat(HasIterator<TSource> other) {
    return new _ConcatIterator<TSource>(this, other);
  }

  /**
   * Returns [:true:] if sequence contains the given value;
   * otherwise, [:false:].
   *
   * Parameters:
   *
   * Exceptions:
   */
  bool contains(TSource value, [IEqualityComparer<TSource> comparer]) {
    if(comparer == null) {
      comparer = new EqualityComparer<TSource>();
    }

    var iterator = this.iterator;
    while(iterator.moveNext()) {
      if(comparer.equals(value, iterator.current)) {
        return true;
      }
    }

    return false;
  }

  /**
   * With specified criteria returns the number of elements that matches a
   * specified criteria.
   *  OR
   * Without criteria returns the number of elements in seqeunce.
   *
   * Parameters:
   *  [bool] predicate([TSource] element)
   *  Function that defines a set of criteria and determines whether the
   *  specified element meets those criteria.
   *
   * Exceptions:
   */
  int count([bool predicate(TSource element)]) {
    var count = 0;
    var iterator = this.iterator;
    if(predicate == null) {
      while(iterator.moveNext()) {
        count++;
      }
    } else {
      while(iterator.moveNext()) {
        if(predicate(iterator.current)) {
          count++;
        }
      }
    }

    return count;
  }

  /**
   * Returns the default value if sequence is empty.
   *
   * Parameters:
   *  [TSource] defaultValue
   *  Value that specifies the default value.
   *
   * Exceptions:
   */
  IEnumerable<TSource> defaultIfEmpty([TSource defaultValue]) {
    return new _DefaultIfEmptyIterator<TSource>(this, defaultValue);
  }

  /**
   * Returns the current sequence without the duplicate elements.
   *
   * Parameters:
   *  [IEqualityComparer]<[TSource]> comparer
   *  Function to support the comparison of elements for equality.
   *
   * Exceptions:
   */
  IEnumerable<TSource> distinct([IEqualityComparer<TSource> comparer]) {
    return new _DistinctIterator<TSource>(this, comparer);
  }

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
  TSource elementAt(int index) {
    if(index == null || index < 0) {
      throw new RangeError("index: $index");
    }

    if(this is IList<TSource>) {
      var list = this as IList<TSource>;
      return list[index];
    }

    var counter = 0;
    var iterator = this.iterator;
    while(iterator.moveNext()) {
      if(counter++ == index) {
        return iterator.current;
      }
    }

    throw new RangeError.range(index, 0, counter - 1);
  }

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
  TSource elementAtOrDefault(int index) {
    TSource result;
    if(index == null || index < 0) {
      return result;
    }

    if(this is IList<TSource>) {
      var list = this as IList<TSource>;
      if(index + 1 > list.length) {
        return result;
      }

      return list[index];
    }

    var counter = 0;
    var iterator = this.iterator;
    while(iterator.moveNext()) {
      if(counter++ == index) {
        return iterator.current;
      }
    }

    return result;
  }

  /**
   * Returns the sequence consisting of the elements of the current sequence
   * except for the elements of the given sequence.
   *
   * Parameters:
   *  [HasIterator]<[TSource]> other
   *  Sequence for exclusion from the current sequence.
   *
   * Exceptions:
   *  [ArgumentError]
   *  [other] is [:null:]
   */
  IEnumerable<TSource> except(HasIterator<TSource> other, [IEqualityComparer<TSource> comparer]) {
    return new _ExceptIterator<TSource>(this, other, comparer);
  }

  /**
   * With specified criteria returns the first element of the sequence that
   * matches the specified criteria.
   *  OR
   * Without criteria, returns the first element of the sequence.
   *
   * Parameters:
   *  [bool] predicate([TSource] element
   *  Function that defines criteria and determines whether the specified
   *  element meets this criteria.
   *
   * Exceptions:
   *  [StateError]
   *  The sequence is empty or no one element matches specified criteria.
   */
  TSource first([bool predicate(TSource element)]) {
    var iterator = this.iterator;
    if(predicate == null) {
      if(iterator.moveNext()) {
        return iterator.current;
      }

    } else {
      while(iterator.moveNext()) {
        var current = iterator.current;
        if(predicate(current)) {
          return current;
        }
      }
    }

    throw new StateError("The source sequence is empty");
  }

  /**
   * With specified criteria returns the first element of the sequence that
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
  TSource firstOrDefault([bool predicate(TSource element)]) {
    var iterator = this.iterator;
    TSource result;
    if(predicate == null) {
      if(iterator.moveNext()) {
        return iterator.current;
      }

    } else {
      while(iterator.moveNext()) {
        var current = iterator.current;
        if(predicate(current)) {
          return current;
        }
      }
    }

    return result;
  }

  /**
   * Returns an immutable collection of groups of elements with their keys,
   * where each key mapped on a collection of elements.
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
  IEnumerable<IGrouping<dynamic, dynamic>> groupBy(dynamic keySelector(TSource element), [dynamic elementSelector(TSource source), IEqualityComparer<dynamic> comparer]) {
    return new _GroupByIterator<TSource, dynamic, dynamic>(this, keySelector, elementSelector, comparer);
  }

  IEnumerable<dynamic> groupJoin(HasIterator<dynamic> inner, dynamic outerKeySelector(TSource outerElement), dynamic innerKeySelector(dynamic innerElement), dynamic resultSelector(TSource outerElement, IEnumerable<dynamic> innerElements), [IEqualityComparer<dynamic> comparer]) {
    return new _GroupJoinIterator<TSource, dynamic, dynamic, dynamic>(this, inner, outerKeySelector, innerKeySelector, resultSelector, comparer);
  }

  IEnumerable<TSource> intersect(HasIterator<TSource> other, [IEqualityComparer<TSource> comparer]) {
    return new _IntersectIterator<TSource>(this, other, comparer);
  }

  /**
   * Returns the combination of elements of the current (outer) sequence with
   * the given (inner) sequence based on matching keys.
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
   *  Exceptions:
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
  IEnumerable<dynamic> join(HasIterator<dynamic> inner, dynamic outerKeySelector(TSource outer), dynamic innerKeySelector(dynamic inner), dynamic resultSelector(TSource outer, dynamic inner), [IEqualityComparer<dynamic> comparer]) {
    return new _JoinIterator<TSource, dynamic, dynamic, dynamic>(this, inner, outerKeySelector, innerKeySelector, resultSelector, comparer);
  }

  TSource last([bool predicate(TSource element)]) {
    var iterator = this.iterator;
    var length = 0;
    TSource result;
    if(predicate == null) {
      while(iterator.moveNext()) {
        length++;
        result = iterator.current;
      }

    } else {
      while(iterator.moveNext()) {
        var current = iterator.current;
        if(predicate(current)) {
          length++;
          result = current;
        }
      }
    }

    if(length == 0) {
      throw new StateError("The source sequence is empty");
    }

    return result;
  }

  TSource lastOrDefault([bool predicate(TSource element)]) {
    var iterator = this.iterator;
    TSource result;
    if(predicate == null) {
      while(iterator.moveNext()) {
        result = iterator.current;
      }

    } else {
      while(iterator.moveNext()) {
        var current = iterator.current;
        if(predicate(current)) {
          result = current;
        }
      }
    }

    return result;
  }

  num max([num selector(TSource element)]) {
    num min;
    var iterator = this.iterator;
    if(selector == null) {
      if(!iterator.moveNext()) {
        return min;
      } else {
        min = iterator.current;
      }

      while(iterator.moveNext()) {
        num value = iterator.current;
        if(value != null && value > min) {
          min = value;
        }
      }
    } else {
      if(!iterator.moveNext()) {
        return min;
      } else {
        min = selector(iterator.current);
      }

      while(iterator.moveNext()) {
        num value = selector(iterator.current);
        if(value != null && value > min) {
          min = value;
        }
      }
    }

    return min;
  }

  num min([num selector(TSource element)]) {
    num min;
    var iterator = this.iterator;
    if(selector == null) {
      if(!iterator.moveNext()) {
        return min;
      } else {
        min = iterator.current;
      }

      while(iterator.moveNext()) {
        num value = iterator.current;
        if(value != null && value < min) {
          min = value;
        }
      }
    } else {
      if(!iterator.moveNext()) {
        return min;
      } else {
        min = selector(iterator.current);
      }

      while(iterator.moveNext()) {
        num value = selector(iterator.current);
        if(value != null && value < min) {
          min = value;
        }
      }
    }

    return min;
  }

  IEnumerable<dynamic> ofType() {
    return new _OfTypeIterator<dynamic>(this);
  }

  IOrderedEnumerable<TSource> orderBy(dynamic keySelector(TSource source), [Comparator<dynamic> comparer]) {
    return new _OrderByIterator<TSource, dynamic>(this, keySelector, false, comparer);
  }

  IOrderedEnumerable<TSource> orderByDescending(dynamic keySelector(TSource source), [Comparator<dynamic> comparer]) {
    return new _OrderByIterator<TSource, dynamic>(this, keySelector, true, comparer);
  }

  IEnumerable<dynamic> select(dynamic selector(TSource element)) {
    return new _SelectIterator<TSource, dynamic>(this, selector);
  }

  IEnumerable<dynamic> selectMany(IEnumerable<dynamic> selector(TSource source)) {
    return new _SelectManyIterator<TSource, dynamic>(this, selector);
  }

  bool sequenceEqual(HasIterator<TSource> other, [IEqualityComparer<TSource> comparer]) {
    Iterator<TSource> iterator1 = this.iterator;
    Iterator<TSource> iterator2 = other.iterator;
    if(comparer == null) {
      comparer = new EqualityComparer<TSource>();
    }

    while(iterator1.moveNext()) {
      if(!iterator2.moveNext()) {
        return false;
      }

      if(!comparer.equals(iterator1.current, iterator2.current)) {
        return false;
      }
    }

    return true;
  }

  TSource single([bool predicate(TSource element)]) {
    var iterator = this.iterator;
    var length = 0;
    TSource result;
    if(predicate == null) {
      while(iterator.moveNext()) {
        result = iterator.current;
        if(length > 0) {
          throw new StateError("The source sequence contains more than one element");
        } else {
          length++;
        }
      }

    } else {
      while(iterator.moveNext()) {
        var current = iterator.current;
        if(predicate(current)) {
          if(length > 0) {
            throw new StateError("The source sequence contains more than one element");
          } else {
            result = current;
            length++;
          }
        }
      }
    }

    if(length == 0) {
      throw new StateError("The source sequence is empty");
    }

    return result;
  }

  TSource singleOrDefault([bool predicate(TSource element)]) {
    var iterator = this.iterator;
    var length = 0;
    TSource result;
    if(predicate == null) {
      while(iterator.moveNext()) {
        result = iterator.current;
        if(length > 0) {
          throw new StateError("The source sequence contains more than one element");
        } else {
          length++;
        }
      }

    } else {
      while(iterator.moveNext()) {
        var current = iterator.current;
        if(predicate(current)) {
          if(length > 0) {
            throw new StateError("The source sequence contains more than one element");
          } else {
            result = current;
            length++;
          }
        }
      }
    }

    return result;
  }

  IEnumerable<TSource> skip(int count) {
    return new _SkipIterator<TSource>(this, count);
  }

  IEnumerable<TSource> skipWhile(bool predicate(TSource element)) {
    return new _SkipWhileIterator<TSource>(this, predicate);
  }

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
  num sum([num selector(TSource element)]) {
    num sum;
    var iterator = this.iterator;
    if(selector == null) {
      if(!iterator.moveNext()) {
        return sum;
      } else {
        sum = iterator.current;
      }

      while(iterator.moveNext()) {
        sum += iterator.current;
      }
    } else {
      if(!iterator.moveNext()) {
        return sum;
      } else {
        sum = selector(iterator.current);
      }

      while(iterator.moveNext()) {
        sum += selector(iterator.current);
      }
    }

    return sum;
  }

  /**
   * Returns the sequence of elements until count not reaches zero value.
   *
   * Parameters:
   *  [int] count
   *  Limit of the number of returned elements.
   *
   * Exceptions:
   *  [ArgumentError]
   *  [count] is [:null:]
   */
  IEnumerable<TSource> take(int count) {
    return new _TakeIterator<TSource>(this, count);
  }

  /**
   * Returns the sequence of elements until the elements matches the specified
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
  IEnumerable<TSource> takeWhile(bool predicate(TSource element)) {
    return new _TakeWhileIterator<TSource>(this, predicate);
  }

  /**
   * Returns the collection of elements.
   *
   * Parameters:
   *
   * Exceptions:
   */
  Collection<TSource> toCollection() {
    return new Collection(this.toList());
  }

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
  Dictionary<dynamic, dynamic> toDictionary(dynamic keySelector(TSource source), [dynamic elementSelector(TSource source), IEqualityComparer<dynamic> comparer]) {
    if(keySelector == null) {
      throw new ArgumentError("keySelector: $keySelector");
    }

    if(comparer == null) {
      comparer = new EqualityComparer<dynamic>();
    }

    var dictionary = new Dictionary<dynamic, dynamic>(comparer);
    for(var grouping in groupBy(keySelector, elementSelector, comparer)) {
      dictionary[grouping.key] = grouping.lastOrDefault();
    }

    return dictionary;
  }

  /**
   * Returns the list of elements.
   *
   * Parameters:
   *
   * Exceptions:
   */
  List<TSource> toList({bool growable : true}) {
    var iterator = this.iterator;
    var list = <TSource>[];
    while(iterator.moveNext()) {
      list.add(iterator.current);
    }

    if(growable) {
      return list;
    }

    var length = list.length;
    var fixedList = new List<TSource>(length);
    for(var i = 0; i < length; i++) {
      fixedList[i] = list[i];
    }

    return fixedList;
  }

  /**
   * Returns the immutable collection of groups where each group key mapped to
   * the group of the elements.
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
  Lookup<dynamic, dynamic> toLookup(dynamic keySelector(TSource source), [dynamic elementSelector(TSource source), IEqualityComparer<dynamic> comparer]) {
    if(keySelector == null) {
      throw new ArgumentError("keySelector: $keySelector");
    }

    if(comparer == null) {
      comparer = new EqualityComparer<dynamic>();
    }

    var dictionary = new Dictionary<dynamic, IGrouping<dynamic, dynamic>>(comparer);
    for(var grouping in groupBy(keySelector, elementSelector, comparer)) {
      dictionary[grouping.key] = grouping;
    }

    return new Lookup<dynamic, dynamic>._internal(dictionary);
  }

  /**
   * Returns the sequence that consists of the distinct elements from the current
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
  IEnumerable<TSource> union(HasIterator<TSource> other, [IEqualityComparer<TSource> comparer]) {
    return new _UnionIterator<TSource>(this, other, comparer);
  }

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
  IEnumerable<TSource> where(bool predicate(TSource element)) {
    return new _WhereIterator<TSource>(this, predicate);
  }
}
