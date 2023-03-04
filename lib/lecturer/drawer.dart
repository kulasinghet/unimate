import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  Future<void> clearSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
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
              clearSharedPrefs();
              Navigator.pushNamed(context, '/login');
            },
          )
        ],
      ),
    );
  }
}
