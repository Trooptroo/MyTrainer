import 'package:flutter/material.dart';

class WorkoutSurveyPage extends StatefulWidget {
  const WorkoutSurveyPage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _WorkoutSurveyPageState extends State<WorkoutSurveyPage> {
  int _currentQuestionIndex = 0;
  List<Map<String, dynamic>> _questions = [
    {
      'questionText': 'What is your fitness goal?',
      'answers': [
        {'text': 'Lose Weight', 'score': 1},
        {'text': 'Gain Muscle', 'score': 2},
        {'text': 'Improve Endurance', 'score': 3},
        {'text': 'General Fitness', 'score': 4},
      ],
    },
    {
      'questionText': 'How many days a week do you want to work out?',
      'answers': [
        {'text': '1-2 days', 'score': 1},
        {'text': '3-4 days', 'score': 2},
        {'text': '5-6 days', 'score': 3},
        {'text': '7 days', 'score': 4},
      ],
    },
    // Add more questions here...
  ];


  void _answerQuestion(int score) {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: _currentQuestionIndex < _questions.length
          ? Column(
              children: [
                Text(_questions[_currentQuestionIndex]['questionText']),
                ...(_questions[_currentQuestionIndex]['answers'] as List<Map<String, dynamic>>)
                    .map((answer) => ElevatedButton(
                          onPressed: () => _answerQuestion(answer['score']),
                          child: Text(answer['text']),
                        ))
                    .toList(),
              ],
            )
          : const Center(child: Text('Survey completed!')),
    );
  }
}
