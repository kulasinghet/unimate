import 'package:flutter/material.dart';

class LecturerDrawer extends StatefulWidget {
  const LecturerDrawer({Key? key}) : super(key: key);

  @override
  State<LecturerDrawer> createState() => _LecturerDrawerState();
}

class _LecturerDrawerState extends State<LecturerDrawer> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

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
                return const Placeholder();
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
