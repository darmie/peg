part of peg.frontend_analyzer.frontend_analyzer;

class StartCharactersResolver extends ExpressionResolver {
  Object visitAndPredicate(AndPredicateExpression expression) {
    _visitChild(expression);
    return null;
  }

  Object visitAnyCharacter(AnyCharacterExpression expression) {
    if (expression.level == 0) {
      expression.startCharacters.addGroup(Expression.unicodeGroup);
    }

    return null;
  }

  Object visitCharacterClass(CharacterClassExpression expression) {
    if (expression.level == 0) {
      var startCharacters = expression.startCharacters;
      for (var group in expression.ranges.groups) {
        startCharacters.addGroup(group);
      }
    }

    return null;
  }

  Object visitLiteral(LiteralExpression expression) {
    if (expression.level == 0) {
      var text = expression.text;
      if (text.isEmpty) {
        expression.startCharacters.addGroup(Expression.unicodeGroup);
      } else {
        var charCode = text.codeUnits[0];
        var group = new GroupedRangeList<bool>(charCode, charCode, true);
        expression.startCharacters.addGroup(group);
      }
    }

    return null;
  }

  Object visitNotPredicate(NotPredicateExpression expression) {
    var child = expression.expression;
    child.accept(this);
    var next = _getNextExpression(expression);
    var startCharacters = expression.startCharacters;
    if (next == null) {
      startCharacters.addGroup(Expression.unicodeGroup);
    } else {
      for (var group in next.startCharacters.groups) {
        startCharacters.addGroup(group);
      }
    }

    return null;
  }

  Object visitOneOrMore(OneOrMoreExpression expression) {
    _visitChild(expression);
    return null;
  }

  Object visitOptional(OptionalExpression expression) {
    var next = _getNextExpression(expression);
    if (next != null) {
      _applyData(next, expression);
    }

    _visitChild(expression);
    return null;
  }

  Object visitOrderedChoice(OrderedChoiceExpression expression) {
    if (processed.contains(expression)) {
      return null;
    }

    processed.add(expression);
    for (var child in expression.expressions) {
      child.accept(this);
      _applyData(child, expression);
    }

    processed.remove(expression);
    return null;
  }

  Object visitRule(RuleExpression expression) {
    var rule = expression.rule;
    if (rule != null) {
      var ruleExpression = rule.expression;
      ruleExpression.accept(this);
      _applyData(ruleExpression, expression);
    }

    return null;
  }

  Object visitSequence(SequenceExpression expression) {
    var skip = false;
    for (var child in expression.expressions) {
      child.accept(this);
      if (!skip) {
        _applyData(child, expression);
        if (!child.isOptional) {
          skip = true;
        }
      }
    }

    return null;
  }

  Object visitZeroOrMore(ZeroOrMoreExpression expression) {
    var next = _getNextExpression(expression);
    if (next != null) {
      _applyData(next, expression);
    }

    _visitChild(expression);
    return null;
  }

  Object _applyData(Expression from, Expression to) {
    var startCharacters = to.startCharacters;
    for (var group in from.startCharacters.groups) {
      startCharacters.addGroup(group);
    }

    return null;
  }

  Expression _getNextExpression(Expression expression) {
    var parent = expression.parent;
    if (parent is SequenceExpression) {
      var position = expression.positionInSequence;
      if (position < parent.expressions.length - 1) {
        return parent.expressions[position + 1];
      } else if (parent.parent is OrderedChoiceExpression) {
        return _getNextExpression(parent.parent);
      }
    }

    return null;
  }

  Object _visitChild(UnaryExpression expression) {
    var child = expression.expression;
    child.accept(this);
    return _applyData(child, expression);
  }
}
