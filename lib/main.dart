import 'package:math_expressions/math_expressions.dart';
import 'package:calculator_v01/buttons.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var userQuestion = '';
  var userAns = '';

  final List<String> buttons = 
  [
    'C', 'DEL', '%', '/',
    '9', '8', '7', 'x',
    '6', '5', '4', '-',
    '3', '2', '1', '+',
    '0', '.', 'ANS', '=',
  ];




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent[100],
      body: Column(
        children: <Widget>[
          Expanded(
            child: 
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.centerLeft,
                    child: Text(userQuestion, style: TextStyle(fontSize: 30, color: Colors.deepOrange, fontWeight: FontWeight.bold),)
                    ),
                  Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.centerRight,
                    child: Text(userAns, style: TextStyle(fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold),)
                    ),
                ],
              ),
            )),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.all(10),
              child: GridView.builder(
                itemCount: buttons.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4), 
                itemBuilder: (BuildContext context, index){
                  if (index == 0) {
                    return MyButton(
                    color: Colors.green[300], 
                    textColor: Colors.white, 
                    buttonText: buttons[index],
                    buttonTapped: () {
                      setState(() {
                        userQuestion = '';
                      });
                    },
                  );
                  }else if(index == 1){
                    return MyButton(
                    color:  Colors.red[300], 
                    textColor: Colors.white, 
                    buttonText: buttons[index],
                    buttonTapped: () {
                      setState(() { 
                      userQuestion = userQuestion.substring(0,userQuestion.length-1);
                      });
                    },
                  );
                  }else if(index == buttons.length-1){
                    return MyButton(
                    color:  Colors.blue[300], 
                    textColor: Colors.black, 
                    buttonText: buttons[index],
                    buttonTapped: () {
                      setState(() { 
                        equalPressed();
                      });
                    },
                  );
                  }else{
                    return MyButton(
                      buttonTapped: () {
                        setState(() {
                          userQuestion += buttons[index];
                        });
                      },
                    color: isOperator(buttons[index]) ? Colors.blue[300] : Colors.green[50], 
                    textColor: Colors.black, 
                    buttonText: buttons[index],
                  );
                  }
                }
                ),
            )),
        ],
      ),
    );
  }

  bool isOperator(String x){
  if (x == '%' ||x == '/' ||x == '-' ||x == '+' ||x == 'x' ||x == '=') {
    return true;
  }
  return false;
}

  String equalPressed() {
    String finalQuestion = userQuestion;
    finalQuestion = finalQuestion.replaceAll('x','*');

    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    userAns = eval.toString();
    return userAns;
 }
}

