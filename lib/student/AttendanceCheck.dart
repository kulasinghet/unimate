import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:shared_preferences/shared_preferences.dart';

class AttendanceCheckStudent extends StatefulWidget {
  String AttendanceKey = "";

  @override
  _AttendanceCheckStudentState createState() => _AttendanceCheckStudentState();
}

class _AttendanceCheckStudentState extends State<AttendanceCheckStudent> {
  int isAttendanceValid = -1;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Attendance Check"),
        ),
        body: Center(
          child: SizedBox(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  if (isAttendanceValid != 0) ...[
                    SvgPicture.asset(
                      'assets/svgs/undraw_two_factor_authentication_namy.svg',
                      height: 200,
                    ),
                  ],
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      int attendanceStatus = await handleCheckAttendance();

                      print("attendanceStatusrec: $attendanceStatus");

                      if (attendanceStatus == 0) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              "Attendance has been verified successfully!"),
                          backgroundColor: Colors.green,
                        ));
                      } else if (attendanceStatus == 1) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              "Attendance has not been enabled for this course!"),
                          backgroundColor: Colors.red,
                        ));
                      } else if (attendanceStatus == 2) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              "Attendance has not been enabled for this course!"),
                          backgroundColor: Colors.red,
                        ));
                      } else if (attendanceStatus == 3) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              "Attendance has already been marked for this course!"),
                          backgroundColor: Colors.red,
                        ));
                      } else if (attendanceStatus == 7) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content:
                              Text("Your distance from the class is too far!"),
                          backgroundColor: Colors.red,
                        ));
                      }
                    },
                    child: Text("Verify Attendance"),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.amber,
                      onPrimary: Colors.grey[800],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  if (isAttendanceValid == 0) ...[
                    Padding(
                      padding: EdgeInsets.fromLTRB(40.0, 10.0, 40.0, 10.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Attendance Key',
                          contentPadding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a valid Attendance Key';
                          }
                        },
                        onChanged: (value) {
                          widget.AttendanceKey = value;
                        },
                        keyboardType: TextInputType.visiblePassword,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          if (await handleMarkAttendance()) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Attendance has been marked!"),
                              backgroundColor: Colors.green,
                            ));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Invalid Attendance Key!"),
                              backgroundColor: Colors.red,
                            ));
                          }
                        },
                        child: Text("Mark Attendance"),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.amber,
                          onPrimary: Colors.grey[800],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0),
                          ),
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          handleQRCodeScan();
                        },
                        child: Text("Scan QR Code"),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.amber,
                          onPrimary: Colors.grey[800],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0),
                          ),
                        )),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<int> handleCheckAttendance() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? courseIdToMarkAttendance =
        prefs.getString('courseIdToMarkAttendance');

    print("courseIdToMarkAttendance: $courseIdToMarkAttendance");

    Position position = await getLocation();

    FirebaseFirestore.instance
        .collection('course')
        .where('code', isEqualTo: courseIdToMarkAttendance)
        .get()
        .then((QuerySnapshot querySnapshot) {
      // get the first document from the list (assuming there is only one)
      DocumentSnapshot documentSnapshot = querySnapshot.docs.first;

      String code = documentSnapshot.get('code');
      bool attendance_enabled = documentSnapshot.get('attendance_enabled');
      Timestamp attendance_start_time =
          documentSnapshot.get('attendance_start_time');
      GeoPoint location = documentSnapshot.get('location');
      String attendance_key = documentSnapshot.get('attendance_key');

      GeoPoint userLocation = GeoPoint(position.latitude, position.longitude);

      prefs.setString('attendance_key', attendance_key);
      prefs.setString(
          'attendance_start_time', attendance_start_time.seconds.toString());

      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
          attendance_start_time.seconds * 1000);
      // use the course object as needed

      print("first databae call");

      // check if datetime is within 2 minutes of current time
      if (attendance_enabled) {
        if (dateTime.isBefore(DateTime.now().add(Duration(hours: 2)))) {
          print("this if else is called");
          if (checkAlreadyAttend(userLocation, location)) {
            print("attendance has already been marked");
            isAttendanceValid = 3;
            setState(() {
              isAttendanceValid = 3;
            });
          }
        } else {
          print("attendance has not beeskdfhjksdhjn marked");
        }
      } else {
        isAttendanceValid = 1;
        setState(() {
          isAttendanceValid = 1;
        });
      }
    });

    print("isAttendanceValidfinal: $isAttendanceValid");
    return isAttendanceValid;
  }

  Future<bool> handleMarkAttendance() async {
// get the attendance key from shared preferences
// compare it with the attendance key entered by the user
// if they match, mark attendance
// else, show error message

    // get GeoLocation

    print("handleMarkAttendance: ${widget.AttendanceKey}");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? attendance_key = prefs.getString('attendance_key');

    print("attendance_key: $attendance_key");
    print("widget.AttendanceKey: ${widget.AttendanceKey}");

    if (attendance_key == widget.AttendanceKey) {
// mark attendance

      DateTime now = prefs.getString('attendance_start_time') != null
          ? DateTime.fromMillisecondsSinceEpoch(
              int.parse(prefs.getString('attendance_start_time')!) * 1000)
          : DateTime.now();

      Timestamp timestamp = Timestamp.fromDate(now);

      CollectionReference collectionReference =
          FirebaseFirestore.instance.collection('student_attendance');
      collectionReference.add({
        'student_id': prefs.getString('userId'),
        'course_id': prefs.getString('courseIdToMarkAttendance'),
        'attendance': true,
        'time': timestamp,
      }).then((DocumentReference documentReference) {
// print the ID of the new document
        print('Document added with ID: ${documentReference.id}');
        return true;
      }).catchError((error) {
// handle errors
        print('Error adding document: $error');
        return false;
      });
      return true;
    } else {
// show error message
      return false;
    }

    return false;
  }

  checkAlreadyAttend(userLocation, location) async {
    print('this checkAlreadyAttend is called');
    SharedPreferences prefs = await SharedPreferences.getInstance();

    FirebaseFirestore.instance
        .collection('student_attendance')
        .where('student_id', isEqualTo: prefs.getString('userId'))
        .where('course_id',
            isEqualTo: prefs.getString('courseIdToMarkAttendance'))
        .where('attendance', isEqualTo: true)
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isEmpty) {
        print("attendance has not been marked");
        isAttendanceValid = 0;
        setState(() {
          isAttendanceValid = 0;
        });

        if (isLessThan100meters(userLocation, location)) {
          print("isLessThan100m");
          isAttendanceValid = 0;
          setState(() {
            isAttendanceValid = 0;
          });
        } else {
          print("isMoreThan100m");
          isAttendanceValid = 7;
          setState(() {
            isAttendanceValid = 7;
          });
        }

        return;
      } else {
        DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
        Timestamp time = documentSnapshot.get('time');

        print("isAttendanceValidSecond: ${isAttendanceValid}");

        DateTime dateTime =
            DateTime.fromMillisecondsSinceEpoch(time.seconds * 1000);

        if (dateTime.isBefore(DateTime.now().add(Duration(hours: 2)))) {
          print("attendance has been marked");
          isAttendanceValid = 3;
          setState(() {
            isAttendanceValid = 3;
          });
        }
      }
    });

    return isAttendanceValid;
  }

  // var status = await Permission.location.status;
  // if (status.isGranted) {
  // // Your app has permission to access the device's location
  // Position position = await Geolocator.getCurrentPosition();
  // return position;
  // } else {
  // // Your app doesn't have permission to access the device's location yet
  // await Permission.location.request();
  // return getLocation();
  // }

  Future<void> handleQRCodeScan() async {
    var status = await Permission.camera.status;
    if (status.isGranted) {
      // Your app has permission to access the device's location
      try {
        final String? qrCode = await scanner.scan();
        if (qrCode != null) {
          print('QR code scanned: $qrCode');

          widget.AttendanceKey = qrCode;

          if (await handleMarkAttendance()) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Attendance has been marked!"),
              backgroundColor: Colors.green,
            ));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Invalid Attendance Key!"),
              backgroundColor: Colors.red,
            ));
          }
        } else {
          print('QR code not scanned');
        }
      } catch (e) {
        print('Error scanning QR code: $e');
      }
    } else {
      // Your app doesn't have permission to access the device's location yet
      await Permission.camera.request();
      handleQRCodeScan();
    }
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

  bool isLessThan100meters(GeoPoint userLocation, GeoPoint location) {
    double distanceInMeters = Geolocator.distanceBetween(userLocation.latitude,
        userLocation.longitude, location.latitude, location.longitude);
    print("distanceInMeters: $distanceInMeters");
    if (distanceInMeters < 100) {
      print("distance is less than 100m");
      return true;
    } else {
      print("distance is greater than 100m");
      return false;
    }
  }
}
