import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'assingment.dart';
import 'course.dart';

class TodayLecturesPage extends StatefulWidget {
  const TodayLecturesPage({Key? key}) : super(key: key);

  @override
  State<TodayLecturesPage> createState() => _TodayLecturesPageState();
}

class _TodayLecturesPageState extends State<TodayLecturesPage> {
  List<Map<String, dynamic>?> itemList = [];
  List<Map<String, dynamic>?> lecturerNameList = [];
  List<String> courseIdListGlobal = [];
  int listSize = 0;

  @override
  void initState() {
    fetchAllCourses();
    super.initState();
  }

  Future<int> fetchAllCourses() async {
    // Get today day name first

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userId = prefs.getString('userId');

      // Get day of week
      String dayOfWeek = getDayOfWeek();
      var db = FirebaseFirestore.instance;

      List<String> courseIdList = [];

      var query = await db
          .collection('student_course')
          .where('student_id',
          isEqualTo:
          FirebaseFirestore.instance.collection('users').doc(userId))
          .get()
          .then((querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          // courseIdList.add(docSnapshot.data().entries.elementAt(1).value.id);
          docSnapshot.data().entries.forEach((element) {
            if(element.key == 'course_id') {
              courseIdList.add(element.value.id);
            }
          });
        }
      });


      List<Map<String, dynamic>?> courseList = [];
      List<Map<String, dynamic>?> lecturerList = [];


      // Fetch course details and lecture name
      courseIdList.forEach((courseId) async {
        var collection = FirebaseFirestore.instance.collection('course');

        var querySnapshot = await collection
            .where(FieldPath.documentId, isEqualTo: courseId)
            .where('day', isEqualTo: dayOfWeek)
            .get();

        if (querySnapshot.size == 1) {
          var data = querySnapshot.docs.first.data();
          courseList.add(data);

          String lecturerId = '';
          querySnapshot.docs.first.data().entries.forEach((element) {
            if(element.key == 'lecture_id') {
              lecturerId = element.value.id;
            }
          });

          var collectionRef = db.collection('users');
          var documentRef = collectionRef.doc(lecturerId);
          var documentSnapshot = await documentRef.get();

          if (documentSnapshot.exists) {
            var data = documentSnapshot.data();
            lecturerList.add(data);
            setState(() {
              itemList = courseList;
              lecturerNameList = lecturerList;
              // Setting course ID list
              itemList.forEach((element) {
                element?.entries.forEach((pair) {
                  if(pair.key == 'course_id') {
                    courseIdList.add(pair.value.id);
                  }
                });
              });
              courseIdListGlobal = courseIdList;
              listSize = lecturerNameList.length;
              // debugPrint(lecturerNameList[0].toString());
            });
          }
        }


      });


    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        return 1;
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Today Lectures", // Display GPA value with 2 decimal points
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
                itemCount: listSize,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.background,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            itemList[index]!['code'] +
                                " " +
                                itemList[index]!['name'],
                            style: const TextStyle(
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            lecturerNameList[index]!['name'],
                            style: const TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                          SizedBox(height: 16.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                width: 120.0,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    SharedPreferences prefs = await SharedPreferences.getInstance();
                                    prefs.setString("courseId", courseIdListGlobal[index]);

                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (BuildContext context) {
                                          return const StudentCourse();
                                        }));
                                  },
                                  child: Text('Enter'),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );;
  }
}

class TodayEventPage extends StatefulWidget {
  const TodayEventPage({Key? key}) : super(key: key);

  @override
  State<TodayEventPage> createState() => _TodayEventPageState();
}

class _TodayEventPageState extends State<TodayEventPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class TodayAssignmentPage extends StatefulWidget {
  const TodayAssignmentPage({Key? key}) : super(key: key);

  @override
  State<TodayAssignmentPage> createState() => _TodayAssignmentPageState();
}

class _TodayAssignmentPageState extends State<TodayAssignmentPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Today Assignments", // Display GPA value with 2 decimal points
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              itemCount: 1,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.background,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'SCS2012 - Assignment Title',
                              style: TextStyle(
                                fontSize: 22.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Checkbox(
                              value: true,
                              visualDensity: VisualDensity.comfortable,
                              onChanged: (bool? changed) {},
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 4.0,
                        ),
                        const Text(
                          'This is a small description of what the assignment is about !',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                        const SizedBox(
                          height: 12.0,
                        ),
                        const Text(
                          'Deadline: 2023-05-12',
                          style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              color: Colors.green),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ClassNotification extends StatefulWidget {
  const ClassNotification({Key? key}) : super(key: key);

  @override
  State<ClassNotification> createState() => _ClassNotificationState();
}

class _ClassNotificationState extends State<ClassNotification> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

// Returns today's day of the week
String getDayOfWeek() {
  // Get the current system date
  DateTime now = DateTime.now();

  // Use the weekday property to determine the day of the week
  switch (now.weekday) {
    case 1:
      return 'Monday';
    case 2:
      return 'Tuesday';
    case 3:
      return 'Wednesday';
    case 4:
      return 'Thursday';
    case 5:
      return 'Friday';
    case 6:
      return 'Saturday';
    case 7:
      return 'Sunday';
    default:
      return '';
  }
}
