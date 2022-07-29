import 'package:flutter/material.dart';

import 'consts.dart';

class ResultMessage extends StatelessWidget {
  final String message;
  final VoidCallback onTap;
  final Icon icon;
  const ResultMessage({
    Key? key,
    required this.message,
    required this.onTap,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.deepPurple,
      content: SizedBox(
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //! Result...
            Text(
              message,
              style: whiteTextStyle,
            ),
            //!Button to go on next question
            GestureDetector(
              onTap: onTap,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.deepPurple[300],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
