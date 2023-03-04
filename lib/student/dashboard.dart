import 'package:flutter/material.dart';
import 'package:unimate/student_drawer.dart';
import 'package:unimate/student/today_item.dart';

class StudentDashboard extends StatefulWidget {
  const StudentDashboard({Key? key}) : super(key: key);

  @override
  State<StudentDashboard> createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {

  var currentPage = 0;
  List<Widget> pages = const [TodayLecturesPage(), TodayEventPage(), TodayAssignmentPage(), ClassNotification()];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: pages[currentPage],
        appBar: AppBar(
          title: const Text("Dashboard"),
        ),
        bottomNavigationBar: NavigationBar(
          destinations: const [
            NavigationDestination(icon: Icon(Icons.library_books), label: 'Lectures'),
            NavigationDestination(icon: Icon(Icons.event), label: 'Events'),
            NavigationDestination(icon: Icon(Icons.assignment_ind), label: 'Assignments'),
            NavigationDestination(icon: Icon(Icons.notifications), label: 'Notification')
          ],
          onDestinationSelected: (value) {
            // Change the state for refresh the widget
            setState(() {
              currentPage = value;
            });
          },
          selectedIndex: currentPage,
        ),
        drawer: const StudentDrawer(),
      ),
    );
  }
}
