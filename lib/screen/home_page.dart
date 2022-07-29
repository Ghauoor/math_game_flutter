import 'dart:math';

import 'package:flutter/material.dart';
import 'package:math_game/utils/reult_message.dart';

import '../utils/consts.dart';
import '../utils/my_button.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //! Number Pad list
  List<String> numberPad = [
    '7',
    '8',
    '9',
    'C',
    '4',
    '5',
    '6',
    'DEL',
    '1',
    '2',
    '3',
    '=',
    '0'
  ];
  //! number A, number b
  int numberA = 1;
  int numberB = 1;

  //! user answer
  String userAnswer = '';

  //! user tapped button fun
  void buttonTapped(String button) {
    setState(() {
      if (button == '=') {
        //Cal user right or not
        checkResult();
      }
      //del the ans
      else if (button == 'C') {
        userAnswer = '';
        //del the last num
      } else if (button == 'DEL') {
        if (userAnswer.isNotEmpty) {
          userAnswer = userAnswer.substring(0, userAnswer.length - 1);
        }
      } else if (userAnswer.length < 3) {
        //max 3 num can be input..
        userAnswer += button;
      }
    });
  }

  // check if user is correct or not
  void checkResult() {
    if (numberA + numberB == int.parse(userAnswer)) {
      showDialog(
          context: context,
          builder: (context) {
            return ResultMessage(
              message: 'Correct!',
              onTap: goToNextQuestion,
              icon: const Icon(Icons.forward_10_rounded),
            );
          });
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return ResultMessage(
              message: 'Sorry try again',
              onTap: goBackToQuestion,
              icon: const Icon(Icons.rotate_left),
            );
          });
    }
  }

  //! NEXT QUESTION
  void goToNextQuestion() {
    //!Dimis the dialog
    Navigator.of(context).pop();

    //!Create Rondom number
    var randomNumber = Random();

    //!reset values...
    setState(() {
      userAnswer = '';
    });

    //! Create a new Questions
    //TODO: Check the edge cases...
    numberA = randomNumber.nextInt(10);
    numberB = randomNumber.nextInt(10);
  }

  //! Go BACK TO QUESTION

  void goBackToQuestion() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[300],
      body: Column(
        children: [
          //! Level Progress, player need 5 correct ans in a row to move on
          Container(
            height: 180,
            color: Colors.deepPurple,
          ),
          //!questions...
          Expanded(
            child: SizedBox(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //! Question Box...
                    Text(
                      numberA.toString() + ' + ' + numberB.toString() + ' = ',
                      style: whiteTextStyle,
                    ),
                    //! Answer Box
                    Container(
                      height: 50,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.deepPurple[400],
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Text(
                          userAnswer,
                          style: whiteTextStyle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          //!number pad...
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                ),
                itemCount: numberPad.length,
                itemBuilder: (BuildContext context, int index) {
                  return MyButton(
                    child: numberPad[index],
                    onTap: () => buttonTapped(numberPad[index]),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
