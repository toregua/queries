part of queries.iterators;

class CastIterator<TResult> extends Object with Queryable<TResult> {
  HasIterator<dynamic> _source;

  CastIterator(HasIterator<dynamic> source) {
    if(source == null) {
      throw new ArgumentError("source: $source");
    }

    _source = source;
  }

  Iterator<dynamic> get iterator {
    return _getIterator();
  }

  Iterator<dynamic> _getIterator() {
    Iterator<dynamic> sourceIterator;
    var iterator = new _Iterator<dynamic>();
    iterator.action = () {
      while(true) {
        switch(iterator.state) {
          case 1:
            if(sourceIterator.moveNext()) {
              iterator.result = sourceIterator.current as TResult;
              return true;
            }

            sourceIterator = null;
            iterator.state = -1;
            return false;
          case 0:
            sourceIterator = _source.iterator;
            iterator.state = 1;
            break;
          default:
            return false;
        }
      }
    };

    return iterator;
  }
}

class ConcatIterator<TSource> extends Object with Queryable<TSource> {
  HasIterator<TSource> _first;

  HasIterator<TSource> _second;

  ConcatIterator(HasIterator<TSource> first, HasIterator<TSource> second) {
    if(first == null) {
      throw new ArgumentError("first: $first");
    }

    if(second == null) {
      throw new ArgumentError("second: $second");
    }

    _first = first;
    _second = second;
  }

  Iterator<TSource> get iterator {
    return _getIterator();
  }

  Iterator<TSource> _getIterator() {
    Iterator<TSource> sourceIterator;
    var iterator = new _Iterator<TSource>();
    iterator.action = () {
      while(true) {
        switch(iterator.state) {
          case 1:
            if(sourceIterator.moveNext()) {
              iterator.result = sourceIterator.current;
              return true;
            }

            sourceIterator = _second.iterator;
            iterator.state = 2;
            break;
          case 2:
            if(sourceIterator.moveNext()) {
              iterator.result = sourceIterator.current;
              return true;
            }

            sourceIterator = null;
            iterator.state = -1;
            return false;
          case 0:
            sourceIterator = _first.iterator;
            iterator.state = 1;
            break;
          default:
            return false;
        }
      }
    };

    return iterator;
  }
}

class DefaultIfEmptyIterator<TSource> extends Object with Queryable<TSource> {
  TSource _defaultValue;

  HasIterator<TSource> _source;

  DefaultIfEmptyIterator(HasIterator<TSource> source, [TSource defaultValue]) {
    if(source == null) {
      throw new ArgumentError("source: $source");
    }

    _defaultValue = defaultValue;
    _source = source;
  }

  Iterator<TSource> get iterator {
    return _getIterator();
  }

  Iterator<TSource> _getIterator() {
    Iterator<TSource> sourceIterator;
    var iterator = new _Iterator<TSource>();
    iterator.action = () {
      while(true) {
        switch(iterator.state) {
          case 2:
            if(sourceIterator.moveNext()) {
              iterator.result = sourceIterator.current;
              return true;
            }

            sourceIterator = null;
            iterator.state = -1;
            return false;
          case 1:
            if(!sourceIterator.moveNext()) {
              iterator.result = _defaultValue;
              iterator.state = -1;
              return true;
            }

            iterator.result = sourceIterator.current;
            iterator.state = 2;
            return true;
          case 0:
            sourceIterator = _source.iterator;
            iterator.state = 1;
            break;
          default:
            return false;
        }
      }
    };

    return iterator;
  }
}

class DistinctIterator<TSource> extends Object with Queryable<TSource> {
  IEqualityComparer<TSource> _comparer;

  HasIterator<TSource> _source;

  DistinctIterator(HasIterator<TSource> source, [IEqualityComparer<TSource> comparer]) {
    if(source == null) {
      throw new ArgumentError("source: $source");
    }

    if(comparer == null) {
      comparer = new EqualityComparer<TSource>();
    }

    _comparer = comparer;
    _source = source;
  }

  Iterator<TSource> get iterator {
    return _getIterator();
  }

  Iterator<TSource> _getIterator() {
    Set<TSource> set;
    Iterator<TSource> sourceIterator;
    var iterator = new _Iterator<TSource>();
    iterator.action = () {
      while(true) {
        switch(iterator.state) {
          case 1:
            while(sourceIterator.moveNext()) {
              iterator.result = sourceIterator.current;
              if(!set.contains(iterator.result)) {
                set.add(iterator.result);
                return true;
              }
            }

            set = null;
            sourceIterator = null;
            iterator.state = -1;
            return false;
          case 0:
            set = new HashSet<TSource>(equals : _comparer.equals, hashCode : _comparer.getHashCode);
            sourceIterator = _source.iterator;
            iterator.state = 1;
            break;
          default:
            return false;
        }
      }
    };

    return iterator;
  }

}

