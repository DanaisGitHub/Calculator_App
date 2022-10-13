import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorLogic extends ChangeNotifier {
  final Parser _p = Parser();
  String input = "";
  List<String> equationHistory = [""];
  //int length = equationHistory.length;

  String get userInput {
    return input;
  }

  void setUserInput(String additionalInput) {
    if (additionalInput == "." && input.endsWith(".") ||
        additionalInput == "/" && input.endsWith("/") ||
        additionalInput == "*" && input.endsWith("*") ||
        additionalInput == "-" && input.endsWith("-") ||
        additionalInput == "+" && input.endsWith("+")) {
      // to make sure only one entry goes through
      return;
    }
    input += additionalInput;
    notifyListeners();
  }

  List<String> get getEquationHistory {
    return equationHistory; // should we send copy of history insead of acctual location
  }

  void clearUserInput() {
    input = "";
    notifyListeners();
  }

  void backspace() {
    if (input == "Error" || input == "Syntax Error") {
      input = "";
      notifyListeners();
      return;
    }
    final int length = input.length;
    if (length > 0) {
      input = input.substring(0, length - 1);
      notifyListeners();
    }
  }

  void clearAll() {
    input = "";
    equationHistory = [""];
    notifyListeners();
  }

  void equalsPressed() {
    if (input.endsWith("/") ||
        input.endsWith(".") ||
        input.endsWith("*") ||
        input.endsWith("-") ||
        input.startsWith("+") ||
        input.startsWith("/") ||
        input.startsWith(".") ||
        input.startsWith("*") ||
        input.startsWith("-") ||
        input.startsWith("+") 
        ) {
      // to make sure only one entry goes through
      input = "Syntax Error";
      notifyListeners();
      return;
    }
    try {
      
      ContextModel cm = ContextModel();
      Expression exp = _p.parse(input);
      String result = exp.evaluate(EvaluationType.REAL, cm).toString();
      equationHistory.insert(0,input);
      input = result;
      
      notifyListeners();
    } catch (e) {
      input = "Error";
      notifyListeners();
    }
  }
}
