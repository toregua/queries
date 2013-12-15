import 'package:queries/collections.dart';
import 'package:queries/queries.dart';
import 'package:unittest/unittest.dart';

void main() {
  testAggregate();
  testAll();
  testAny();
  testAverage();
  testCast();
  testConcat();
  testContains();
  testCount();
  testDefaultIfEmpty();
  testDistinct();
  testElementAt();
  testElementAtOrDefault();
  testExcept();
  testFirst();
  testFirstOrDefault();
  testGroupBy();
  testGroupJoin();
  testIntersect();
  testJoin();
  testLast();
  testLastOrDefault();
  testMax();
  testMin();
  testOfType();
  testOrderBy();
  testRange();
  testRepeat();
  testSelect();
  testSelectMany();
  testSingle();
  testSingleOrDefault();
  testSkip();
  testSkipWhile();
  testSum();
  testTake();
  testTakeWhile();
  testThenBy();
  testToLookup();
  testUnion();
  testWhere();
}

void testAggregate() {
  var source1 = [1, 0, 0, 0, 0];
  var expected = 16;
  var result = new Collection(source1).aggregate((r, e) => r + r);
  expect(result, expected, reason: "aggregate()");
  //
  source1 = [1, 2, 3, 4];
  expected = 10;
  result = new Collection(source1).aggregate((r, e) => r + e);
  expect(result, expected, reason: "aggregate()");
  //
  source1 = ["a", "b", "c", "d"];
  expected = "a, b, c, d";
  result = new Collection(source1).aggregate((r, e) => "$r, $e");
  expect(result, expected, reason: "aggregate()");
  //
  source1 = [10, 20, 30, 40];
  expected = 1200000;
  result = new Collection(source1).aggregate((r, e) => r * e, 5);
  expect(result, expected, reason: "aggregate()");
  //
  source1 = [];
  expected = 41;
  result = new Collection(source1).aggregate((r, e) => r + e, 41);
  expect(result, expected, reason: "aggregate()");
}

void testAll() {
  var source1 = [];
  var expected = true;
  var result = new Collection(source1).all((e) => e == 0);
  expect(result, expected, reason: "all()");
  //
  source1 = [0];
  expected = true;
  result = new Collection(source1).all((e) => e == 0);
  expect(result, expected, reason: "all()");
  //
  source1 = [0, 1];
  expected = false;
  result = new Collection(source1).all((e) => e == 0);
  expect(result, expected, reason: "all()");
}

void testAny() {
  var source1 = [];
  var expected = false;
  var result = new Collection(source1).any();
  expect(result, expected, reason: "any()");
  //
  source1 = [0];
  expected = true;
  result = new Collection(source1).any();
  expect(result, expected, reason: "any()");
  //
  source1 = [0];
  expected = true;
  result = new Collection(source1).any((e) => e == 0);
  expect(result, expected, reason: "any()");
  //
  source1 = [0];
  expected = false;
  result = new Collection(source1).any((e) => e != 0);
  expect(result, expected, reason: "any()");
  //
  source1 = [1, 0];
  expected = true;
  result = new Collection(source1).any((e) => e == 0);
  expect(result, expected, reason: "any()");
  //
  source1 = [0, 0];
  expected = false;
  result = new Collection(source1).any((e) => e != 0);
  expect(result, expected, reason: "any()");
}

void testAverage() {
  var source1 = [0, 1, 2, 3, 4];
  var expected = 2.0;
  var result = new Collection(source1).average();
  expect(result, expected, reason: "average()");
  //
  result = new Collection(source1).average((e) => e * 10);
  expected = 20.0;
  expect(result, expected, reason: "average()");
}

void testCast() {
  var source = [0, 1, 2, 3, 4];
  var expected = source;
  var query = new Collection(source).cast();
  var list = query.toList();
  expect(list, expected, reason: "cast()");
}

void testConcat() {
  var source1 = [0, 1, 2, 3, 4];
  var source2 = new Collection([5, 6, 7, 8, 9]);
  var expected = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
  var query = new Collection(source1).concat(source2);
  var list = query.toList();
  expect(list, expected, reason: "concat()");
  //
  source1 = [];
  source2 = new Collection([]);
  expected = [];
  query = new Collection(source1).concat(source2);
  list = query.toList();
  expect(list, expected, reason: "concat()");
}

