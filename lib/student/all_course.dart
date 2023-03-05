import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unimate/student/course.dart';
import 'package:unimate/student/student_drawer.dart';

class StudentAllCoursePage extends StatefulWidget {
  const StudentAllCoursePage({Key? key}) : super(key: key);

  @override
  State<StudentAllCoursePage> createState() => _StudentAllCoursePageState();
}

class _StudentAllCoursePageState extends State<StudentAllCoursePage> {
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
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userId = prefs.getString('userId');

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
          debugPrint(docSnapshot.data().toString());
          docSnapshot.data().entries.forEach((element) {
            if (element.key == 'course_id') {
              courseIdList.add(element.value.id);
            }
          });
        }
      });

      debugPrint(courseIdList.first);

      List<Map<String, dynamic>?> courseList = [];
      List<Map<String, dynamic>?> lecturerList = [];

      // Fetch course details and lecture name
      courseIdList.forEach((courseId) async {
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
            // debugPrint(data.toString());
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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("All Courses"),
        ),
        drawer: const StudentDrawer(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
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
      ),
    );
  }
}