part of queries;

class _Iterator<TElement> implements Iterator<TElement> {
  Function action;

  dynamic result;

  int state = 0;

  _Iterator();

  TElement get current => result;

  bool moveNext() => action();
}
