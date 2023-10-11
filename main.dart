import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}
class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  dynamic displaytxt = 20;

  //Button Widget
  Widget button(String btntxt, Color btncolor, Color txtcolor) {
    return ElevatedButton(
      onPressed: () {
        calculation(btntxt);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: btncolor,
      ),
      child: Text(btntxt,
        style: TextStyle(
          fontSize:25,
          color: txtcolor,
        ),
      ),

    );
  }

  @override
  Widget build(BuildContext context) {
    //Calculator
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title:const Center(child: Text('Calculator')),
        backgroundColor: Colors.purpleAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            // Calculator display
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text('$text',
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 100,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                button('AC', Colors.orangeAccent, Colors.white),
                button('+/-', Colors.purpleAccent, Colors.black),
                button('%', Colors.purpleAccent, Colors.black),
                button('/', Colors.purpleAccent, Colors.black),
              ],
            ),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                button('7', Colors.grey[900]!, Colors.white),
                button('8', Colors.grey[900]!, Colors.white),
                button('9', Colors.grey[900]!, Colors.white),
                button('x', Colors.purpleAccent, Colors.black),
              ],
            ),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                button('4', Colors.grey[900]!, Colors.white),
                button('5', Colors.grey[900]!, Colors.white),
                button('6', Colors.grey[900]!, Colors.white),
                button('-', Colors.purpleAccent, Colors.black),
              ],
            ),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                button('1', Colors.grey[900]!, Colors.white),
                button('2', Colors.grey[900]!, Colors.white),
                button('3', Colors.grey[900]!, Colors.white),
                button('+', Colors.purpleAccent, Colors.black),
              ],
            ),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                button('.', Colors.purpleAccent, Colors.white),
                button('00', Colors.purpleAccent, Colors.white),
                button('0', Colors.purpleAccent, Colors.white),
                button('=', Colors.purpleAccent, Colors.black),

              ],
            ),
            const SizedBox(height: 10,width:30),
          ],
        ),
      ),
    );
  }

  //Calculator logic
  dynamic text = '0';
  double num1 = 0;
  double num2 = 0;

  dynamic result = '';
  dynamic finalResult = '';
  dynamic op= '';
  dynamic preOp = '';

  void calculation(btnText) {
    if (btnText == 'AC') {
      text = '0';
      num1 = 0;
      num2 = 0;
      result = '';
      finalResult = '0';
      op = '';
      preOp = '';
    } else if (op == '=' && btnText == '=') {
      if (preOp == '+') {
        finalResult = add();
      } else if (preOp == '-') {
        finalResult = sub();
      } else if (preOp == 'x') {
        finalResult = mul();
      } else if (preOp == '/') {
        finalResult = div();
      }
    }
    else if (btnText == '+' || btnText == '-' || btnText == 'x' || btnText == '/' ||
        btnText == '=') {
      if (num1 == 0) {
        num1 = double.parse(result);
      } else {
        num2 = double.parse(result);
      }

      if (op == '+') {
        finalResult = add();
      } else if (op == '-') {
        finalResult = sub();
      } else if (op == 'x') {
        finalResult = mul();
      } else if (op == '/') {
        finalResult = div();
      }
      preOp = op;
      op = btnText;
      result = '';
    }
    else if (btnText == '%') {
      result = num1 /100;
      finalResult = doesContainDecimal(result);

    } else if (btnText == '.') {
      if (!result.toString().contains('.')) {
        result = '$result.';
      }
      finalResult = result;
    }

    else if (btnText == '+/-') {
      // result.toString().startsWith('+') ?
      // result = result.toString().substring(1) : result =
      //     '+$result';
      result.toString().endsWith('-') ?
      result = result.toString().substring(1) : result =
      '-$result';
      finalResult = result;
    }

    else {
      result = result + btnText;
      finalResult = result;
    }


    setState(() {
      text = finalResult;
    });
  }


  String add() {
    result = (num1 + num2).toString();
    num1= double.parse(result);
    return doesContainDecimal(result);
  }

  String sub() {
    result = (num1 - num2).toString();
    num1 = double.parse(result);
    return doesContainDecimal(result);
  }

  String mul() {
    result = (num1 * num2).toString();
    num1 = double.parse(result);
    return doesContainDecimal(result);
  }

  String div() {
    result = (num1 / num2).toString();
    num1= double.parse(result);
    return doesContainDecimal(result);
  }


  String doesContainDecimal(dynamic result) {
    if (result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      if (!(int.parse(splitDecimal[1]) > 0)) {
        return result = splitDecimal[0].toString();
      }
    }


    return result;
  }
}


