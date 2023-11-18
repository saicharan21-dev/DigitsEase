import 'package:calculator_application/buttons.dart';
import 'package:flutter/material.dart';

import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(calculatorAppWidget());
}

class calculatorAppWidget extends StatefulWidget {
  const calculatorAppWidget({Key? key}) : super(key: key);

  @override
  State<calculatorAppWidget> createState() => _calculatorAppWidget();
}

class _calculatorAppWidget extends State<calculatorAppWidget> {
  var userQuestion = '';
  var userAnswer = '';
  final myTextStyle =
      TextStyle(fontSize: 30, color: Colors.deepPurple.shade500);
  final List<String> buttons = [
    'C',
    'DEL',
    '%',
    '/',
    '9',
    '8',
    '7',
    'x',
    '6',
    '5',
    '4',
    '-',
    '3',
    '2',
    '1',
    '+',
    '0',
    '.',
    'ANS',
    '=',
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            backgroundColor: Colors.deepPurple.shade100,
            body: Column(
              children: [
                Expanded(
                    child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Container(
                          padding: EdgeInsets.all(20),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            userQuestion,
                            style: TextStyle(fontSize: 20),
                          )),
                      Container(
                          padding: EdgeInsets.all(20),
                          alignment: Alignment.centerRight,
                          child:
                              Text(userAnswer, style: TextStyle(fontSize: 20)))
                    ],
                  ),
                )),
                Expanded(
                  flex: 2,
                  child: Container(
                      child: GridView.builder(
                    itemCount: buttons.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4),
                    itemBuilder: (BuildContext context, int index) {
                      if (index == 0) {
                        return MyButtonWidget(
                          buttonTapped: () {
                            setState(() {
                              userQuestion = '';
                              userAnswer = '';
                            });
                          },
                          buttonText: buttons[index],
                          textColor: Colors.white,
                          color: Colors.blueGrey,
                        );
                      } else if (index == 1) {
                        return MyButtonWidget(
                          buttonTapped: () {
                            setState(() {
                              userQuestion = userQuestion.substring(
                                  0, userQuestion.length - 1);
                            });
                          },
                          buttonText: buttons[index],
                          textColor: Colors.white,
                          color: Colors.cyan,
                        );
                      }
                      if (index == buttons.length - 1) {
                        return MyButtonWidget(
                          buttonTapped: () {
                            setState(() {
                              equalPressed();
                            });
                          },
                          buttonText: buttons[index],
                          color: Colors.deepPurple,
                          textColor: Colors.white,
                        );
                      }
                      return MyButtonWidget(
                        buttonTapped: () {
                          setState(() {
                            userQuestion += buttons[index];
                          });
                        },
                        buttonText: buttons[index],
                        color: isOperator(buttons[index])
                            ? Colors.deepPurple
                            : Colors.deepPurple.shade50,
                        textColor: isOperator(buttons[index])
                            ? Colors.white
                            : Colors.deepPurple,
                      );
                    },
                  )),
                )
              ],
            )));
  }

  bool isOperator(String x) {
    if (x == '%' || x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }

  void equalPressed() {
    String finalQuestion = userQuestion;
    finalQuestion = finalQuestion.replaceAll('x', '*');
    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    double res = exp.evaluate(EvaluationType.REAL, cm);
    userAnswer = res.toString();
  }
}
