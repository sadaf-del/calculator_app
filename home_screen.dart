import 'package:flutter/material.dart';
import 'package:components/component/compo.dart';
import 'package:components/const.dart';
import 'package:math_expressions/math_expressions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userInput = '';
  String answer = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              // Display Area
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        userInput,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        answer,
                        style: const TextStyle(
                          color: Colors.greenAccent,
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Buttons
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Row(
                      children: [
                        MyButton(
                          title: 'AC',
                          color: Colors.red,
                          onPress: () {
                            setState(() {
                              userInput = '';
                              answer = '';
                            });
                          },
                        ),
                        MyButton(
                          title: '+/-',
                          onPress: () {
                            // Optional: Implement +/- toggle
                          },
                        ),
                        MyButton(
                          title: '%',
                          onPress: () {
                            setState(() {
                              userInput += '%';
                            });
                          },
                        ),
                        MyButton(
                          title: '/',
                          color: const Color(0xffffa00a),
                          onPress: () {
                            setState(() {
                              userInput += '/';
                            });
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        MyButton(title: '7', onPress: () => addInput('7')),
                        MyButton(title: '8', onPress: () => addInput('8')),
                        MyButton(title: '9', onPress: () => addInput('9')),
                        MyButton(
                          title: 'x',
                          color: const Color(0xffffa00a),
                          onPress: () => addInput('x'),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        MyButton(title: '4', onPress: () => addInput('4')),
                        MyButton(title: '5', onPress: () => addInput('5')),
                        MyButton(title: '6', onPress: () => addInput('6')),
                        MyButton(
                          title: '-',
                          color: const Color(0xffffa00a),
                          onPress: () => addInput('-'),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        MyButton(title: '1', onPress: () => addInput('1')),
                        MyButton(title: '2', onPress: () => addInput('2')),
                        MyButton(title: '3', onPress: () => addInput('3')),
                        MyButton(
                          title: '+',
                          color: const Color(0xffffa00a),
                          onPress: () => addInput('+'),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        MyButton(title: '0', onPress: () => addInput('0')),
                        MyButton(title: '.', onPress: () => addInput('.')),
                        MyButton(
                          title: 'DEL',
                          onPress: () {
                            setState(() {
                              if (userInput.isNotEmpty) {
                                userInput = userInput.substring(0, userInput.length - 1);
                              }
                            });
                          },
                        ),
                        MyButton(
                          title: '=',
                          color: const Color(0xffffa00a),
                          onPress: () {
                            equalPress();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void addInput(String value) {
    setState(() {
      userInput += value;
    });
  }

  void equalPress() {
    try {
      String finalInput = userInput.replaceAll('x', '*');
      Parser p = Parser();
      Expression expression = p.parse(finalInput);
      ContextModel contextModel = ContextModel();

      double eval = expression.evaluate(EvaluationType.REAL, contextModel);
      setState(() {
        answer = eval.toString();
      });
    } catch (e) {
      setState(() {
        answer = 'Error';
      });
    }
  }
}