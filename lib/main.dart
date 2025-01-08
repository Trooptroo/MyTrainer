import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calendar with Activities',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Calendar with Activities'),
    );
  }
}


class SurveyPageView extends StatefulWidget {
  const SurveyPageView({super.key});


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // This will store activities for each day.
  final Map<DateTime, List<String>> _activities = {};
  DateTime _selectedDay = DateTime.now();
  TextEditingController _activityController = TextEditingController();

  // Helper function to add an activity to a specific day
  void _addActivity(DateTime day, String activity) {
    setState(() {
      if (_activities[day] == null) {
        _activities[day] = [];
      }
      _activities[day]!.add(activity);
    });
  }

  // Helper function to remove an activity from a specific day
  void _removeActivity(DateTime day, String activity) {
    setState(() {
      _hoverCounter++;
    });
  }


  // Displaying a dialog to add a new activity
  void _showAddActivityDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add Activity"),
          content: TextField(
            controller: _activityController,
            decoration: const InputDecoration(hintText: 'Enter activity'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                if (_activityController.text.isNotEmpty) {
                  _addActivity(_selectedDay, _activityController.text);
                }
                _activityController.clear();
              },
              child: const Text('Add'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _activityController.clear();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
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

          // List of activities for the selected day
          Expanded(
            child: ListView.builder(
              itemCount: _activities[_selectedDay]?.length ?? 0,
              itemBuilder: (context, index) {
                final activity = _activities[_selectedDay]![index];
                return Dismissible(
                  key: Key(activity),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    _removeActivity(_selectedDay, activity);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('$activity removed')),
                    );
                  },
                  background: Container(
                    color: Colors.red,
                    child: const Icon(Icons.delete, color: Colors.white),
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  ),
                  child: ListTile(
                    title: Text(activity),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddActivityDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}