class EmptyIterator<TSource> extends Object with Queryable<TSource> {
  Iterator<TSource> get iterator {
    return _getIterator();
  }

  Iterator<TSource> _getIterator() {
    var iterator = new _Iterator<TSource>();
    iterator.action = () {
      while(true) {
        switch(iterator.state) {
          case 0:
            iterator.state = -1;
            return false;
          default:
            return false;
        }
      }
    };

    return iterator;
  }
}

class ExceptIterator<TSource> extends Object with Queryable<TSource> {
  IEqualityComparer<TSource> _comparer;

  HasIterator<TSource> _first;

  HasIterator<TSource> _second;

  ExceptIterator(HasIterator<TSource> first, HasIterator<TSource> second, [IEqualityComparer<TSource> comparer]) {
    if(first == null) {
      throw new ArgumentError("first: $first");
    }

    if(second == null) {
      throw new ArgumentError("second: $second");
    }

    if(comparer == null) {
      comparer = new EqualityComparer<TSource>();
    }

    _comparer = comparer;
    _first = first;
    _second = second;
  }

  Iterator<TSource> get iterator {
    return _getIterator();
  }

  Iterator<TSource> _getIterator() {
    Iterator<TSource> resultIterator;
    var iterator = new _Iterator<TSource>();
    iterator.action = () {
      while(true) {
        switch(iterator.state) {
          case 1:
            if(resultIterator.moveNext()) {
              iterator.result = resultIterator.current;
              return true;
            }

            resultIterator = null;
            iterator.state = -1;
            return false;
          case 0:
            var set = new HashSet<TSource>(equals : _comparer.equals, hashCode : _comparer.getHashCode);
            var secondIterator = _second.iterator;
            while(secondIterator.moveNext()) {
              set.add(secondIterator.current);
            }

            var firstIterator = _first.iterator;
            var result = new List<TSource>();
            while(firstIterator.moveNext()) {
              var value = firstIterator.current;
              if(!set.contains(value)) {
                result.add(value);
              }
            }

            resultIterator = result.iterator;
            iterator.state = 1;
            break;
          default:
            return false;
        }
      }
    };

    return iterator;
  }
}

class GroupByIterator<TSource, TKey, TElement> extends Object with Queryable<IGrouping<TKey, TElement>> {
  IEqualityComparer<TKey> _comparer;

  Function _elementSelector;

  Function _keySelector;

  HasIterator<TSource> _source;

  GroupByIterator(HasIterator<TSource> source, TKey keySelector(TSource element), [TElement elementSelector(TSource source), IEqualityComparer<TKey> comparer]) {
    if(source == null) {
      throw new ArgumentError("source: $source");
    }

    if(keySelector == null) {
      throw new ArgumentError("keySelector: $keySelector");
    }

    if(comparer == null) {
      comparer = new EqualityComparer<TKey>();
    }

    _comparer = comparer;
    _elementSelector = elementSelector;
    _keySelector = keySelector;
    _source = source;
  }

  Iterator<IGrouping<TKey, TElement>> get iterator {
    return _getIterator();
  }

  Iterator<IGrouping<TKey, TElement>> _getIterator() {
    Iterator<IGrouping<TKey, TElement>> resultIterator;
    var iterator = new _Iterator<IGrouping<TKey, TElement>>();
    iterator.action = () {
      while(true) {
        switch(iterator.state) {
          case 1:
            if(resultIterator.moveNext()) {
              iterator.result = resultIterator.current;
              return true;
            }

            resultIterator = null;
            iterator.state = -1;
            return false;
          case 0:
            var result = new List<IGrouping<TKey, TElement>>();
            //var map = new LinkedHashMap<TKey, List<Grouping<TKey, TElement>>>(equals : _comparer.equals, hashCode : _comparer.getHashCode);
            var map = new LinkedHashMap<TKey, List<TElement>>(equals : _comparer.equals, hashCode : _comparer.getHashCode);
            var sourceIterator = _source.iterator;
            while(sourceIterator.moveNext()) {
              var current = sourceIterator.current;
              var key = _keySelector(current);
              TElement element;
              if(_elementSelector != null) {
                element = _elementSelector(current);
              } else {
                element = current;
              }

              var elements = map[key];
              if(elements == null) {
                elements = new List<TElement>();
                map[key] = elements;
              }

              elements.add(element);
            }

            for(var key in map.keys) {
              result.add(new _Grouping<TKey, TElement>(key, new QueryableIterator<TElement>(map[key])));
            }

            resultIterator = result.iterator;
            iterator.state = 1;
            break;
          default:
            return false;
        }
      }
    };

    return iterator;
  }
}

