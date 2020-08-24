import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int score;
  final Function resetHandler;

  Result(this.score, this.resetHandler);

  String get resultPhase {
    var resultText = 'You did it!';

    if (score <= 8) {
      resultText = 'Your score is $score. You are such a beautiful person.';
    } else {
      resultText = 'Your score is $score. You are such an awesome person.';
    }
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(
            resultPhase,
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        FlatButton(
          color: Colors.blue,
          child: Text('Reset Quiz!'),
          onPressed: resetHandler,
        ),
      ],
    );
  }
}
