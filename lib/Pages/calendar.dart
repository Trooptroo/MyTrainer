import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:table_calendar/table_calendar.dart';

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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // This will store activities for each day.
  final Map<DateTime, List<String>> _activities = {};
  DateTime _selectedDay = DateTime.now();
  final TextEditingController _activityController = TextEditingController();

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
      _activities[day]?.remove(activity);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          // Table Calendar widget
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _selectedDay,
            selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
              });
            },
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
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: const Icon(Icons.delete, color: Colors.white),
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
