import 'package:math_expressions/math_expressions.dart';
import 'package:rxdart/rxdart.dart';

class ExpressionBloc {
  BehaviorSubject<String> _userInput = BehaviorSubject();

  ValueObservable<String> get current => _userInput.stream;

  ValueObservable<double> get result {
    return _userInput.map((userInput) {
      final parser = Parser();
      final expr = parser.parse(userInput);
      return expr.evaluate(EvaluationType.REAL, ContextModel());
    }).shareValue();
  }

  void eval() {
    _userInput.add(result.value.toString());
  }

  void concat(String s) {
    final value = _userInput.value;
    if (value != null) {
      _userInput.add(value + s);
    } else {
      _userInput.add(s);
    }
  }

  void clear() {
    _userInput.add(null);
  }

  void dispose() {
    _userInput.close();
  }
}
