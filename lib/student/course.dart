import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unimate/student/AttendanceCheck.dart';
import 'package:unimate/student/assingment.dart';

List<String> weekdays = [
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday'
];

class StudentCourse extends StatefulWidget {
  const StudentCourse({Key? key}) : super(key: key);

  @override
  State<StudentCourse> createState() => _StudentCourseState();
}

class _StudentCourseState extends State<StudentCourse> {
  String dropdownValue = weekdays.first;
  List<Map<String, dynamic>?> itemList = [];
  List<Map<String, dynamic>?> lecturerNameList = [];
  List<String> courseIdListGlobal = [];
  List<Map<String, dynamic>?> announcementList = [];

  @override
  void initState() {
    fetchCourse();
    super.initState();
  }

  Future<int> fetchCourse() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? courseId = prefs.getString('courseId');

      var db = FirebaseFirestore.instance;

      List<String> courseIdList = [];

      List<Map<String, dynamic>?> courseList = [];
      List<Map<String, dynamic>?> lecturerList = [];

      // Fetch course details and lecture name
      var collectionRef = db.collection('course');
      var documentId = courseId;
      var documentRef = collectionRef.doc(documentId);

      var documentSnapshot = await documentRef.get();
      // Only fetch lecturer details when there is valid course
      if (documentSnapshot.exists) {
        var data = documentSnapshot.data();
        courseList.add(data);
        // debugPrint(data.toString());

        String lecturerId = '';
        documentSnapshot.data()?.entries.forEach((element) {
          if (element.key == 'lecture_id') {
            lecturerId = element.value.id;
          }
        });

        collectionRef = db.collection('users');
        documentRef = collectionRef.doc(lecturerId);
        documentSnapshot = await documentRef.get();
        documentSnapshot = await documentRef.get();

        if (documentSnapshot.exists) {
          var data = documentSnapshot.data();
          lecturerList.add(data);
          setState(() {
          // debugPrint(data.toString());
            lecturerNameList = lecturerList;
            itemList = courseList;
            courseIdListGlobal = courseIdList;
            // debugPrint(lecturerNameList[0].toString());
          });
        }

        List<Map<String, dynamic>?> tempAnnouncementList = [];
        //  Fetch announcements

        var query = await db
            .collection('course_announcement')
            .where('course_id',
                isEqualTo: FirebaseFirestore.instance
                    .collection('course')
                    .doc(courseId))
            .orderBy('time', descending: true)
            .get()
            .then((querySnapshot) {
          for (var docSnapshot in querySnapshot.docs) {
            debugPrint(docSnapshot.data().toString());
            tempAnnouncementList.add(docSnapshot.data());
          }

          setState(() {
            announcementList = tempAnnouncementList;
          });
        });
      }
    } on FirebaseAuthException catch (e) {
      if (false) {
        return 1;
      } else if (e.code == 'email-already-in-use') {
        return 2;
      }
    } catch (e) {
      print(e);
      return 3;
    }
    return 3;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Course Details"),
          ),
          body: Center(
            child: SizedBox(
              height: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        itemList.isNotEmpty
                            ? itemList[0]!['code'] + " " + itemList[0]!['name']
                            : " ",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 28.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      lecturerNameList.isNotEmpty
                          ? lecturerNameList[0]!['name']
                          : " ",
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
                          child: Center(
                            child: Text(
                              itemList.isNotEmpty
                                  ? itemList[0]!['day'] +
                                      " " +
                                      itemList[0]!['time']
                                  : " ",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 150,
                      child: ElevatedButton(
                        onPressed: () {
                          SharedPreferences.getInstance().then((prefs) {
                            prefs.setString(
                                'courseIdToMarkAttendance', 'SCS1202');
                          });

                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) {
                            return AttendanceCheckStudent();
                          }));
                        },
                        child: const Text("Mark Attendance"),
                      ),
                    ),
                    SizedBox(
                      width: 150,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) {
                            return const StudentAssignment();
                          }));
                        },
                        child: const Text("Assignments"),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      'Announcements',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: announcementList.map((item) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                          child: Card(
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: Theme.of(context).colorScheme.background,
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  TimeStampText(item!['time']),
                                  const SizedBox(height: 8.0),
                                  Text(
                                    item['description'],
                                    style: const TextStyle(
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }
}

// Widget to create time

class TimeStampText extends StatelessWidget {
  final Timestamp timestamp;

  TimeStampText(this.timestamp);

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = timestamp.toDate(); // convert Timestamp to DateTime
    String formattedDate =
        '${dateTime.year}-${dateTime.month}-${dateTime.day}'; // format the date
    String formattedTime =
        '${dateTime.hour}:${dateTime.minute}:${dateTime.second}'; // format the time

    return Text(
      '$formattedDate - $formattedTime',
      style: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
