import 'package:math_expressions/math_expressions.dart';

String calculateAnswer(String userInput) {
  String finalInput = userInput;
  finalInput = finalInput.replaceAll('x', '*');
  finalInput = finalInput.replaceAll('÷', '/');

  if (isOperator(userInput[0]) || isOperator(userInput[userInput.length - 1])) {
    return 'Error';
  }

  try {
    Parser p = Parser();
    Expression exp = p.parse(finalInput);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    if (eval.isNaN || eval.isInfinite) {
      return 'Error';
    } else {
      return eval.toString();
    }
  } catch (e) {
    return 'Error';
  }
}

bool isOperator(String x) {
  return x == '%' || x == 'x' || x == '-' || x == '+' || x == '=' || x == '÷';
}
