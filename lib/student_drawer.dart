import 'package:flutter/material.dart';

import 'student/all_course.dart';

class StudentDrawer extends StatefulWidget {
  const StudentDrawer({Key? key}) : super(key: key);

  @override
  State<StudentDrawer> createState() => _StudentDrawerState();
}

class _StudentDrawerState extends State<StudentDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
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
                return const AllCoursePage();
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
    );
  }
}
