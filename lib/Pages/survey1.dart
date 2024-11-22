import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Survey Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MySurveyPage(title: 'Flutter Survey Demo'),
    );
  }
}

class MySurveyPage extends StatefulWidget {
  const MySurveyPage({super.key, required this.title});

  final String title;

  @override
  State<MySurveyPage> createState() => _MySurveyPageState();
}

class _MySurveyPageState extends State<MySurveyPage> {
  int _currentQuestionIndex = 0;
  final List<Map<String, dynamic>> _questions = [
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
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: _currentQuestionIndex < _questions.length
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _questions[_currentQuestionIndex]['questionText'],
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 20),
                  ...(_questions[_currentQuestionIndex]['answers']
                          as List<Map<String, dynamic>>)
                      .map(
                        (answer) => ElevatedButton(
                          onPressed: () => _answerQuestion(answer['score']),
                          child: Text(answer['text']),
                        ),
                      )
                      ,
                ],
              ),
            )
          : const Center(
              child: Text(
                'Survey Completed!',
                style: TextStyle(fontSize: 20),
              ),
            ),
    );
  }
}
