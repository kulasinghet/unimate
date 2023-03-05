import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AttendanceCheck extends StatefulWidget {
  @override
  // I want to pass the course code to this page
  // _AttendanceCheckState createState() => _AttendanceCheckState();
  _AttendanceCheckState createState() => _AttendanceCheckState();
}

class _AttendanceCheckState extends State<AttendanceCheck> {
  String courseCode = '';
  String lecturerId = '';
  bool isAttendanceChecking = false;
  String attendanceButtonLabel = 'Start Attendance Check';
  int attendanceCount = 0;

  Color attendanceButtonColor = Colors.lightGreenAccent;

  // generate a random string
  String secretKey = '';

  onInit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      courseCode = prefs.getString('courseCodeForAttendance')!;
      lecturerId = prefs.getString('userId')!;
      String role = prefs.getString('role')!;

      if (role == 'lecturer') {
        lecturerId = prefs.getString('userId')!;
      } else {
        prefs.clear();
        Navigator.pushReplacementNamed(context, '/login');
      }

      if (isAttendanceChecking) {
        // generate a random string
        attendanceButtonLabel = 'Stop Attendance Check';
      }

      // get the attendance count
      attendanceCount = getAttendanceCount(courseCode) as int;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Attendance Check"),
        backgroundColor: Colors.amber,
        // change the color of the text in the app bar
        foregroundColor: Colors.grey[900],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 40.0,
            ),
            Text(
              'Course Code: $courseCode',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              onPressed: () {
                handleAttendanceCheck();
              },
              child: Text(
                attendanceButtonLabel,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[900],
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: attendanceButtonColor, // background
                onPrimary: Colors.grey[900], // foreground
              ),
              // add amber color to the button
            ),
            SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              onPressed: () {
                if (!isAttendanceChecking) {
                  handleGenerateQRCode();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                        'Cannot generate QR code while checking attendance'),
                    backgroundColor: Colors.red[400],
                    // add text color
                  ));
                }
              },
              child: Text(
                'Generate QR Code',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[900],
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.amber, // background
                onPrimary: Colors.grey[900], // foreground
              ),
              // add amber color to the button
            ),
            SizedBox(
              height: 50.0,
            ),
            // if secretKey is not empty, show the QR code
            if (secretKey != '') ...{
              QrImage(
                data: secretKey,
                version: QrVersions.auto,
                size: 300.0,
              ),
            },
            SizedBox(
              height: 20.0,
            ),
            if (secretKey != '') ...{
              Text(
                'Secret Key: $secretKey',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[600],
                ),
              ),
            },
            SizedBox(
              height: 20.0,
            ),
            Text(
              'Attendance Count: $attendanceCount',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    onInit();
  }

  getLocation() async {
    var status = await Permission.location.status;
    if (status.isGranted) {
      // Your app has permission to access the device's location
      Position position = await Geolocator.getCurrentPosition();
      return position;
    } else {
      // Your app doesn't have permission to access the device's location yet
      await Permission.location.request();
      return getLocation();
    }
  }

  handleGenerateQRCode() {
    // generate a random string
    setState(() {
      secretKey = generateRandomString();
      print(secretKey);
    });

    // save the secret key to the database

    FirebaseFirestore.instance
        .collection('course')
        .where('code', isEqualTo: courseCode)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        // update the secret key
        doc.reference.update({
          'attendance_key': secretKey,
        });
      });
    });
  }

  handleAttendanceCheck() async {
    // start the attendance check

    DateTime attendanceStartTime = DateTime.now();

    if (secretKey == '') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please generate a QR code first'),
        backgroundColor: Colors.red[400],
        // add text color
      ));
      return;
    }

    setState(() {
      if (isAttendanceChecking) {
        attendanceButtonLabel = 'Start Attendance Check';
        isAttendanceChecking = false;
        attendanceButtonColor = Colors.lightGreenAccent;
      } else {
        attendanceButtonLabel = 'Stop Attendance Check';
        isAttendanceChecking = true;
        attendanceButtonColor = Colors.red[400]!;
      }
    });

    Position position = await getLocation();

// save the attendance check to the database
    FirebaseFirestore.instance
        .collection('course')
        .where('code', isEqualTo: courseCode)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        // update the secret key
        doc.reference.update({
          'attendance_enabled': isAttendanceChecking,
          'attendance_start_time': attendanceStartTime,
          'location': GeoPoint(position.latitude, position.longitude),
        });
      });
    });

    if (!isAttendanceChecking) {
      setState(() {
        secretKey = '';
      });
    }
  }

  String generateRandomString() {
    var random = Random();
    var chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    return String.fromCharCodes(Iterable.generate(
        12, (_) => chars.codeUnitAt(random.nextInt(chars.length))));
  }

  @override
  Future<void> dispose() async {
    super.dispose();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('courseCodeForAttendance', '');
  }

  Future<int> getAttendanceCount(String courseID) async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('student_attendance')
          .where('code', isEqualTo: courseID)
          .get();
      print('Attendance count: ${snapshot.size}');
      return snapshot.size;
    } catch (e) {
      print('Error getting attendance count: $e');
      return -1;
    }
  }
}