class GroupJoinIterator<TOuter, TInner, TKey, TResult> extends Object with Queryable<TResult> {
  IEqualityComparer<TKey> _comparer;

  HasIterator<TInner> _inner;

  Function _innerKeySelector;

  HasIterator<TOuter> _outer;

  Function _outerKeySelector;

  Function _resultSelector;

  GroupJoinIterator(HasIterator<TOuter> outer, HasIterator<TInner> inner, TKey outerKeySelector(TOuter outerElement), TKey innerKeySelector(TInner innerElement), TResult resultSelector(TOuter outer, IQueryable<TInner> inner), [IEqualityComparer<TKey> comparer]) {
    if(outer == null) {
      throw new ArgumentError("outer: $outer");
    }

    if(inner == null) {
      throw new ArgumentError("inner: $inner");
    }

    if(innerKeySelector == null) {
      throw new ArgumentError("innerKeySelector: $innerKeySelector");
    }

    if(outerKeySelector == null) {
      throw new ArgumentError("outerKeySelector: $outerKeySelector");
    }

    if(resultSelector == null) {
      throw new ArgumentError("resultSelector: $resultSelector");
    }

    if(comparer == null) {
      comparer = new EqualityComparer<TKey>();
    }

    _comparer = comparer;
    _inner = inner;
    _innerKeySelector = innerKeySelector;
    _outer = outer;
    _outerKeySelector = outerKeySelector;
    _resultSelector = resultSelector;
  }

  Iterator<TResult> get iterator {
    return _getIterator();
  }

  Iterator<TResult> _getIterator() {
    Iterator<TResult> resultIterator;
    var iterator = new _Iterator<TResult>();
    iterator.action = () {
      while(true) {
        switch(iterator.state) {
          case 1:
            if(resultIterator.moveNext()) {
              iterator.result = resultIterator.current;
              return true;
            }

            resultIterator = null;
            iterator.state = -1;
            return false;
          case 0:
            var innerMap = new LinkedHashMap<TKey, List<TInner>>(equals : _comparer.equals, hashCode : _comparer.getHashCode);
            var innerIterator = _inner.iterator;
            while(innerIterator.moveNext()) {
              var innerValue = innerIterator.current;
              TKey key = _innerKeySelector(innerValue);
              var elements = innerMap[key];
              if(elements == null) {
                elements = new List<TInner>();
                innerMap[key] = elements;
              }

              elements.add(innerValue);
            }

            var outerIterator = _outer.iterator;
            var result = new List<TResult>();
            while(outerIterator.moveNext()) {
              var outerValue = outerIterator.current;
              TKey key = _outerKeySelector(outerValue);
              var innerValues = innerMap[key];
              if(innerValues != null) {
                result.add(_resultSelector(outerValue, new QueryableIterator<TInner>(innerValues)));
              }
            }

            resultIterator = result.iterator;
            iterator.state = 1;
            break;
          default:
            return false;
        }
      }
    };

    return iterator;
  }
}

class IntersectIterator<TSource> extends Object with Queryable<TSource> {
  IEqualityComparer<TSource> _comparer;

  HasIterator<TSource> _first;

  HasIterator<TSource> _second;

  IntersectIterator(HasIterator<TSource> first, HasIterator<TSource> second, [IEqualityComparer<TSource> comparer]) {
    if(first == null) {
      throw new ArgumentError("first: $first");
    }

    if(second == null) {
      throw new ArgumentError("second: $second");
    }

    if(comparer == null) {
      comparer = new EqualityComparer<TSource>();
    }

    _comparer = comparer;
    _first = first;
    _second = second;
  }

  Iterator<TSource> get iterator {
    return _getIterator();
  }