void testContains() {
  var source1 = [0, 1, 2, 3, 4];
  var expected = true;
  var result = new Collection(source1).contains(2);
  expect(result, expected, reason: "contains()");
  //
  result = new Collection(source1).contains(5);
  expected = false;
  expect(result, expected, reason: "contains()");
  //
  source1 = [];
  result = new Collection(source1).contains(null);
  expected = false;
  expect(result, expected, reason: "contains()");
}

void testCount() {
  var source1 = [0, 1, 2, 3, 4];
  var expected = 5;
  var result = new Collection(source1).count();
  expect(result, expected, reason: "count()");
  //
  result = new Collection(source1).count((e) => e > 0);
  expected = 4;
  expect(result, expected, reason: "count()");
}

void testDefaultIfEmpty() {
  var source = [];
  var expected = [41];
  var query = new Collection(source).defaultIfEmpty(41);
  var list = query.toList();
  expect(list, expected, reason: "defaultIfEmpty()");
  //
  source = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
  expected = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
  query = new Collection(source).defaultIfEmpty(41);
  list = query.toList();
  expect(list, expected, reason: "defaultIfEmpty()");
}

void testDistinct() {
  var source = [0, 1, 2, 3, 4, 3, 2, 1, 0];
  var expected = [0, 1, 2, 3, 4];
  var query = new Collection(source).distinct();
  var list = query.toList();
  expect(list, expected, reason: "distinct()");
  //
  source = [];
  expected = [];
  query = new Collection(source).distinct();
  list = query.toList();
  expect(list, expected, reason: "distinct()");
}

void testElementAt() {
  var source1 = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
  var expected = 5;
  var result = new Collection(source1).elementAt(5);
  expect(result, expected, reason: "elementAt()");
  //
  expected = 5;
  result = IQueryable.range(0, 10).elementAt(5);
  expect(result, expected, reason: "elementAt()");
}

void testElementAtOrDefault() {
  var source1 = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
  var expected = 5;
  var result = new Collection(source1).elementAtOrDefault(5);
  expect(result, expected, reason: "elementAt()");
  //
  expected = 5;
  result = IQueryable.range(0, 10).elementAtOrDefault(5);
  expect(result, expected, reason: "elementAt()");
  //
  source1 = [];
  expected = null;
  result = new Collection(source1).elementAtOrDefault(5);
  expect(result, expected, reason: "elementAt()");
}

void testExcept() {
  var source1 = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
  var source2 = new Collection([3, 4, 5, 6]);
  var expected = [0, 1, 2, 7, 8, 9];
  var query = new Collection(source1).except(source2);
  var list = query.toList();
  expect(list, expected, reason: "except()");
  //
  source1 = [];
  source2 = new Collection([]);
  expected = [];
  query = new Collection(source1).except(source2);
  list = query.toList();
  expect(list, expected, reason: "except()");
}

void testFirst() {
  var source1 = [0, 1];
  var expected = 0;
  var result = new Collection(source1).first();
  expect(result, expected, reason: "first()");
  //
  source1 = [0, 1];
  expected = 1;
  result = new Collection(source1).first((e) => e > 0);
  expect(result, expected, reason: "first()");
}

void testFirstOrDefault() {
  var source1 = [0, 1];
  var expected = 0;
  var result = new Collection(source1).firstOrDefault();
  expect(result, expected, reason: "firstOrDefault()");
  //
  source1 = [0, 1];
  expected = 1;
  result = new Collection(source1).firstOrDefault((e) => e > 0);
  expect(result, expected, reason: "firstOrDefault()");
  //
  source1 = [];
  expected = null;
  result = new Collection(source1).firstOrDefault();
  expect(result, expected, reason: "firstOrDefault()");
  //
  source1 = [];
  expected = null;
  result = new Collection(source1).firstOrDefault((e) => e > 0);
  expect(result, expected, reason: "firstOrDefault()");
  //
  source1 = [0, 1];
  expected = null;
  result = new Collection(source1).firstOrDefault((e) => e > 1);
  expect(result, expected, reason: "firstOrDefault()");
}

void testGroupBy() {
  var query = new Collection(children).groupBy((c) => c.parent);
  var expected = {a : [a1], b : [b1, b2], c : [c1, c2, c3]};
  var list = query.toList();
  var result = {};
  for(var group in list) {
    result[group.key] = [];
    for(Child child in group) {
      result[group.key].add(child);
    }
  }

  var actual = result;
  expect(actual, expected, reason: "groupBy()");
}

