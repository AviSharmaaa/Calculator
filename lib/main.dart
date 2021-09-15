import 'package:calculator/theme.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(Calculator());
}

class Calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      home: Calculate(),
    );
  }
}

class Calculate extends StatefulWidget {
  @override
  _CalculateState createState() => _CalculateState();
}

class _CalculateState extends State<Calculate> {
  String eqn = "0";
  String res = "0";
  String expre = "";
  double eqnFont = 38.0;
  double resFont = 48.0;

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "AC") {
        eqn = "0";
        res = "0";
        eqnFont = 38.0;
        resFont = 48.0;
      } else if (buttonText == "C") {
        eqnFont = 48.0;
        resFont = 38.0;
        eqn = eqn.substring(0, eqn.length - 1);
        if (eqn == "") {
          eqn = "0";
        }
      } else if (buttonText == "=") {
        eqnFont = 38.0;
        resFont = 48.0;
        expre = eqn;
        expre = expre.replaceAll('×', '*');
        expre = expre.replaceAll('÷', '/');

        try {
          Parser p = Parser();
          Expression exp = p.parse(expre);
          ContextModel cm = ContextModel();
          res = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          res = "Error";
        }
      } else {
        eqnFont = 48.0;
        resFont = 38.0;
        if (eqn == "0") {
          eqn = buttonText;
        } else {
          eqn = eqn + buttonText;
        }
      }
    });
  }

  Widget buildButton(
      String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
      height: 85,
      color: buttonColor,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.black),
        ),

        onPressed: () => buttonPressed(buttonText),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            buttonText,
            style: TextStyle(
                fontSize: 30.0, fontWeight: FontWeight.normal, color: kcolr),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Calculator',
          style: TextStyle(color: kcolr),
        ),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              color: Colors.black,
            ),
          ),
          Container(
            color: Colors.black,
            padding: EdgeInsets.fromLTRB(10, 20, 15, 0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      eqn,
                      style: TextStyle(
                        fontSize: eqnFont,
                        color: kcolr,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      res,
                      style: TextStyle(
                        color: kcolr,
                        fontSize: resFont,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * .75,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildButton("AC", 1, kcolr1),
                        buildButton("C", 1, kcolr1),
                        buildButton("÷", 1, kcolr1),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("7", 1, kcolr1),
                        buildButton("8", 1, kcolr1),
                        buildButton("9", 1, kcolr1),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("4", 1, kcolr1),
                        buildButton("5", 1, kcolr1),
                        buildButton("6", 1, kcolr1),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("1", 1, kcolr1),
                        buildButton("2", 1, kcolr1),
                        buildButton("3", 1, kcolr1),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton(".", 1, kcolr1),
                        buildButton("0", 1, kcolr1),
                        buildButton("00", 1, kcolr1),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(children: [
                      buildButton("×", 1, kcolr1),
                    ]),
                    TableRow(children: [
                      buildButton("+", 1, kcolr1),
                    ]),
                    TableRow(children: [
                      buildButton("-", 1, kcolr1),
                    ]),
                    TableRow(children: [
                      buildButton("%", 1, kcolr1),
                    ]),
                    TableRow(children: [
                      buildButton("=", 1, kcolr1),
                    ]),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}