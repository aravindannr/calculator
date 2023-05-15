import 'package:calculator/Mybuttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(Myapp());

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Homepage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Homepage extends StatefulWidget {
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  var userinput = '';
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
                      alignment: Alignment.centerLeft,
                      child: Text(
                        userinput,
                        style: TextStyle(fontSize: 19),
                      )),
                  Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        answer,
                        style: TextStyle(fontSize: 20),
                      ))
                ],
              ),
            ),
          )),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  child: GridView.builder(
                      itemCount: buttons.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4),
                      itemBuilder: (BuildContext context, int index) {
                        if (index == 0) {
                          return MyButtons(
                            onpressed: () {
                              setState(() {
                                userinput = '';
                              });
                            },
                            buttonText: buttons[index],
                            color: Colors.lightGreen,
                            textColor: Colors.white,
                          );
                        }
                        if (index == 1) {
                          return MyButtons(
                            onpressed: () {
                              setState(() {
                                userinput = userinput.substring(
                                    0, userinput.length - 1);
                              });
                            },
                            buttonText: buttons[index],
                            color: Colors.redAccent,
                            textColor: Colors.white,
                          );
                        }
                        return MyButtons(
                          onpressed: () {
                            setState(() {
                              userinput += buttons[index];
                            });
                          },
                          buttonText: buttons[index],
                          textColor: isOperator(buttons[index])
                              ? Colors.white
                              : Colors.blueGrey,
                          color: isOperator(buttons[index])
                              ? Colors.blueGrey
                              : Colors.blueGrey[50],
                        );
                      })),
            ),
          )
        ],
      ),
    );
  }

  bool isOperator(String x) {
    if (x == '%' || x == 'x' || x == '-' || x == '+' || x == '=' || x == '÷') {
      return true;
    }
    return false;
  }
}
