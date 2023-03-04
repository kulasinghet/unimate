import 'package:flutter/material.dart';

import 'assingment.dart';
import 'course.dart';

class TodayLecturesPage extends StatefulWidget {
  const TodayLecturesPage({Key? key}) : super(key: key);

  @override
  State<TodayLecturesPage> createState() => _TodayLecturesPageState();
}

class _TodayLecturesPageState extends State<TodayLecturesPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Today Lectures", // Display GPA value with 2 decimal points
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.background,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          'SCS2012 Data Structures and Algorithms',
                          style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        const Text(
                          'Saman Kumara',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: 120.0,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                                    return const StudentCourse();
                                  }));
                                },
                                child: Text('Enter'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );;
  }
}

class TodayEventPage extends StatefulWidget {
  const TodayEventPage({Key? key}) : super(key: key);

  @override
  State<TodayEventPage> createState() => _TodayEventPageState();
}

class _TodayEventPageState extends State<TodayEventPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class TodayAssignmentPage extends StatefulWidget {
  const TodayAssignmentPage({Key? key}) : super(key: key);

  @override
  State<TodayAssignmentPage> createState() => _TodayAssignmentPageState();
}

class _TodayAssignmentPageState extends State<TodayAssignmentPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Today Assignments", // Display GPA value with 2 decimal points
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.background,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'SCS2012 - Assignment Title',
                              style: TextStyle(
                                fontSize: 22.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Checkbox(
                              value: true,
                              visualDensity: VisualDensity.comfortable,
                              onChanged: (bool? changed) {},
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 4.0,
                        ),
                        const Text(
                          'This is a small description of what the assignment is about !',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                        const SizedBox(
                          height: 12.0,
                        ),
                        const Text(
                          'Deadline: 2023-05-12',
                          style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              color: Colors.green),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ClassNotification extends StatefulWidget {
  const ClassNotification({Key? key}) : super(key: key);

  @override
  State<ClassNotification> createState() => _ClassNotificationState();
}

class _ClassNotificationState extends State<ClassNotification> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
