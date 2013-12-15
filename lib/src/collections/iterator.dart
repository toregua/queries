part of queries.collections;

class _Iterator<TElement> implements Iterator<TElement> {
  Function action;

  TElement result;

  int state = 0;

  _Iterator();

  TElement get current => result;

  bool moveNext() => action();
}
