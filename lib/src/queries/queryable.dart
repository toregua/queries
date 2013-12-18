part of queries;

abstract class IQueryable<TSource> implements IEnumerable<TSource> {
  Type get elementType;

  Expression get expression;

  IQueryProvider get provider;

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
  IQueryable<TSource> where(bool predicate(dynamic element)) {
    return provider.createQuery(
        Expression.methodCall(
          Expression.constant(this),
          objectInfo(this).type.getMethod(#where),
          [predicate == null ? Expression.constant(null) : LambdaExpression.build(predicate)])
    );
  }
}
