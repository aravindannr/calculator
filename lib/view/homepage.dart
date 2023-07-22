import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import '../constants.dart';
import '../widgets/Mybuttons.dart';

class Homepage extends StatefulWidget {
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  var userInput = '';
  var answer = '';
  final List<String> buttons = [
    'C',
    'DEL',
    '%',
    '÷',
    '7',
    '8',
    '9',
    'x',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    '0',
    '.',
    'ANS',
    '='
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        userInput,
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        answer,
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: GridView.builder(
                  itemCount: buttons.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return MyButton(
                        onPressed: () {
                          setState(() {
                            userInput = '';
                            answer = '';
                          });
                        },
                        buttonText: buttons[index],
                        color: green,
                        textColor: white,
                      );
                    } else if (index == 1) {
                      return MyButton(
                        onPressed: () {
                          setState(() {
                            if (userInput.isNotEmpty) {
                              userInput =
                                  userInput.substring(0, userInput.length - 1);
                            }
                          });
                        },
                        buttonText: buttons[index],
                        color: red,
                        textColor: white,
                      );
                    } else if (index == buttons.length - 1) {
                      return MyButton(
                        onPressed: () {
                          setState(() {
                            calculateAnswer();
                          });
                        },
                        buttonText: buttons[index],
                        color: blueGrey,
                        textColor: white,
                      );
                    } else if (index == 2) {
                      return MyButton(
                        onPressed: () {
                          setState(() {
                            if (userInput.isNotEmpty) {
                              double percentage =
                                  double.tryParse(userInput) ?? 0.0;
                              percentage /= 100;
                              userInput = percentage.toString();
                            }
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.blueGrey,
                        textColor: white,
                      );
                    }
                    return MyButton(
                      onPressed: () {
                        setState(() {
                          if (buttons[index] == '=') {
                            calculateAnswer();
                          } else if (buttons[index] == 'ANS') {
                            userInput += answer;
                          } else {
                            if (userInput.isNotEmpty &&
                                isOperator(userInput[userInput.length - 1]) &&
                                isOperator(buttons[index])) {
                              userInput =
                                  userInput.substring(0, userInput.length - 1);
                            }
                            userInput += buttons[index];
                          }
                        });
                      },
                      buttonText: buttons[index],
                      textColor: isOperator(buttons[index])
                          ? Colors.white
                          : blueGrey,
                      color: isOperator(buttons[index])
                          ? blueGrey
                          : blueGrey[100]!,
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool isOperator(String x) {
    return x == '%' || x == 'x' || x == '-' || x == '+' || x == '=' || x == '÷';
  }

  void calculateAnswer() {
    String finalInput = userInput;
    finalInput = finalInput.replaceAll('x', '*');
    finalInput = finalInput.replaceAll('÷', '/');

    if (isOperator(userInput[0]) ||
        isOperator(userInput[userInput.length - 1])) {
      answer = 'Error';
      return;
    }

    try {
      Parser p = Parser();
      Expression exp = p.parse(finalInput);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      if (eval.isNaN || eval.isInfinite) {
        answer = 'Error';
      } else {
        answer = eval.toString();
      }
    } catch (e) {
      answer = 'Error';
    }
  }
}
