import 'package:flutter/material.dart';
import 'package:device_info/device_info.dart';
import 'dart:io' show Platform;

import './quiz.dart';
import './result.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  static const _questions = const [
    {
      'questionText': 'What\'s your favorite color?',
      'answers': [
        {'text': 'Black', 'score': 1},
        {'text': 'Red', 'score': 2},
        {'text': 'Green', 'score': 3},
        {'text': 'White', 'score': 4},
      ],
    },
    {
      'questionText': 'What\'s your favorite animal?',
      'answers': [
        {'text': 'Dog', 'score': 1},
        {'text': 'Cat', 'score': 2},
        {'text': 'Elephant', 'score': 3},
      ],
    },
    {
      'questionText': 'What\'s your favorite instructor?',
      'answers': [
        {'text': 'Lucy', 'score': 1},
        {'text': 'Tom', 'score': 2},
        {'text': 'Sam', 'score': 3},
        {'text': 'Max', 'score': 4},
      ],
    },
    {
      'questionText': 'What\'s your favorite city?',
      'answers': [
        {'text': 'Toronto', 'score': 1},
        {'text': 'Montreal', 'score': 2},
        {'text': 'Yellowknife', 'score': 3},
      ],
    },
  ];

  var _questionIndex = 0;

  var _totalScore = 0;

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    });
  }

  void _answerQuestion(int score) {
    print('before $_questionIndex');
    setState(() {
      _questionIndex = _questionIndex + 1;
    });

    print('after $_questionIndex');
    _totalScore += score;
  }

  DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  List<Widget> textWidgets = [];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Hi poop'),
        ),
        body: Column(
          children: [
            _questionIndex < _questions.length
                ? Quiz(
                    answerQuestion: _answerQuestion,
                    questions: _questions,
                    questionIndex: _questionIndex,
                  )
                : Result(_totalScore, _resetQuiz),
            Text(
              'Device Info',
              style: TextStyle(fontSize: 28),
            ),
            ...textWidgets,
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (Platform.isAndroid) {
              AndroidDeviceInfo androidInfo =
                  await deviceInfoPlugin.androidInfo;
              setState(() {
                textWidgets.add(Text('androidId: ${androidInfo.androidId}'));
                textWidgets.add(Text('board: ${androidInfo.board}'));
                textWidgets.add(Text('bootloader: ${androidInfo.bootloader}'));
                textWidgets.add(Text('brand: ${androidInfo.brand}'));
                textWidgets.add(Text('device: ${androidInfo.device}'));
                textWidgets.add(Text('display: ${androidInfo.display}'));
                textWidgets
                    .add(Text('fingerprint: ${androidInfo.fingerprint}'));
                textWidgets.add(Text('hardware: ${androidInfo.hardware}'));
                textWidgets.add(Text('hashCode: ${androidInfo.hashCode}'));
                textWidgets.add(Text('host: ${androidInfo.host}'));
                textWidgets.add(Text('id: ${androidInfo.id}'));
                textWidgets.add(
                    Text('isPhysicalDevice: ${androidInfo.isPhysicalDevice}'));
                textWidgets
                    .add(Text('manufacturer: ${androidInfo.manufacturer}'));
                textWidgets.add(Text('model: ${androidInfo.model}'));
                textWidgets.add(Text('product: ${androidInfo.product}'));
              });
            } else {
              IosDeviceInfo iosInfo = await deviceInfoPlugin.iosInfo;
              setState(() {
                textWidgets.add(Text('name: ${iosInfo.name}'));
                textWidgets.add(Text('systemVersion: ${iosInfo.systemVersion}'));
                textWidgets.add(Text('identifierForVendor: ${iosInfo.identifierForVendor}'));
              });
            }
          },
          tooltip: 'Increment',
          child: Icon(Icons.refresh),
        ),
      ),
    );
  }
}