  Iterator<TSource> _getIterator() {
    Iterator<TSource> resultIterator;
    var iterator = new _Iterator<TSource>();
    iterator.action = () {
      while(true) {
        switch(iterator.state) {
          case 1:
            if(resultIterator.moveNext()) {
              iterator.result = resultIterator.current;
              return true;
            }

            resultIterator = null;
            iterator.state = -1;
            return false;
          case 0:
            var firstSet = new HashSet<TSource>(equals : _comparer.equals, hashCode : _comparer.getHashCode);
            var outputSet = new HashSet<TSource>(equals : _comparer.equals, hashCode : _comparer.getHashCode);
            var firstIterator = _first.iterator;
            while(firstIterator.moveNext()) {
              firstSet.add(firstIterator.current);
            }

            var secondterator = _second.iterator;
            var result = new List<TSource>();
            while(secondterator.moveNext()) {
              var value = secondterator.current;
              if(firstSet.contains(value)) {
                if(!outputSet.contains(value)) {
                  result.add(value);
                  outputSet.add(value);
                }
              }
            }

            resultIterator = result.iterator;
            iterator.state = 1;
            break;
          default:
            return false;
        }
      }
    };

    return iterator;
  }
}

class JoinIterator<TOuter, TInner, TKey, TResult> extends Object with Queryable<TResult> {
  IEqualityComparer<TKey> _comparer;

  HasIterator<TInner> _inner;

  Function _innerKeySelector;

  HasIterator<TOuter> _outer;

  Function _outerKeySelector;

  Function _resultSelector;

  JoinIterator(HasIterator<TOuter> outer, HasIterator<TInner> inner, TKey outerKeySelector(TOuter outerElement), TKey innerKeySelector(TInner innerElement), TResult resultSelector(TOuter outerElement, TInner innerElement), [IEqualityComparer<TKey> comparer]) {
    if(outer == null) {
      throw new ArgumentError("outer: $outer");
    }

    if(inner == null) {
      throw new ArgumentError("inner: $inner");
    }

    if(innerKeySelector == null) {
      throw new ArgumentError("innerKeySelector: $innerKeySelector");
    }

    if(outerKeySelector == null) {
      throw new ArgumentError("outerKeySelector: $outerKeySelector");
    }

    if(resultSelector == null) {
      throw new ArgumentError("resultSelector: $resultSelector");
    }

    if(comparer == null) {
      comparer = new EqualityComparer<TKey>();
    }

    _comparer = comparer;
    _inner = inner;
    _innerKeySelector = innerKeySelector;
    _outer = outer;
    _outerKeySelector = outerKeySelector;
    _resultSelector = resultSelector;
  }

  Iterator<TResult> get iterator {
    return _getIterator();
  }

  Iterator<TResult> _getIterator() {
    Iterator<TResult> resultIterator;
    var iterator = new _Iterator<TResult>();
    iterator.action = () {
      while(true) {
        switch(iterator.state) {
          case 1:
            if(resultIterator.moveNext()) {
              iterator.result = resultIterator.current;
              return true;
            }

            resultIterator = null;
            iterator.state = -1;
            return false;
          case 0:
            var innerMap = new LinkedHashMap<TKey, List<TInner>>(equals : _comparer.equals, hashCode : _comparer.getHashCode);
            var innerIterator = _inner.iterator;
            while(innerIterator.moveNext()) {
              var innerValue = innerIterator.current;
              TKey key = _innerKeySelector(innerValue);
              var elements = innerMap[key];
              if(elements == null) {
                elements = new List<TInner>();
                innerMap[key] = elements;
              }

              elements.add(innerValue);
            }

            var outerIterator = _outer.iterator;
            var result = new List<TResult>();
            while(outerIterator.moveNext()) {
              var outerValue = outerIterator.current;
              TKey key = _outerKeySelector(outerValue);
              var innerValues = innerMap[key];
              if(innerValues != null) {
                for(var innerValue in innerValues) {
                  result.add(_resultSelector(outerValue, innerValue));
                }
              }
            }

            resultIterator = result.iterator;
            iterator.state = 1;
            break;
          default:
            return false;
        }
      }
    };

    return iterator;
  }
}

class OfTypeIterator<TResult> extends Object with Queryable<TResult> {
  HasIterator<dynamic> _source;

  OfTypeIterator(HasIterator<dynamic> source) {
    if(source == null) {
      throw new ArgumentError("source: $source");
    }

    _source = source;
  }

  Iterator<TResult> get iterator {
    return _getIterator();
  }

  Iterator<TResult> _getIterator() {
    Iterator<dynamic> sourceIterator;
    var iterator = new _Iterator<TResult>();
    iterator.action = () {
      while(true) {
        switch(iterator.state) {
          case 1:
            while(sourceIterator.moveNext()) {
              var current = sourceIterator.current;
              if(current is TResult) {
                iterator.result = current;
                return true;
              }
            }

            sourceIterator = null;
            iterator.state = -1;
            return false;
          case 0:
            sourceIterator = _source.iterator;
            iterator.state = 1;
            break;
          default:
            return false;
        }
      }
    };

    return iterator;
  }
}

