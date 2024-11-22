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
      home: const SurveyPageView(),
    );
  }
}


class SurveyPageView extends StatefulWidget {
  const SurveyPageView({super.key});


  @override
  State<SurveyPageView> createState() => _SurveyPageViewState();
}


class _SurveyPageViewState extends State<SurveyPageView> {
  final PageController _pageController = PageController();
  int _currentQuestionIndex = 0;
  int _hoverCounter = 0;


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
      _currentQuestionIndex = (_currentQuestionIndex + 1) % _questions.length;
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }


  void _incrementHoverCounter() {
    setState(() {
      _hoverCounter++;
    });
  }


  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      scrollDirection: Axis.vertical,
      itemCount: _questions.length + 1, // Add 1 for the "Survey Completed" page
      itemBuilder: (context, index) {
        if (index < _questions.length) {
          return SurveyQuestion(
            questionText: _questions[index]['questionText'],
            answers: _questions[index]['answers'],
            onAnswerSelected: _answerQuestion,
            hoverCounter: _hoverCounter,
            onHover: _incrementHoverCounter,
          );
        } else {
          return const Center(
            child: Text(
              'Survey Completed!',
              style: TextStyle(fontSize: 20),
            ),
          );
        }
      },
    );
  }
}


class SurveyQuestion extends StatelessWidget {
  final String questionText;
  final List<Map<String, dynamic>> answers;
  final void Function(int) onAnswerSelected;
  final int hoverCounter;
  final VoidCallback onHover;


  const SurveyQuestion({
    super.key,
    required this.questionText,
    required this.answers,
    required this.onAnswerSelected,
    required this.hoverCounter,
    required this.onHover,
  });


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            questionText,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 20),
          ...answers.map(
            (answer) => ElevatedButton(
              onPressed: () => onAnswerSelected(answer['score']),
              child: Text(answer['text']),
            ),
          ),
          const SizedBox(height: 40),
          Center(
            child: MouseRegion(
              onEnter: (_) => onHover(),
              child: Container(
                width: 200,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: Text(
                  'Hover over me!',
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: Text(
              'Hover Count: $hoverCounter',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ],
      ),
    );
  }
}
