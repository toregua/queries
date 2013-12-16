import 'package:queries/collections.dart';
import 'package:queries/queries.dart';
import 'package:unittest/unittest.dart';

void main() {
  testCollection();
  testDictionary();
}

void testCollection() {
  var list = new List(5);
  var collection = IQueryable.range(0, 5).toCollection();
  collection.copyTo(list, 4);
}

void testDictionary() {
  var map = {0 : [0], 1 : [0, 10], 2 : [0, 10, 20, 30]};
  var dictionary = new Dictionary<int, List<int>>.fromMap(map);
  var query = dictionary.groupBy((kv) => kv.key).select((g) => {g.key : g.sum((e) => new Collection(e.value).sum((e) => e))});
  var list = query.toList();
  var expected = [{0: 0}, {1: 10}, {2: 60}];
  expect(list, expected, reason : "Dictionary");
  //
  query = dictionary.groupBy((kv) => kv.key).select((g) => [g.key]..addAll(g.select((e) => e.value).asIterable()));
  list = query.toList();
  expected = [[0, [0]], [1, [0, 10]], [2, [0, 10, 20, 30]]];
  expect(list, expected, reason : "Dictionary");
  //
  var values = dictionary.values.selectMany((v) => new Collection(v));
  query = values.orderBy((v) => v);
  list = query.toList();
  expected = [0, 0, 0, 10, 10, 20, 30];

  var keys = dictionary.keys;
}