class OrderByIterator<TSource, TKey> extends _OrderedQueryable<TSource> {
  Comparator<TKey> _comparer;

  bool _descending;

  Function _keySelector;

  HasIterator<TSource> _source;

  OrderByIterator(HasIterator<TSource> source, TKey keySelector(TSource element), bool descending, [Comparator<TKey> comparer]) {
    if(source == null) {
      throw new ArgumentError("source: $source");
    }

    if(keySelector == null) {
      throw new ArgumentError("keySelector: $keySelector");
    }

    if(comparer == null) {
      comparer = Comparable.compare;
    }

    _comparer = comparer;
    _descending = descending;
    _keySelector = keySelector;
    _source = source;
  }

  Comparator<TKey> get comparer {
    return _comparer;
  }

  Iterator<TSource> get iterator {
    return _getIterator();
  }

  Function get keySelector {
    return _keySelector;
  }

  Iterator<TSource> _getIterator() {
    Iterator<TSource> resultIterator;
    Comparator<TSource> sourceComparer;
    var iterator = new _Iterator<TSource>();
    iterator.action = () {
      while(true) {
        switch(iterator.state) {
          case 1:
            if(resultIterator.moveNext()) {
              iterator.result = resultIterator.current;
              return true;
            }

            resultIterator = null;
            iterator.state = -1;
            return false;
          case 0:
            Comparator<TSource> comparer;
            if(_descending) {
              comparer = (TSource a, TSource b) => -_comparer(keySelector(a), keySelector(b));
            } else {
              comparer = (TSource a, TSource b) => _comparer(keySelector(a), keySelector(b));
            }

            var sorter = new _SymmergeSorter<TSource>(comparer);
            var result = <TSource>[];
            var sourceIterator = _source.iterator;
            while(sourceIterator.moveNext()) {
              result.add(sourceIterator.current);
            }

            sorter.sort(result);
            resultIterator = result.iterator;
            iterator.state = 1;
            break;
          default:
            return false;
        }
      }
    };

    return iterator;
  }
}

class QueryableIterator<TSource> extends Object with Queryable<TSource> {
  // HasIterator<TSource> _source;
  dynamic _source;

  // QueryableIterator(HasIterator<TSource> source) {
  QueryableIterator(dynamic source) {
    if(source == null) {
      throw new ArgumentError("source: $source");
    }

    _source = source;
  }

  Iterator<TSource> get iterator {
    return _getIterator();
  }

  Iterator<TSource> _getIterator() {
    Iterator<TSource> sourceIterator;
    var iterator = new _Iterator<TSource>();
    iterator.action = () {
      while(true) {
        switch(iterator.state) {
          case 1:
            if(sourceIterator.moveNext()) {
              iterator.result = sourceIterator.current;
              return true;
            }

            sourceIterator = null;
            iterator.state = -1;
            return false;
          case 0:
            sourceIterator = _source.iterator;
            iterator.state = 1;
            break;
          default:
            return false;
        }
      }
    };

    return iterator;
  }
}

class RangeIterator<TSource> extends Object with Queryable<TSource> {
  int _count;

  int _start;

  RangeIterator(int start, int count) {
    if(count == null || count < 0) {
      throw new ArgumentError("count: $count");
    }

    if(start == null) {
      throw new ArgumentError("start: $start");
    }

    if(start + count - 1 > 2147483647) {
      throw new RangeError.value(start + count - 1);
    }

    _count = count;
    _start = start;
  }

  Iterator<TSource> get iterator {
    return _getIterator();
  }

  Iterator<TSource> _getIterator() {
    int count;
    var iterator = new _Iterator<TSource>();
    iterator.action = () {
      while(true) {
        switch(iterator.state) {
          case 1:
            if(count-- > 0) {
              iterator.result++;
              return true;
            }

            iterator.state = -1;
            return false;
          case 0:
            count = _count;
            if(count-- > 0) {
              iterator.result = _start;
              iterator.state = 1;
              return true;
            }

            iterator.state = -1;
            return false;
          default:
            return false;
        }
      }
    };

    return iterator;
  }

}

class RepeatIterator<TSource> extends Object with Queryable<TSource> {
  int _count;

  TSource _element;

  RepeatIterator(TSource element, int count) {
    if(count == null || count < 0) {
      throw new ArgumentError("count: $count");
    }

    _count = count;
    _element = element;
  }

  Iterator<TSource> get iterator {
    return _getIterator();
  }