void testGroupJoin() {
  var query = new Collection(parents).groupJoin(new Collection(children), (p) => p, (c) => c.parent, (p, childern) => childern.toList());
  var expected = [[a1], [b1, b2], [c1, c2, c3]];
  var list = query.toList();
  expect(list, expected, reason: "groupJoin()");
}

void testIntersect() {
  var source1 = [0, 1, 2, 3, 4, 3, 2, 1, 0];
  var source2 = new Collection([5, 4, 2]);
  var expected = [4, 2];
  var query = new Collection(source1).intersect(source2);
  var list = query.toList();
  expect(list, expected, reason: "intersect()");
  //
  source1 = [];
  source2 = new Collection([]);
  expected = [];
  query = new Collection(source1).intersect(source2);
  list = query.toList();
  expect(list, expected, reason: "intersect()");
}

void testJoin() {
  var query = new Collection(parents).join(new Collection(children), (p) => p, (c) => c.parent, (p, c) => c);
  var expected = [a1, b1, b2, c1, c2, c3];
  var list = query.toList();
  expect(list, expected, reason: "join()");
}

void testLast() {
  var source1 = [0, 1];
  var expected = 1;
  var result = new Collection(source1).last();
  expect(result, expected, reason: "last()");
  //
  source1 = [0, 1, 2 ,3];
  expected = 3;
  result = new Collection(source1).last((e) => e > 0);
  expect(result, expected, reason: "last()");
}

void testLastOrDefault() {
  var source1 = [0, 1];
  var expected = 1;
  var result = new Collection(source1).lastOrDefault();
  expect(result, expected, reason: "lastOrDefault()");
  //
  source1 = [0, 1, 2, 3];
  expected = 3;
  result = new Collection(source1).lastOrDefault((e) => e > 0);
  expect(result, expected, reason: "lastOrDefault()");
  //
  source1 = [];
  expected = null;
  result = new Collection(source1).lastOrDefault();
  expect(result, expected, reason: "lastOrDefault()");
  //
  source1 = [];
  expected = null;
  result = new Collection(source1).lastOrDefault((e) => e > 0);
  expect(result, expected, reason: "lastOrDefault()");
  //
  source1 = [0, 1];
  expected = null;
  result = new Collection(source1).lastOrDefault((e) => e > 1);
  expect(result, expected, reason: "lastOrDefault()");
}

void testMax() {
  var source1 = [4, 3, 2, 1, 0];
  var expected = 4;
  var result = new Collection(source1).max();
  expect(result, expected, reason: "max()");
  //
  source1 = [4, 3, 2, 1];
  expected = 40;
  result = new Collection(source1).max((e) => e * 10);
  expect(result, expected, reason: "max()");
  //
  source1 = [1, null, -5];
  result = new Collection(source1).max();
  expected = 1;
  expect(result, expected, reason: "max()");
  //
  source1 = [];
  result = new Collection(source1).max();
  expected = null;
  expect(result, expected, reason: "max()");
}

void testMin() {
  var source1 = [4, 3, 2, 1, 0];
  var expected = 0;
  var result = new Collection(source1).min();
  expect(result, expected, reason: "min()");
  //
  source1 = [4, 3, 2, 1];
  expected = 10;
  result = new Collection(source1).min((e) => e * 10);
  expect(result, expected, reason: "min()");
  //
  source1 = [1, null, -5];
  result = new Collection(source1).min();
  expected = -5;
  expect(result, expected, reason: "min()");
  //
  source1 = [];
  result = new Collection(source1).min();
  expected = null;
  expect(result, expected, reason: "min()");
}

void testOfType() {
  var source = [0, 1, 2, 3, 4];
  var expected = source;
  var query = new Collection(source).ofType();
  var list = query.toList();
  expect(list, expected, reason: "cast()");
}

void testOrderBy() {
  var length = 500;
  var source = new List<int>(length);
  var expected = new List<int>(length);
  for(var i = 0; i < length; i++) {
    source[i] = length - i - 1;
    expected[i] = i;
  }

  var query = new Collection(source).orderBy((int e) => e);
  var list = query.toList();
  expect(list, expected, reason: "orderBy()");

  length = 500;
  source = new List<int>(length);
  expected = new List<int>(length);
  for(var i = 0; i < length; i++) {
    source[i] = i;
    expected[i] = length - i - 1;
  }

  query = new Collection(source).orderByDescending((int e) => e);
  list = query.toList();
  expect(list, expected, reason: "orderBy()");
}

