part of queries.expressions;

abstract class Expression {
  Expression() {
    throw new UnimplementedError("Expressions stil in development");
  }

  ExpressionType get nodeType;

  TypeInfo get type;

  static ConstantExpression constant(dynamic value) {
    var expr = new ConstantExpression();
    expr._type = typeInfo(value.runtimeType);
    expr._value = value;
    return expr;
  }

  static MethodCallExpression methodCall(Expression instance, MethodInfo method, List positionalArguments, [Map<Symbol, dynamic> namedArguments]) {
    if(method == null) {
      throw new ArgumentError("method: $method");
    }

    if(instance == null && !method.isStatic) {
      throw new ArgumentError("$instance: $instance");
    }

    if(positionalArguments == null) {
      throw new ArgumentError("positionalArguments: $positionalArguments");
    }

    if(namedArguments == null) {
      namedArguments = {};
    }

    var expr = new MethodCallExpression();
    if(instance != null) {
      if(!instance.type.isAssignableFrom(method.declaringType)) {
        var instanceType = SymbolHelper.getName(instance.type.simpleName);
        var declaringType = SymbolHelper.getName(method.declaringType.simpleName);
        var methodName = SymbolHelper.getName(method.simpleName);
        throw new ArgumentError("Instance type '$instanceType' is not assignable to the declaring type '$declaringType' of the method '$methodName'");
      }
    }

    _checkMethodArguments(method, positionalArguments, namedArguments);
    expr._method = method;
    expr._namedArguments = new ReadOnlyDictionary(new Dictionary.fromMap(namedArguments));
    expr._object = instance;
    expr._positionalArguments = new ReadOnlyCollection(positionalArguments);
    expr._type = method.returnType;
    return expr;
  }

  Expression accept(ExpressionVisitor visitor);

  Expression visitChildren(ExpressionVisitor visitor);

  static void _checkMethodArguments(MethodInfo method, List positionalArguments, [Map<Symbol, dynamic> namedArguments]) {
  }
}

class ConstantExpression extends Expression {
  TypeInfo _type;

  dynamic _value;

  ExpressionType get nodeType => ExpressionType.CONSTANT;

  TypeInfo get type => _type;

  dynamic get value => _value;

  Expression accept(ExpressionVisitor visitor) {
    return visitor.visitConstant(this);
  }

  Expression visitChildren(ExpressionVisitor visitor) {
    return this;
  }
}

class LambdaExpression<Func extends Function> extends Expression {
  Expression _body;

  String _name;

  ReadOnlyDictionary<Symbol, Expression> _namedArguments;

  ReadOnlyCollection<Expression> _positionalArguments;

  TypeInfo _returnType;

  TypeInfo _type;

  Expression get body => _body;

  ExpressionType get nodeType => ExpressionType.LAMBDA;

  String  get name => _name;

  ReadOnlyDictionary<Symbol, Expression> get namedArguments => _namedArguments;

  ReadOnlyCollection<Expression> get positionalArguments => _positionalArguments;

  TypeInfo get returnType => _returnType;

  TypeInfo get type => _type;

  Expression accept(ExpressionVisitor visitor) {
    return visitor.visitLambda(this);
  }

  Expression visitChildren(ExpressionVisitor visitor) {
    for(var argument in _positionalArguments) {
      argument.accept(visitor);
    }

    for(var argument in _namedArguments) {
      argument.value.accept(visitor);
    }

    _body.accept(visitor);
    return this;
  }

  static LambdaExpression build(Function function) {
    if(function == null) {
      return null;
    }

    var mirror = objectInfo(function).mirror;
  }
}

class MethodCallExpression extends Expression {
  MethodInfo _method;

  ReadOnlyDictionary<Symbol, Expression> _namedArguments;

  Expression _object;

  TypeInfo _type;

  ReadOnlyCollection<Expression> _positionalArguments;

  MethodInfo get method => _method;

  ReadOnlyDictionary<Symbol, Expression> get namedArguments => _namedArguments;

  ExpressionType get nodeType => ExpressionType.CALL;

  Expression get object => _object;

  ReadOnlyCollection<Expression> get positionalArguments => _positionalArguments;

  TypeInfo get type => _type;

  Expression accept(ExpressionVisitor visitor) {
    return visitor.visitMethodCall(this);
  }

  Expression visitChildren(ExpressionVisitor visitor) {
    if(_object != null) {
      _object.accept(visitor);
    }

    for(var argument in _positionalArguments) {
      argument.accept(visitor);
    }

    for(var argument in _namedArguments) {
      argument.value.accept(visitor);
    }

    return this;
  }
}