  Iterator<TSource> _getIterator() {
    int count;
    var iterator = new _Iterator<TSource>();
    iterator.action = () {
      while(true) {
        switch(iterator.state) {
          case 1:
            if(count-- > 0) {
              return true;
            }

            iterator.state = -1;
            return false;
          case 0:
            count = _count;
            if(count-- > 0) {
              iterator.result = _element;
              iterator.state = 1;
              return true;
            }

            iterator.state = -1;
            return false;
          default:
            return false;
        }
      }
    };

    return iterator;
  }
}

class SelectIterator<TSource, TResult> extends Object with Queryable<TResult> {
  Function _selector;

  HasIterator<TSource> _source;

  SelectIterator(HasIterator<TSource> source, TResult selector(TSource element)) {
    if(source == null) {
      throw new ArgumentError("source: $source");
    }

    if(selector == null) {
      throw new ArgumentError("selector: $selector");
    }

    _source = source;
    _selector = selector;
  }

  Iterator<TResult> get iterator {
    return _getIterator();
  }

  Iterator<TResult> _getIterator() {
    Iterator<TSource> sourceIterator;
    var iterator = new _Iterator<TResult>();
    iterator.action = () {
      while(true) {
        switch(iterator.state) {
          case 1:
            if(sourceIterator.moveNext()) {
              iterator.result = _selector(sourceIterator.current);
              return true;
            }

            sourceIterator = null;
            iterator.state = -1;
            return false;
          case 0:
            sourceIterator = _source.iterator;
            iterator.state = 1;
            break;
          default:
            return false;
        }
      }
    };

    return iterator;
  }
}

class SelectManyIterator<TSource, TResult> extends Object with Queryable<TResult> {
  Function _selector;

  HasIterator<TSource> _source;

  SelectManyIterator(HasIterator<TSource> source, IQueryable<TResult> selector(TSource element)) {
    if(source == null) {
      throw new ArgumentError("source: $source");
    }

    if(selector == null) {
      throw new ArgumentError("selector: $selector");
    }

    _selector = selector;
    _source = source;
  }

  Iterator<TResult> get iterator {
    return _getIterator();
  }

  Iterator<TResult> _getIterator() {
    Iterator<TResult> elementIterator;
    Iterator<TSource> sourceIterator;
    var iterator = new _Iterator<TResult>();
    iterator.action = () {
      while(true) {
        switch(iterator.state) {
          case 2:
            if(elementIterator.moveNext()) {
              iterator.result = elementIterator.current;
              return true;
            }

            elementIterator = null;
            iterator.state = 1;
            break;
          case 1:
            if(sourceIterator.moveNext()) {
              IQueryable<TResult> element = _selector(sourceIterator.current);
              elementIterator = element.iterator;
              iterator.state = 2;
              break;
            }

            sourceIterator = null;
            iterator.state = -1;
            return false;
          case 0:
            sourceIterator = _source.iterator;
            iterator.state = 1;
            break;
          default:
            return false;
        }
      }
    };

    return iterator;
  }
}

class SkipIterator<TSource> extends Object with Queryable<TSource> {
  int _count;

  HasIterator<TSource> _source;

  SkipIterator(HasIterator<TSource> source, int count) {
    if(source == null) {
      throw new ArgumentError("source: $source");
    }

    if(count == null || count < 0) {
      throw new ArgumentError("count: $count");
    }

    _count = count;
    _source = source;
  }

  Iterator<TSource> get iterator {
    return _getIterator();
  }

  Iterator<TSource> _getIterator() {
    int count;
    Iterator<TSource> sourceIterator;
    var iterator = new _Iterator<TSource>();
    iterator.action = () {
      while(true) {
        switch(iterator.state) {
          case 1:
            if(sourceIterator.moveNext()) {
              iterator.result = sourceIterator.current;
              return true;
            }

            sourceIterator = null;
            iterator.state = -1;
            return false;
          case 0:
            count = _count;
            sourceIterator = _source.iterator;
            while(count > 0) {
              count--;
              if(!sourceIterator.moveNext()) {
                sourceIterator = null;
                iterator.state = -1;
                return false;
              }
            }

            iterator.state = 1;
            break;
          default:
            return false;
        }
      }
    };

    return iterator;
  }

}

class SkipWhileIterator<TSource> extends Object with Queryable<TSource> {
  Function _predicate;

  HasIterator<TSource> _source;

  SkipWhileIterator(HasIterator<TSource> source, bool predicate(TSource element)) {
    if(source == null) {
      throw new ArgumentError("source: $source");
    }

    if(predicate == null) {
      throw new ArgumentError("predicate: $predicate");
    }

    _predicate = predicate;
    _source = source;
  }

