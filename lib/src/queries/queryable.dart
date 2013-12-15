part of queries;

abstract class IQueryable<TSource> implements HasIterator<TSource> {
  /**
   * static Queryable<TResult> range<TResult>(int start, int count)
   */
  static IQueryable<dynamic> range(int start, int count) {
    return new _RangeIterator<dynamic>(start, count);
  }

  /**
   * static Queryable<TResult> repeat<TResult>(TResult element, int count)
   */
  static IQueryable<dynamic> repeat(dynamic element, int count) {
    return new _RepeatIterator<dynamic>(element, count);
  }

  Iterator<TSource> get iterator;

  TSource aggregate(TSource func(TSource result, TSource element), [TSource seed]);

  bool all(bool predicate(TSource element));

  bool any([bool predicate(TSource element)]);

  Iterable<TSource> asIterable();

  IQueryable<TSource> asQueryable();

  num average([num selector(TSource element)]);

  /**
   * Queryable<TResult> cast<TResult>()
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
   * Queryable<Grouping<TKey, TElement>> groupBy<TKey, TElement>(TKey keySelector(TSource element), [TElement elementSelector(TSource source), EqualityComparer<TKey> comparer])
   */
  IQueryable<IGrouping<dynamic, dynamic>> groupBy(dynamic keySelector(TSource element), [dynamic elementSelector(TSource source), IEqualityComparer<dynamic> comparer]);

  /**
   * Queryable<TResult> groupJoin<TInner, TKey, TResult>(HasIterator<TInner> inner, TKey outerKeySelector(TSource outerElement), TKey innerKeySelector(TInner innerElement), TResult resultSelector(TSource outerElement, Queryable<TInner> innerElements), [EqualityComparer<TKey> comparer])
   */
  IQueryable<dynamic> groupJoin(HasIterator<dynamic> inner, dynamic outerKeySelector(TSource element), dynamic innerKeySelector(dynamic element), dynamic resultSelector(TSource outerElement, IQueryable<dynamic> innerElements), [IEqualityComparer<dynamic> comparer]);

  IQueryable<TSource> intersect(HasIterator<TSource> other, [IEqualityComparer<TSource> comparer]);

  /**
   * Queryable<TResult> join<TInner, TKey, TResult>(HasIterator<TInner> inner, TKey outerKeySelector(TSource outerElement), TKey innerKeySelector(TInner innerElement), TResult resultSelector(TSource outerElement, TInner innerElement), [EqualityComparer<TKey> comparer])
   */
  IQueryable<dynamic> join(HasIterator<dynamic> inner, dynamic outerKeySelector(TSource outerElement), dynamic innerKeySelector(dynamic innerElement), dynamic resultSelector(TSource outerElement, dynamic innerElement), [IEqualityComparer<dynamic> comparer]);

  TSource last([bool predicate(TSource element)]);

  TSource lastOrDefault([bool predicate(TSource element)]);

  num max([num selector(TSource element)]);

  num min([num selector(TSource element)]);

  /**
   * Queryable<TResult> ofType<TResult>()
   */
  IQueryable<dynamic> ofType();

  /**
   * Queryable<TSource> orderBy<TKey>(TKey keySelector(TSource element), [Comparator<TKey> comparer])
   */
  IOrderedQueryable<TSource> orderBy(dynamic keySelector(TSource element), [Comparator<dynamic> comparer]);

  /**
   * Queryable<TSource> orderByDescending<TKey>(TKey keySelector(TSource element), [Comparator<TKey> comparer])
   */
  IOrderedQueryable<TSource> orderByDescending(dynamic keySelector(TSource element), [Comparator<dynamic> comparer]);

  /**
   * Queryable<TResult> select<TResult>(TResult selector(TSource element))
   */
  IQueryable<dynamic> select(dynamic selector(TSource element));