void testRange() {
  var expected = [-5, -4, -3, -2, -1, 0, 1, 2, 3, 4];
  var query = IQueryable.range(-5, 10);
  var list = query.toList();
  expect(list, expected, reason: "range()");
  //
  expected = <int>[];
  query = IQueryable.range(100, 0);
  list = query.toList();
  expect(list, expected, reason: "range(");
}

void testRepeat() {
  var expected = [-5, -5, -5, -5, -5, -5, -5, -5, -5, -5];
  var query = IQueryable.repeat(-5, 10);
  var list = query.toList();
  expect(list, expected, reason: "repeat()");
  //
  expected = <int>[];
  query = IQueryable.repeat(100, 0);
  list = query.toList();
  expect(list, expected, reason: "repeat(");
}

void testSelect() {
  var source = [0, 1, 2, 3, 4, 3, 2, 1, 0];
  var expected = [0, 10, 20, 30, 40, 30, 20, 10, 0];
  var query = new Collection(source).select((e) => e * 10);
  var list = query.toList();
  expect(list, expected, reason: "select()");
  //
  source = [];
  expected = [];
  query = new Collection(source).select((e) => e);
  list = query.toList();
  expect(list, expected, reason: "select()");
}

void testSelectMany() {
  var source = [[0], [1, 2], [3, 4, 5]];
  var expected = [0, 1, 2, 3, 4, 5];
  var query = new Collection(source).selectMany((e) => new Collection(e));
  var list = query.toList();
  expect(list, expected, reason: "selectMany()");
  //
  source = [];
  expected = [];
  query = new Collection(source).selectMany((e) => new Collection(e));
  list = query.toList();
  expect(list, expected, reason: "selectMany(");
}

void testSingle() {
  var source = [0];
  var expected = 0;
  var result = new Collection(source).single();
  expect(result, expected, reason: "single()");
  //
  source = [0, 10, 20, 30];
  expected = 20;
  result = new Collection(source).single((e) => e > 10 && e < 30);
  expect(result, expected, reason: "single()");
  //
  var exception;
  try {
    new Collection([]).single();
  } catch(e) {
    exception = e;
  }

  expect(exception != null, true, reason: "single()");
  //
  exception = null;
  try {
    new Collection([0]).single((e) => e == 1);
  } catch(e) {
    exception = e;
  }

  expect(exception != null, true, reason: "single()");
}

void testSingleOrDefault() {
  var source = [0];
  var expected = 0;
  var result = new Collection(source).singleOrDefault();
  expect(result, expected, reason: "singleOrDefault()");
  source = [0, 10, 20, 30];
  expected = 20;
  //
  result = new Collection(source).singleOrDefault((e) => e > 10 && e < 30);
  expect(result, expected, reason: "singleOrDefault()");
  expected = null;
  //
  result = new Collection(source).singleOrDefault((e) => e > 100);
  expect(result, expected, reason: "singleOrDefault()");
  //
  source = [];
  expected = null;
  result = new Collection(source).singleOrDefault((e) => e > 10 && e < 30);
  expect(result, expected, reason: "singleOrDefault()");
}

void testSkip() {
  var source = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
  var expected = [5, 6, 7, 8, 9];
  var query = new Collection(source).skip(5);
  var list = query.toList();
  expect(list, expected, reason: "skip()");
  //
  expected = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
  query = new Collection(source).skip(0);
  list = query.toList();
  expect(list, expected, reason: "skip()");
}

void testSkipWhile() {
  var source = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
  var expected = [5, 6, 7, 8, 9];
  var query = new Collection(source).skipWhile((e) => e != 5);
  var list = query.toList();
  expect(list, expected, reason: "skipWhile()");
  //
  expected = source;
  query = new Collection(source).skipWhile((e) => false);
  list = query.toList();
  expect(list, expected, reason: "skipWhile()");
}

void testSum() {
  var source1 = [0, 1, 2, 3, 4];
  var expected = 10;
  var result = new Collection(source1).sum();
  expect(result, expected, reason: "sum()");
  //
  result = new Collection(source1).sum((e) => e * 10);
  expected = 100;
  expect(result, expected, reason: "sum()");
  //
  source1 = [];
  result = new Collection(source1).sum();
  expected = null;
  expect(result, expected, reason: "sum()");
}

