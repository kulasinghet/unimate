import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:unimate/student/student_drawer.dart';
import 'addNewEvent.dart';
import 'studentEvent.dart';
import 'package:intl/intl.dart';

class EventList extends StatefulWidget{

  EventList({super.key});

  @override
  State<EventList> createState() => _EventListState();
}

class _EventListState extends State<EventList> {

  List<String> eventNameList = [];
  List<String> eventDateList = [];
  List<String> eventTimeList = [];
  List<String> eventIdList = [];

  @override
  void initState() {
    super.initState();
    fetchAllEvents();
  }

  Future fetchAllEvents() async {
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userId = prefs.getString('userId');

      var db = FirebaseFirestore.instance;

      var query = await db
          .collection('event')
          .where('members',
          arrayContains:
          FirebaseFirestore.instance.collection('users').doc(userId))
          .get()
          .then((querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          querySnapshot.docs.forEach((doc) {
            // print(doc.id); // prints the document ID
            eventIdList.add(doc.id);
          });
          docSnapshot.data().entries.forEach((element) {
            // print(element.value);
            if(element.key == 'title'){
              eventNameList.add(element.value);
            }
            else if(element.key == 'time'){
              // Timestamp timestamp = Timestamp.fromMillisecondsSinceEpoch(int.parse(element.value));
              DateTime dateTime = element.value.toDate();

              String date = DateFormat('yyyy-MMM-dd').format(dateTime);
              String time = DateFormat('HH:mm:ss').format(dateTime);
              eventDateList.add(date);
              eventTimeList.add(time);
              // print(date+" "+time);
            }
            // else if(element.key == 'id'){
            //   // print(element.value+" "+element.key);
            //   eventIdList.add(element.value);
            // }
          });
        }
      });

      // debugPrint("hello"+eventNameList.first.toString());
      // debugPrint(eventIdList.first);
      setState(() {
        // debugPrint(lecturerNameList[0].toString());
      });
    }
    on FirebaseAuthException catch (e) {
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
          title: Text("All Events"),
        ),
        drawer: const StudentDrawer(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
              itemCount: eventNameList.length,
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
                          eventNameList[index],
                          style: const TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          "${eventDateList[index]}\n${eventTimeList[index]}",
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
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => studentEvent(eventIdList[index],eventNameList[index])),
                                  );
                                },
                                child: const Text('View'),
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => addNewEvent(),
              ),
            );

          },
          tooltip: "Create an Event",
          backgroundColor: Colors.amber,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
