import 'package:flutter/material.dart';
import 'package:unimate/lecturer/assignment_list.dart';
import 'package:unimate/lecturer/course_list.dart';
import 'package:unimate/lecturer/drawer.dart';

class LectureDashboard extends StatefulWidget {
  const LectureDashboard({Key? key}) : super(key: key);

  @override
  State<LectureDashboard> createState() => _LectureDashboardState();
}

class _LectureDashboardState extends State<LectureDashboard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  var currentPage = 0;
  List<Widget> pages = const [CourseListPage(), AssignmentListPage()];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
            NavigationDestination(icon: Icon(Icons.cast_for_education), label: 'Courses'),
            NavigationDestination(icon: Icon(Icons.assignment_ind), label: 'Assignments'),
            // NavigationDestination(icon: Icon(Icons.notifications), label: 'Notification')
          ],
          onDestinationSelected: (value) {
            // Change the state for refresh the widget
            setState(() {
              currentPage = value;
            });
          },
          selectedIndex: currentPage,
        ),
        drawer: const LecturerDrawer(),
      ),
    );
  }
}