void testTake() {
  var source = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
  var expected = [0, 1, 2, 3, 4];
  var query = new Collection(source).take(5);
  var list = query.toList();
  expect(list, expected, reason: "take()");
  //
  expected = [];
  query = new Collection(source).take(0);
  list = query.toList();
  expect(list, expected, reason: "take()");
}

void testTakeWhile() {
  var source = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
  var expected = [0, 1, 2, 3, 4];
  var query = new Collection(source).takeWhile((e) => e < 5);
  var list = query.toList();
  expect(list, expected, reason: "takeWhile()");
  //
  expected = source;
  query = new Collection(source).takeWhile((e) => true);
  list = query.toList();
  expect(list, expected, reason: "takeWhile()");
}

void testThenBy() {
  var source = ["grape", "passionfruit", "banana", "mango", "orange", "raspberry", "apple", "blueberry"];
  var expected = ["apple", "grape", "mango", "banana", "orange", "blueberry", "raspberry", "passionfruit"];
  var query = new Collection(source).orderBy((s) => s.length).thenBy((s) => s);
  var list = query.toList();
  expect(list, expected, reason: "thenBy()");
  //
  expected = ["passionfruit", "raspberry", "blueberry", "orange", "banana", "mango", "grape", "apple"];
  query = new Collection(source).orderByDescending((s) => s.length).thenByDescending((s) => s);
  list = query.toList();
  expect(list, expected, reason: "thenBy()");
}

void testToLookup() {
  var lookup = new Collection(children).toLookup((c) => c.parent, (c) => c);
  var expected = {a : [a1], b : [b1, b2], c : [c1, c2, c3]};
  var list = lookup.toList();
  var result = {};
  for(var group in list) {
    result[group.key] = [];
    for(Child child in group) {
      result[group.key].add(child);
    }
  }

  var actual = result;
  expect(actual, expected, reason: "groupBy()");
}

void testToMap() {
  var query = new Collection(children).toLookup((c) => c.parent, (c) => c);
  var expected = {a : [a1], b : [b1, b2], c : [c1, c2, c3]};
  var list = query.toList();
  var result = {};
  for(var group in list) {
    result[group.key] = [];
    for(Child child in group) {
      result[group.key].add(child);
    }
  }

  var actual = result;
  expect(actual, expected, reason: "groupBy()");
}

void testUnion() {
  var source1 = [0, 1, 2, 3, 4, 0, 1, 2, 3, 4];
  var source2 = new Collection([5, 6, 7, 8, 9, 5, 6, 7, 8, 9]);
  var expected = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
  var query = new Collection(source1).union(source2);
  var list = query.toList();
  expect(list, expected, reason: "union()");
  //
  source1 = [0, 1, 2, 3, 4, 0, 1, 2, 3, 4];
  source2 = new Collection([]);
  expected = [0, 1, 2, 3, 4];
  query = new Collection(source1).union(source2);
  list = query.toList();
  expect(list, expected, reason: "union()");
}

void testWhere() {
  var source = [0, 1, 2, 3, 4, 3, 2, 1, 0];
  var expected = [0, 1, 2, 2, 1, 0];
  var query = new Collection(source).where((e) => e < 3);
  var list = query.toList();
  expect(list, expected, reason: "where()");
  //
  expected = source;
  query = new Collection(source).where((e) => true);
  list = query.toList();
  expect(list, expected, reason: "where()");
}

final Parent a = new Parent("a");
final Parent b = new Parent("b");
final Parent c = new Parent("c");
final Child a1 = new Child("a1", a);
final Child b1 = new Child("a1", b);
final Child b2 = new Child("b1", b);
final Child c1 = new Child("b2", c);
final Child c2 = new Child("c1", c);
final Child c3 = new Child("c2", c);
final List<Child> children = <Child>[a1, b1, b2, c1 ,c2 ,c3];
final List<Parent> parents = <Parent>[a, b, c];

List getList(Iterator iterator) {
  var list = [];
  while(iterator.moveNext()) {
    list.add(iterator.current);
  }

  return list;
}

class Parent {
  String name;
  Parent(this.name);
  String toString() => name;
}

class Child {
  Parent parent;
  String name;
  Child(this.name, this.parent);
  String toString() => name;
}

class TypeOf<T> {
  Type get type => T;
}
