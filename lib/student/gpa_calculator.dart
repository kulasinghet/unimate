import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GPACalculator extends StatefulWidget {
  const GPACalculator({Key? key}) : super(key: key);

  @override
  State<GPACalculator> createState() => _GPACalculatorState();
}

class _GPACalculatorState extends State<GPACalculator> {
  double gpa = 0; // Example GPA value
  List<String> resultList = [];
  List<String> subjectNameList = [];
  List<int> creditList = [];
  int itemCountTotal = 0;
  Map<String, double> gradePoints =
    {"A+": 4.2,
    "A": 4.0,
    "B": 3.0,
    "C": 2.0,
    "F": 0.0};

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
      List<String> resultListTemp = [];
      List<int> creditListTemp = [];
      List<String> subjectNameListTemp = [];

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
          resultListTemp.add(docSnapshot.data()['result']);
          docSnapshot.data().entries.forEach((element) {
            if (element.key == 'course_id') {
              courseIdList.add(element.value.id);
            }
          });
        }
      });

      debugPrint(courseIdList.first);

      // Fetch course details and lecture name
      courseIdList.forEach((courseId) async {
        var collectionRef = db.collection('course');
        var documentId = courseId;
        var documentRef = collectionRef.doc(documentId);

        var documentSnapshot = await documentRef.get();
        // Add credit value to the list
        if (documentSnapshot.exists) {
          var data = documentSnapshot.data();
          creditListTemp.add(data!['credit']);
          subjectNameListTemp.add(data['name']);

          // debugPrint(data.toString());

          setState(() {
            int i = 0;
            creditList = creditListTemp;
            resultList = resultListTemp;
            subjectNameList = subjectNameListTemp;
            itemCountTotal = creditList.length;

            double temp = 0;
            int sum = 0;
            resultList.forEach((result){
              temp = temp + (gradePoints[result]! * creditList[i]);
              sum = sum + creditList[i];
              i++;
            });

            gpa = temp/sum;
          });
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
          title: Text('GPA Calculator'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Your current GPA:',
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              gpa.toStringAsFixed(
                  2), // Display GPA value with 2 decimal points
              style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: itemCountTotal, // Example number of cards
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: const BorderSide(
                          color: Colors.amber,
                          width: 1,
                        ),
                      ),
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              subjectNameList.isNotEmpty
                                  ? "Subject Name: ${subjectNameList[index]}"
                                  : "",
                              style: const TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              subjectNameList.isNotEmpty
                                  ? "Credits: ${creditList[index]}"
                                  : "",
                              style: TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              subjectNameList.isNotEmpty
                                  ? "Result: ${resultList[index]}"
                                  : "",
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
