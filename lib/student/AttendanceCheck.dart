import 'package:flutter/material.dart';

class AttendanceCheckStudent extends StatefulWidget {
  @override
  _AttendanceCheckStudentState createState() => _AttendanceCheckStudentState();
}

class _AttendanceCheckStudentState extends State<AttendanceCheckStudent> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Attendance Check"),
        ),
        body: Center(
          child: SizedBox(
            height: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'SCS 1220 Data Structures and Algorithms',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text("Saman Kumara"),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      color: Colors.amber,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: 40,
                        child: const Center(
                          child: Text(
                            'Monday 8.00 AM',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      color: Colors.amber,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: 40,
                        child: const Center(
                          child: Text(
                            'Wednesday 8.00 AM',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