  /**
   * Queryable<TResult> selectMany<TResult>(Queryable<TResult> selector(TSource source))
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
   * Map<TKey, TElement> toMap(TKey keySelector(TSource source), [TElement elementSelector(TSource source), EqualityComparer<TKey> comparer])
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
  TSource aggregate(TSource func(TSource result, TSource element), [TSource seed]) {
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

  Iterable<TSource> asIterable() {
    return new _Iterable<TSource>(iterator);
  }

  IQueryable<TSource> asQueryable() {
    return this;
  }

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

  IQueryable<dynamic> cast() {
    // return new CastIterator<TResult>(source);
    return new _CastIterator<dynamic>(this);
  }

  IQueryable<TSource> concat(HasIterator<TSource> other) {
    return new _ConcatIterator<TSource>(this, other);
  }

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

  IQueryable<TSource> defaultIfEmpty([TSource defaultValue]) {
    return new _DefaultIfEmptyIterator<TSource>(this, defaultValue);
  }

  IQueryable<TSource> distinct([IEqualityComparer<TSource> comparer]) {
    return new _DistinctIterator<TSource>(this, comparer);
  }

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

  IQueryable<TSource> except(HasIterator<TSource> other, [IEqualityComparer<TSource> comparer]) {
    return new _ExceptIterator<TSource>(this, other, comparer);
  }

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

  IQueryable<IGrouping<dynamic, dynamic>> groupBy(dynamic keySelector(TSource element), [dynamic elementSelector(TSource source), IEqualityComparer<dynamic> comparer]) {
    // return new _GroupByIterator<TSource, TKey, TElement>>(this, keySelector, elementSelector, comparer);
    return new _GroupByIterator<TSource, dynamic, dynamic>(this, keySelector, elementSelector, comparer);
  }

  IQueryable<dynamic> groupJoin(HasIterator<dynamic> inner, dynamic outerKeySelector(TSource outerElement), dynamic innerKeySelector(dynamic innerElement), dynamic resultSelector(TSource outerElement, IQueryable<dynamic> innerElements), [IEqualityComparer<dynamic> comparer]) {
    // return new _GroupJoinIterator<TSource, TInner, TKey, TResult>(this, inner, outerKeySelector, innerKeySelector, resultSelector, comparer);
    return new _GroupJoinIterator<TSource, dynamic, dynamic, dynamic>(this, inner, outerKeySelector, innerKeySelector, resultSelector, comparer);
  }

  IQueryable<TSource> intersect(HasIterator<TSource> other, [IEqualityComparer<TSource> comparer]) {
    return new _IntersectIterator<TSource>(this, other, comparer);
  }

  IQueryable<dynamic> join(HasIterator<dynamic> inner, dynamic outerKeySelector(TSource outer), dynamic innerKeySelector(dynamic inner), dynamic resultSelector(TSource outer, dynamic inner), [IEqualityComparer<dynamic> comparer]) {
    // return new _JoinIterator<TSource, TInner, TKey, TResult>(this, inner, outerKeySelector, innerKeySelector, resultSelector, comparer);
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

  IQueryable<dynamic> ofType() {
    // return new _OfTypeIterator<TResult>(source);
    return new _OfTypeIterator<dynamic>(this);
  }

  IOrderedQueryable<TSource> orderBy(dynamic keySelector(TSource source), [Comparator<dynamic> comparer]) {
    // return new _OrderByIterator<TSource, TKey>(this, keySelector, false, comparer);
    return new _OrderByIterator<TSource, dynamic>(this, keySelector, false, comparer);
  }

  IOrderedQueryable<TSource> orderByDescending(dynamic keySelector(TSource source), [Comparator<dynamic> comparer]) {
    // return new _OrderByIterator<TSource, TKey>(this, keySelector, true, comparer);
    return new _OrderByIterator<TSource, dynamic>(this, keySelector, true, comparer);
  }

  IQueryable<dynamic> select(dynamic selector(TSource element)) {
    // return new _SelectIterator<TSource, TResult>(this, selector);
    return new _SelectIterator<TSource, dynamic>(this, selector);
  }

  IQueryable<dynamic> selectMany(IQueryable<dynamic> selector(TSource source)) {
    // return new _SelectManyIterator<TSource, TResult>(this, selector);
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
        if(length > 1) {
          throw new StateError("The source sequence contains more than one element");
        } else {
          length++;
        }
      }

    } else {
      while(iterator.moveNext()) {
        var current = iterator.current;
        if(predicate(current)) {
          if(length > 1) {
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
        if(length > 1) {
          throw new StateError("The source sequence contains more than one element");
        } else {
          length++;
        }
      }

    } else {
      while(iterator.moveNext()) {
        var current = iterator.current;
        if(predicate(current)) {
          if(length > 1) {
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

  IQueryable<TSource> skip(int count) {
    return new _SkipIterator<TSource>(this, count);
  }

  IQueryable<TSource> skipWhile(bool predicate(TSource element)) {
    return new _SkipWhileIterator<TSource>(this, predicate);
  }

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

  IQueryable<TSource> take(int count) {
    return new _TakeIterator<TSource>(this, count);
  }

  IQueryable<TSource> takeWhile(bool predicate(TSource element)) {
    return new _TakeWhileIterator<TSource>(this, predicate);
  }

  List<TSource> toList({bool growable : true}) {
    // return new List.from(this, growable);
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

  Collection<TSource> toCollection() {
    return new Collection(this.toList());
  }

  Dictionary<dynamic, dynamic> toDictionary(dynamic keySelector(TSource source), [dynamic elementSelector(TSource source), IEqualityComparer<dynamic> comparer]) {
    if(keySelector == null) {
      throw new ArgumentError("keySelector: $keySelector");
    }

    if(comparer == null) {
      // comparer = new _EqualityComparer<TKey>();
      comparer = new EqualityComparer<dynamic>();
    }

    var dictionary = new Dictionary(comparer);
    for(var grouping in groupBy(keySelector, elementSelector, comparer)) {
      dictionary[grouping.key] = grouping;
    }

    return dictionary;
  }

  Lookup<dynamic, dynamic> toLookup(dynamic keySelector(TSource source), [dynamic elementSelector(TSource source), IEqualityComparer<dynamic> comparer]) {
    if(keySelector == null) {
      throw new ArgumentError("keySelector: $keySelector");
    }

    // return new _Lookup<TKey, TElement>(toDictionary<TKey, TElement>(keySelector, elementSelector, comparer));
    return new Lookup<dynamic, dynamic>._internal(toDictionary(keySelector, elementSelector, comparer));
  }

  IQueryable<TSource> union(HasIterator<TSource> other, [IEqualityComparer<TSource> comparer]) {
    return new _UnionIterator<TSource>(this, other, comparer);
  }

  IQueryable<TSource> where(bool predicate(TSource element)) {
    return new _WhereIterator<TSource>(this, predicate);
  }
}
