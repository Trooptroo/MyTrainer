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
        scaffoldBackgroundColor: Colors.black, // Set the scaffold background to black
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      debugShowCheckedModeBanner: false, // Disable the debug banner
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
  final Map<DateTime, List<Map<String, String>>> _activities = {};
  DateTime _selectedDay = DateTime.now();
  final TextEditingController _activityController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  // Helper function to add an activity to a specific day
  void _addActivity(DateTime day, String activity, String time, String? description) {
    setState(() {
      if (_activities[day] == null) {
        _activities[day] = [];
      }
      _activities[day]!.add({
        'activity': activity,
        'time': time,
        'description': description ?? '', // If no description, use empty string
      });
    });
  }

  // Helper function to remove an activity from a specific day
  void _removeActivity(DateTime day, Map<String, String> activity) {
    setState(() {
      _activities[day]?.remove(activity);
    });
  }

  // Displaying a dialog to add a new activity
  void _showAddActivityDialog(BuildContext context) {
    String? activity;
    String selectedTime = '00:00'; // Default time
    String? description;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add Activity"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _activityController,
                onChanged: (value) {
                  activity = value;
                },
                decoration: const InputDecoration(hintText: 'Enter activity'),
              ),
              const SizedBox(height: 10),
              // Optional Description field
              TextField(
                controller: _descriptionController,
                onChanged: (value) {
                  description = value;
                },
                decoration: const InputDecoration(hintText: 'Enter description (optional)'),
              ),
              const SizedBox(height: 10),
              // Time picker button
              TextButton(
                onPressed: () async {
                  final timeOfDay = await showTimePicker(
                    context: context,
                    initialTime: const TimeOfDay(hour: 12, minute: 0),
                  );
                  if (timeOfDay != null && mounted) {
                    // ignore: use_build_context_synchronously
                    selectedTime = timeOfDay.format(context);
                  }
                },
                child: Text('Select Time: $selectedTime'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                if (activity != null && activity!.isNotEmpty) {
                  _addActivity(_selectedDay, activity!, selectedTime, description);
                }
                // Clear the text controllers after adding
                _activityController.clear();
                _descriptionController.clear();
              },
              child: const Text('Add'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                // Clear the text controllers if canceled
                _activityController.clear();
                _descriptionController.clear();
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
      appBar: null, // Removed the AppBar to remove the purple bar and title
      body: Column(
        children: [
          // Table Calendar widget with custom styles
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
            calendarStyle: const CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Color(0xFFFFF9C4), // Yellow color for today's date
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Colors.blue, // Black color for selected date
                shape: BoxShape.circle,
              ),
              defaultTextStyle: TextStyle(color: Color(0xFFFFF9C4)), // Yellow text color for default dates
              weekendTextStyle: TextStyle(color: Color(0xFFFFF9C4)), // Yellow text color for weekends
              outsideTextStyle: TextStyle(color: Colors.grey), // Grey for outside current month dates
            ),
            headerStyle: const HeaderStyle(
              titleTextStyle: TextStyle(
                color: Color(0xFFFFF9C4), // Yellow title text
                fontSize: 30, // Bigger font size for the month and year
                fontWeight: FontWeight.bold,
              ),
              leftChevronIcon: Icon(Icons.chevron_left, color: Color(0xFFFFF9C4)),
              rightChevronIcon: Icon(Icons.chevron_right, color: Color(0xFFFFF9C4)),
            ),
          ),

          // List of activities for the selected day
          Expanded(
            child: ListView.builder(
              itemCount: _activities[_selectedDay]?.length ?? 0,
              itemBuilder: (context, index) {
                final activity = _activities[_selectedDay]![index];
                return Dismissible(
                  key: Key(activity['activity']!), // Key should be unique
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    _removeActivity(_selectedDay, activity);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${activity['activity']} removed')),
                    );
                  },
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: const Icon(Icons.delete, color: Color(0xFFFFF9C4)),
                  ),
                  child: Container(
                    color: Colors.black, // Set the background color to black for the activity list
                    child: ListTile(
                      title: Text(
                        '${activity['activity']} - ${activity['time']}',
                        style: const TextStyle(
                          color: Color(0xFFFFF9C4), // Set the text color to white for better visibility
                          fontSize: 16, // Optional: Adjust font size
                        ),
                      ),
                      subtitle: activity['description']!.isNotEmpty
                          ? Text(
                              'Description: ${activity['description']}',
                              style: const TextStyle(
                                color: Color(0xFFFFF9C4), // Light grey for description
                                fontSize: 14, // Optional: Adjust font size for description
                              ),
                            )
                          : null,
                    ),
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
