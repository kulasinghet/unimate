import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:unimate/student_drawer.dart';
import 'addNewEvent.dart';
import 'studentEvent.dart';

void main() async {
  // Initialize Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Event List',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      debugShowCheckedModeBanner: false,
      home: EventListBuilder(),
    );
  }
}

class EventListBuilder extends StatefulWidget{

  EventListBuilder({super.key});

  @override
  State<EventListBuilder> createState() => _EventListBuilderState();
}

class _EventListBuilderState extends State<EventListBuilder> {

  List<Map<String, dynamic>?> eventNameList = [];
  List<Map<String, dynamic>?> eventDateList = [];
  // List<Map<String, dynamic>?> eventIdList = [];

  var items = List<String>.generate(5, (index) => 'Item ${index+1}');
  var dates = List<String>.generate(5, (index) => 'Item ${index+1}');

  var eventId = '0';

  @override
  void initState() {
    super.initState();
    fetchAllEvents();
  }

  Future fetchAllEvents() async {
    try{
      print("Hello");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userId = prefs.getString('userId');

      var db = FirebaseFirestore.instance;

      List<String> eventIdList = [];

      var query = await db
          .collection('event')
          .where('members',
          arrayContains:
          FirebaseFirestore.instance.collection('users').doc(userId))
          .get()
          .then((querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          eventIdList.add(docSnapshot.data().entries.elementAt(1).value.id);
        }
      });

      debugPrint(eventIdList.first);
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
    final List<String> _items = [
      'Item 1',
      'Item 2',
      'Item 3',
      'Item 4',
      'Item 5',
      'Item 1',
      'Item 2',
      'Item 3',
      'Item 4',
      'Item 5'
    ];

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("All Events"),
        ),
        drawer: const StudentDrawer(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
              itemCount: items.length,
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
                          'MADhack 2.0 Delegates',
                          style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          'Jan 12',
                          style: TextStyle(
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
                                        builder: (context) => studentEvent(eventId,'MADhack 2.0 Delegates')),
                                  );
                                },
                                child: const Text('Enter'),
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
