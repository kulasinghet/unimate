import 'package:flutter/material.dart';
import 'package:unimate/student/todayItem.dart';

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
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.amber,
                ),
                child: Text(
                  'Main Menu',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.library_books),
                title: const Text('All Courses'),
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return const TodayEventPage();
                  }));
                },
              ),
              ListTile(
                leading: const Icon(Icons.event),
                title: const Text('All Events'),
                onTap: () {
                  // TODO: Handle notifications tap
                },
              ),
              ListTile(
                leading: const Icon(Icons.assignment_ind),
                title: const Text('All Assignments'),
                onTap: () {
                  // TODO: Handle friends tap
                },
              ),
              ListTile(
                leading: const Icon(Icons.score),
                title: const Text('GPA Calculator'),
                onTap: () {
                  // TODO: Handle tasks tap
                },
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Profile'),
                onTap: () {
                  // TODO: Handle tasks tap
                },
              ),
              ListTile(
                leading: const Icon(Icons.exit_to_app),
                title: const Text('Logout'),
                onTap: () {
                  // TODO: Handle tasks tap
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
