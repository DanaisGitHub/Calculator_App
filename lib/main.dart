import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import './providers/provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ListenableProvider(
    create: (context) => CalculatorLogic(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.yellow,
          fontFamily: "Raleway",
          backgroundColor: Colors.black54,
          scaffoldBackgroundColor: Colors.black),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage();

  ElevatedButton calcButton(
      {required String output,
      color = const Color.fromARGB(255, 63, 63, 63),
      textColor = Colors.white,
      right = false,
      required VoidCallback func,
      bool isZeroButton = false}) {
    double zeroOrFifty = Platform.isAndroid? 0:50;
    return 
    ElevatedButton(
      onPressed: func,
      style: ElevatedButton.styleFrom(
          fixedSize: isZeroButton ? const Size(170, 70) : const Size(70, 70),
          shape:  RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(zeroOrFifty),
              topRight: Radius.circular(zeroOrFifty),
              bottomRight: Radius.circular(zeroOrFifty),
              bottomLeft: Radius.circular(zeroOrFifty),
            ),
          ),
          backgroundColor: color,
          side: const BorderSide(
            width: 0.0,
          )),
      child: Text(
        output,
        textAlign: TextAlign.left,
        style: TextStyle(
            color: textColor, fontSize: 27, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final calcProv = Provider.of<CalculatorLogic>(context, listen: true);
    //var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait ? true: false;
    String calcAnswer = calcProv.input;
    List<String> calcHistory = calcProv.equationHistory;
    double preHeight = MediaQuery.of(context).size.height;
    EdgeInsets padding = MediaQuery.of(context).viewPadding;
    double height = preHeight - padding.bottom;
    return Scaffold(
        body: Column(
      children: <Widget>[
        Container(
            height: height * 0.35,
            child: Column(children: [
              Container(
                  height: height * 0.35 * 0.5,
                  child: ListView.builder(
                      itemCount: calcHistory.length,
                      itemBuilder: (BuildContext context, int length) {
                        return Text(calcHistory[length],
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                                fontSize: 20, color: Colors.white));
                      })),
              Center(
                child: Container(
                  height: height * 0.35 * 0.5,
                  width: double.infinity,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      calcAnswer,
                      style: const TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              )
            ])),
        Container(
          height: height * 0.65,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      calcButton(
                          output: "C",
                          color: Colors.grey,
                          textColor: Colors.black,
                          func: () =>
                              context.read<CalculatorLogic>().clearUserInput()),
                      calcButton(
                          output: "AC",
                          color: Colors.grey,
                          textColor: Colors.black,
                          func: () =>
                              context.read<CalculatorLogic>().clearAll()),
                      calcButton(
                          output: "<=",
                          color: Colors.grey,
                          textColor: Colors.black,
                          func: () =>
                              context.read<CalculatorLogic>().backspace()),
                      calcButton(
                          output: "/",
                          color: Colors.orange,
                          func: () =>
                              context.read<CalculatorLogic>().setUserInput("/"))
                    ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      calcButton(
                          output: "7",
                          func: () => context
                              .read<CalculatorLogic>()
                              .setUserInput("7")),
                      calcButton(
                          output: "8",
                          func: () => context
                              .read<CalculatorLogic>()
                              .setUserInput("8")),
                      calcButton(
                          output: "9",
                          func: () => context
                              .read<CalculatorLogic>()
                              .setUserInput("9")),
                      calcButton(
                          output: "x",
                          color: Colors.orange,
                          textColor: Colors.white,
                          func: () =>
                              context.read<CalculatorLogic>().setUserInput("*"))
                    ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      calcButton(
                          output: "4",
                          func: () => context
                              .read<CalculatorLogic>()
                              .setUserInput("4")),
                      calcButton(
                          output: "5",
                          func: () => context
                              .read<CalculatorLogic>()
                              .setUserInput("5")),
                      calcButton(
                          output: "6",
                          func: () => context
                              .read<CalculatorLogic>()
                              .setUserInput("6")),
                      calcButton(
                          output: "-",
                          color: Colors.orange,
                          textColor: Colors.white,
                          func: () =>
                              context.read<CalculatorLogic>().setUserInput("-"))
                    ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      calcButton(
                          output: "1",
                          func: () => context
                              .read<CalculatorLogic>()
                              .setUserInput("1")),
                      calcButton(
                          output: "2",
                          func: () => context
                              .read<CalculatorLogic>()
                              .setUserInput("2")),
                      calcButton(
                          output: "3",
                          func: () => context
                              .read<CalculatorLogic>()
                              .setUserInput("3")),
                      calcButton(
                          output: "+",
                          color: Colors.orange,
                          textColor: Colors.white,
                          func: () =>
                              context.read<CalculatorLogic>().setUserInput("+"))
                    ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      calcButton(
                          output: "0",
                          func: () =>
                              context.read<CalculatorLogic>().setUserInput("0"),
                          isZeroButton: true),
                      calcButton(
                          output: ".",
                          func: () => context
                              .read<CalculatorLogic>()
                              .setUserInput(".")),
                      calcButton(
                          output: "=",
                          color: Colors.orange,
                          textColor: Colors.white,
                          func: () =>
                              context.read<CalculatorLogic>().equalsPressed())
                    ]),
              ]),
        )
      ],
    ));
  }
}