  Iterator<TSource> get iterator {
    return _getIterator();
  }

  Iterator<TSource> _getIterator() {
    Iterator<TSource> sourceIterator;
    var iterator = new _Iterator<TSource>();
    iterator.action = () {
      while(true) {
        switch(iterator.state) {
          case 1:
            if(sourceIterator.moveNext()) {
              iterator.result = sourceIterator.current;
              return true;
            }

            sourceIterator = null;
            iterator.state = -1;
            return false;
          case 0:
            sourceIterator = _source.iterator;
            while(sourceIterator.moveNext()) {
              var current = sourceIterator.current;
              if(!_predicate(current)) {
                iterator.state = 1;
                iterator.result = sourceIterator.current;
                return true;
              }
            }

            sourceIterator = null;
            iterator.state = -1;
            return false;
          default:
            return false;
        }
      }
    };

    return iterator;
  }

}

class TakeIterator<TSource> extends Object with Queryable<TSource> {
  int _count;

  HasIterator<TSource> _source;

  TakeIterator(HasIterator<TSource> source, int count) {
    if(source == null) {
      throw new ArgumentError("source: $source");
    }

    if(count == null || count < 0) {
      throw new ArgumentError("count: $count");
    }

    _count = count;
    _source = source;
  }

  Iterator<TSource> get iterator {
    return _getIterator();
  }

  Iterator<TSource> _getIterator() {
    int count;
    Iterator<TSource> sourceIterator;
    var iterator = new _Iterator<TSource>();
    iterator.action = () {
      while(true) {
        switch(iterator.state) {
          case 1:
            if(count > 0) {
              count--;
              if(sourceIterator.moveNext()) {
                iterator.result = sourceIterator.current;
                return true;
              }
            }

            sourceIterator = null;
            iterator.state = -1;
            return false;
          case 0:
            count = _count;
            sourceIterator = _source.iterator;
            iterator.state = 1;
            break;
          default:
            return false;
        }
      }
    };

    return iterator;
  }

}

class TakeWhileIterator<TSource> extends Object with Queryable<TSource> {
  Function _predicate;

  HasIterator<TSource> _source;

  TakeWhileIterator(HasIterator<TSource> source, bool predicate(TSource element)) {
    if(source == null) {
      throw new ArgumentError("source: $source");
    }

    if(predicate == null) {
      throw new ArgumentError("predicate: $predicate");
    }

    _predicate = predicate;
    _source = source;
  }

  Iterator<TSource> get iterator {
    return _getIterator();
  }

  Iterator<TSource> _getIterator() {
    Iterator<TSource> sourceIterator;
    var iterator = new _Iterator<TSource>();
    iterator.action = () {
      while(true) {
        switch(iterator.state) {
          case 1:
            if(sourceIterator.moveNext()) {
              var current = sourceIterator.current;
              if(_predicate(current)) {
                iterator.result = current;
                return true;
              }
            }

            sourceIterator = null;
            iterator.state = -1;
            return false;
          case 0:
            sourceIterator = _source.iterator;
            iterator.state = 1;
            break;
          default:
            return false;
        }
      }
    };

    return iterator;
  }
}

class ThenByIterator<TSource, TKey> extends OrderByIterator<TSource, TKey> {
  OrderByIterator<TSource, dynamic> _source;

  ThenByIterator(OrderByIterator<TSource, dynamic> source, TKey keySelector(TSource element), bool descending, [Comparator<TKey> comparer]) : super(source, keySelector, descending, comparer);

  Iterator<TSource> get iterator {
    return _getIterator();
  }

