 // Suggested code may be subject to a license. Learn more: ~LicenseLog:515427613.
import 'package:flutter/material.dart';

class WorkoutSurveyPage extends StatefulWidget {
  const WorkoutSurveyPage({Key? key}) : super(key: key);

  @override
  _WorkoutSurveyPageState createState() => _WorkoutSurveyPageState();
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
      _currentQuestionIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workout Survey'),
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
 