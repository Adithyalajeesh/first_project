import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  Widget calculatorButton(
      String buttonText, Color buttonColor, Color textColor) {
    return Container(
      child: ElevatedButton(
          onPressed: () {
            calculation(buttonText);
          },
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            primary: buttonColor,
            minimumSize: Size(80.0, 80.0),
          ),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                buttonText,
                style: TextStyle(color: textColor, fontSize: 35),
              ),
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          "CALCULATOR",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black12,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      text,
                      style: TextStyle(color: Colors.white, fontSize: 90),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calculatorButton("C", Colors.grey, Colors.black),
                calculatorButton("+/-", Colors.grey, Colors.black),
                calculatorButton("%", Colors.grey, Colors.black),
                calculatorButton("/", Colors.amber.shade800, Colors.white),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calculatorButton("7", Colors.grey.shade800, Colors.black),
                calculatorButton("8", Colors.grey.shade800, Colors.black),
                calculatorButton("9", Colors.grey.shade800, Colors.black),
                calculatorButton("x", Colors.amber.shade800, Colors.white),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calculatorButton("4", Colors.grey.shade800, Colors.black),
                calculatorButton("5", Colors.grey.shade800, Colors.black),
                calculatorButton("6", Colors.grey.shade800, Colors.black),
                calculatorButton("-", Colors.amber.shade800, Colors.white),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calculatorButton("1", Colors.grey.shade800, Colors.black),
                calculatorButton("2", Colors.grey.shade800, Colors.black),
                calculatorButton("3", Colors.grey.shade800, Colors.black),
                calculatorButton("+", Colors.amber.shade800, Colors.white),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        shape: StadiumBorder(),
                        primary: Colors.grey.shade800,
                        minimumSize: Size(180, 50)),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          "0",
                          style: TextStyle(color: Colors.black, fontSize: 35),
                        ),
                      ),
                    )),
                calculatorButton(".", Colors.grey.shade800, Colors.black),
                calculatorButton("=", Colors.amber.shade800, Colors.white),
              ],
            )
          ],
        ),
      ),
    );
  }

  //Calculator logic
  dynamic text = '0';
  double numOne = 0;
  double numTwo = 0;

  dynamic result = '';
  dynamic finalResult = '';
  dynamic opr = '';
  dynamic preOpr = '';
  void calculation(buttonText) {
    if (buttonText == 'C') {
      text = '0';
      numOne = 0;
      numTwo = 0;
      result = '';
      finalResult = '0';
      opr = '';
      preOpr = '';
    } else if (opr == '=' && buttonText == '=') {
      if (preOpr == '+') {
        finalResult = add();
      } else if (preOpr == '-') {
        finalResult = sub();
      } else if (preOpr == 'x') {
        finalResult = mul();
      } else if (preOpr == '/') {
        finalResult = div();
      }
    } else if (buttonText == '+' ||
        buttonText == '-' ||
        buttonText == 'x' ||
        buttonText == '/' ||
        buttonText == '=') {
      if (numOne == 0) {
        numOne = double.parse(result);
      } else {
        numTwo = double.parse(result);
      }

      if (opr == '+') {
        finalResult = add();
      } else if (opr == '-') {
        finalResult = sub();
      } else if (opr == 'x') {
        finalResult = mul();
      } else if (opr == '/') {
        finalResult = div();
      }
      preOpr = opr;
      opr = buttonText;
      result = '';
    } else if (buttonText == '%') {
      result = numOne / 100;
      finalResult = doesContainDecimal(result);
    } else if (buttonText == '.') {
      if (!result.toString().contains('.')) {
        result = result.toString() + '.';
      }
      finalResult = result;
    } else if (buttonText == '+/-') {
      result.toString().startsWith('-')
          ? result = result.toString().substring(1)
          : result = '-' + result.toString();
      finalResult = result;
    } else {
      result = result + buttonText;
      finalResult = result;
    }

    setState(() {
      text = finalResult;
    });
  }

  String add() {
    result = (numOne + numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String sub() {
    result = (numOne - numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String mul() {
    result = (numOne * numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String div() {
    result = (numOne / numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String doesContainDecimal(dynamic result) {
    if (result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      if (!(int.parse(splitDecimal[1]) > 0))
        return result = splitDecimal[0].toString();
    }
    return result;
  }
}
