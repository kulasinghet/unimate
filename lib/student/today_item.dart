import 'package:flutter/material.dart';

class TodayLecturesPage extends StatefulWidget {
  const TodayLecturesPage({Key? key}) : super(key: key);

  @override
  State<TodayLecturesPage> createState() => _TodayLecturesPageState();
}

class _TodayLecturesPageState extends State<TodayLecturesPage> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text("Item ${index + 1}"),
            leading: const Icon(Icons.person),
            trailing: const Icon(Icons.adb),
            onTap: () {
              debugPrint("Clicked $index");
            },
          );
        });
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
    return const Placeholder();
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




