part of queries.expressions;

abstract class ExpressionVisitor {
  Expression visit(Expression node);

  Expression visitConstant(ConstantExpression node);

  Expression visitExtension(Expression node);

  Expression visitLambda(LambdaExpression node);

  Expression visitMethodCall(MethodCallExpression node);
}
