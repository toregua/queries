part of queries;

abstract class IQueryProvider {
  IQueryable createQuery(Expression expression);

  dynamic execute(Expression expression);
}
