part of queries;

abstract class IGrouping<TKey, TElement> implements IQueryable<TElement> {
  TKey get key;
}