  Iterator<TSource> _getIterator() {
    Iterator<TSource> resultIterator;
    var iterator = new _Iterator<TSource>();
    iterator.action = () {
      while(true) {
        switch(iterator.state) {
          case 1:
            if(resultIterator.moveNext()) {
              iterator.result = resultIterator.current;
              return true;
            }

            resultIterator = null;
            iterator.state = -1;
            return false;
          case 0:
            List<TSource> result = new List<TSource>();
            Iterator<TSource> sourceIterator = _source.iterator;
            if(sourceIterator.moveNext()) {
              Comparator<TSource> comparer;
              TSource current;
              var group = new List<TSource>();
              var hasCurrent = false;
              var length = 1;
              Comparator<TSource> prevComparer;
              TSource previous = sourceIterator.current;
              if(_descending) {
                var sourceKeySelector = _source.keySelector;
                var sourceComparer = _source.comparer;
                comparer = (TSource a, TSource b) => -_comparer(_keySelector(a), _keySelector(b));
                prevComparer = (TSource a, TSource b) => -sourceComparer(sourceKeySelector(a), sourceKeySelector(b));
              } else {
                var sourceKeySelector = _source.keySelector;
                var sourceComparer = _source.comparer;
                comparer = (TSource a, TSource b) => _comparer(_keySelector(a), _keySelector(b));
                prevComparer = (TSource a, TSource b) => sourceComparer(sourceKeySelector(a), sourceKeySelector(b));
              }

              var sorter = new _SymmergeSorter<TSource>(comparer);
              group.add(previous);
              while(true) {
                while(sourceIterator.moveNext()) {
                  current = sourceIterator.current;
                  if(prevComparer(previous, current) == 0) {
                    group.add(current);
                    previous = current;
                    length++;
                  } else {
                    hasCurrent = true;
                    break;
                  }
                }

                if(length != 0) {
                  switch(length) {
                    case 1:
                      break;
                    case 2:
                      if(comparer(group[0], group[1]) > 0) {
                        var swap = group[0];
                        group[0] = group[1];
                        group[1] = swap;
                      }

                      break;
                    default:
                      sorter.sort(group);
                  }

                  result.addAll(group);
                  if(!hasCurrent) {
                    break;
                  }

                  group = <TSource>[];
                  hasCurrent = false;
                  length = 1;
                  group.add(current);
                  previous = current;
                } else {
                  break;
                }
              }
            }

            resultIterator = result.iterator;
            iterator.state = 1;
            break;
          default:
            return false;
        }
      }
    };

    return iterator;
  }
}

class UnionIterator<TSource> extends Object with Queryable<TSource> {
  IEqualityComparer<TSource> _comparer;

  HasIterator<TSource> _first;

  HasIterator<TSource> _second;

  UnionIterator(HasIterator<TSource> first, HasIterator<TSource> second, [IEqualityComparer<TSource> comparer]) {
    if(first == null) {
      throw new ArgumentError("first: $first");
    }

    if(second == null) {
      throw new ArgumentError("second: $second");
    }

    if(comparer == null) {
      comparer = new EqualityComparer<TSource>();
    }

    _comparer = comparer;
    _first = first;
    _second = second;
  }

  Iterator<TSource> get iterator {
    return _getIterator();
  }

  Iterator<TSource> _getIterator() {
    Set<TSource> set;
    Iterator<TSource> sourceIterator;
    var iterator = new _Iterator<TSource>();
    iterator.action = () {
      while(true) {
        switch(iterator.state) {
          case 2:
            while(sourceIterator.moveNext()) {
              var current = sourceIterator.current;
              if(!set.contains(current)) {
                set.add(current);
                iterator.result = current;
                return true;
              }
            }


            set = null;
            sourceIterator = null;
            iterator.state = -1;
            return false;
          case 1:
            while(sourceIterator.moveNext()) {
              var current = sourceIterator.current;
              if(!set.contains(current)) {
                set.add(current);
                iterator.result = current;
                return true;
              }
            }

            sourceIterator = _second.iterator;
            iterator.state = 2;
            break;
          case 0:
            set = new HashSet(equals : _comparer.equals, hashCode : _comparer.getHashCode);
            sourceIterator = _first.iterator;
            iterator.state = 1;
            break;
          default:
            return false;
        }
      }
    };

    return iterator;
  }

}

class WhereIterator<TSource> extends Object with Queryable<TSource> {
  Function _predicate;

  HasIterator<TSource> _source;

  WhereIterator(HasIterator<TSource> source, bool predicate(TSource element)) {
    if(source == null) {
      throw new ArgumentError("source: $source");
    }

    if(predicate == null) {
      throw new ArgumentError("predicate: $predicate");
    }

    _source = source;
    _predicate = predicate;
  }

  Iterator<TSource> get iterator {
    return _getIterator();
  }

  Iterator<TSource> _getIterator() {
    Iterator<TSource> sourceIterator;
    var iterator = new _Iterator<TSource>();
    iterator.action = () {
      while(true) {
        switch(iterator.state) {
          case 1:
            while(sourceIterator.moveNext()) {
              var current = sourceIterator.current;
              if(_predicate(current)) {
                iterator.result = current;
                return true;
              }
            }


            sourceIterator = null;
            iterator.state = -1;
            return false;
          case 0:
            sourceIterator = _source.iterator;
            iterator.state = 1;
            break;
          default:
            return false;
        }
      }
    };

    return iterator;
  }
}
