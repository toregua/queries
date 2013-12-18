part of queries.expressions;

class ExpressionType {
  static const ExpressionType CALL = const ExpressionType("CALL");

  static const ExpressionType CONSTANT = const ExpressionType("CONSTANT");

  static const ExpressionType LAMBDA = const ExpressionType("LAMBDA");

  final String name;

  const ExpressionType(this.name);

  static ReadOnlyDictionary<String, ExpressionType> get values {
    var dictionary = new Dictionary.fromMap({
      CALL.name : CALL,
      CONSTANT.name : CONSTANT,
      LAMBDA.name : LAMBDA
    });

    return new ReadOnlyDictionary(dictionary);
  }
}
