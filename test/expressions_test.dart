import 'package:flutter_test/flutter_test.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  test('Catch evaluation error', () async {
    eval() {
      Parser p = new Parser();
      Expression expr = p.parse("3.1#@#2.9 * 7.12");
      expr.evaluate(EvaluationType.REAL, ContextModel());
    }

    expect(eval, throwsA(isStateError));
  });

  test('Evaluate expression', () async {
    Parser parser = new Parser();
    Expression expr = parser.parse("3.1 + 2.9 * 7.12");
    double eval = expr.evaluate(EvaluationType.REAL, ContextModel());

    expect(eval, equals(23.748));
  });
}
