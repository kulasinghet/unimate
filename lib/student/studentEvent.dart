import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unimate/student/addEventAnnouncement.dart';
import 'package:unimate/student/student_drawer.dart';
import 'package:unimate/student/viewMembers.dart';
import 'package:intl/intl.dart';

class studentEvent extends StatefulWidget{

  String _eventId;
  String _title;
  studentEvent(this._eventId,this._title,{super.key});

  @override
  State<StatefulWidget> createState() => _studentEventState(_eventId,_title);
}

class _studentEventState extends State<studentEvent>{
  String _eventId;
  String _title;
  String _description = "";
  String _venue ="";
  String _date="";
  String _time="";
  List<String> _announcementTitles = [];
  List<String> _announcementDescriptions = [];
  List<String> _announcementTimes = [];
  var itemList = List<String>.generate(10, (index) => 'Item ${index+1}');
  _studentEventState(this._eventId,this._title);

  @override
  void initState() {
    super.initState();
    fetchEvent();
  }

  Future fetchEvent() async {
    try{
      var db = FirebaseFirestore.instance;

      var collectionRef = db.collection('event');
      var documentId = _eventId;
      var documentRef = collectionRef.doc(documentId);

      var documentSnapshot = await documentRef.get();

      if(documentSnapshot.exists){
        print("Document exists on the database");
        // print(documentSnapshot.data());
        documentSnapshot.data()?.entries.forEach((element) {
          // print(element.value);
          if(element.key == 'title'){
            _title = element.value;
          }
          else if(element.key == 'time'){
            // Timestamp timestamp = Timestamp.fromMillisecondsSinceEpoch(int.parse(element.value));
            DateTime dateTime = element.value.toDate();

            String date = DateFormat('yyyy-MMM-dd').format(dateTime);
            String time = DateFormat('h:mm a').format(dateTime);
            _date = date;
            _time = time;
          }
          else if(element.key == 'description'){
            _description = element.value;
          }
          else if(element.key == 'venue'){
            _venue = element.value;
          }
        });
      }
      else{
        print("Document does not exist on the database");
      }
      // print("HEEE"+_eventId);


      var query2 = await db
          .collection('event_announcement')
          .where('event_id',
          isEqualTo:
          FirebaseFirestore.instance.collection('event').doc(_eventId))
          .get()
          .then((querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          docSnapshot.data().entries.forEach((element) {
            print(docSnapshot.data().toString());
            if(element.key == 'title'){
              // print("HEEE"+element.value);
              _announcementTitles.add(element.value);
            }
            else if(element.key == 'time'){
              // print(element.value);
              // Timestamp timestamp = Timestamp.fromMillisecondsSinceEpoch(int.parse(element.value));
              DateTime dateTime = element.value.toDate();

              String date = DateFormat('yyyy-MMM-dd').format(dateTime);
              String time = DateFormat('h:mm a').format(dateTime);
              _announcementTimes.add("$date $time");
            }
            else if(element.key == 'description'){
              // print(element.value);
              _announcementDescriptions.add(element.value);
            }
          });
        }
      });

      setState(() {
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
    return Scaffold(
      appBar: AppBar(
        title: Text(_title,style: TextStyle(fontSize: 20.0),),
      ),
        drawer: const StudentDrawer(),
      body: SingleChildScrollView(
        child:Column(
          children: [
            Container(
              height:220,
              margin:EdgeInsets.only(left:5.0,right:5.0,top:5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 1.0,
                    ),
                  ],
                  color: Theme.of(context).colorScheme.background,
                  image: const DecorationImage(
                      fit:BoxFit.cover,
                      image:NetworkImage(
                          "https://img.freepik.com/free-vector/events-concept-illustration_114360-931.jpg"
                      )
                  )
              ),
            ),
            const SizedBox(height: 15.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewMembers()),
                    );
                  },
                  child: Text("View Members"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CreateEventAnnouncement(_eventId)),
                    );
                  },
                  child: Text("Create New Announcement"),
                ),
              ],
            ),
            const SizedBox(height: 15.0),
            Divider(height: 5.0,thickness: 2.0),
            Container(
              margin:const EdgeInsets.only(top:15.0),
              child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_title, style:const TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  )),
                  Text(_date, style:const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  )),
                  Text(_time, style:const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  )),
                ],
              ),
            ),
            const SizedBox(height: 15.0),
            const Divider(height: 5.0,thickness: 2.0),
            Container(
                margin:const EdgeInsets.only(left:5,right:5,top:15.0),
                padding: const EdgeInsets.only(left:10,right:10,top:15.0,bottom: 15.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  borderRadius: BorderRadius.circular(10),
                ),
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Description",style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ),),
                    SizedBox(height: 10.0),
                    Text(
                      _description,
                      style: const TextStyle(
                        fontSize: 16.0,
                        wordSpacing: 4.0,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ],
                )
            ),
            const SizedBox(height: 10.0),
            const Divider(height: 5.0,thickness: 2.0),
            Container(
                margin:EdgeInsets.only(left:5.0,right:5.0,top:15.0),
                child:Column(
                  children: const [
                    Text("Announcements", style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                    ),
                  ],
                )
            ),

            Column(
                children: _announcementTitles.map((title) {
                  return _buildAnnouncement(title);
                  // int index++;
                }).toList()
            )
          ],
        ),
      )

    );
  }

  Widget _buildAnnouncement(title)
  {
    return Container(
      margin:const EdgeInsets.only(left:5,right:5,top:15.0),
      padding: const EdgeInsets.only(left:10,right:10,top:15.0,bottom: 15.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(title,style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),),
          const SizedBox(height: 15.0),
          const Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
            style: TextStyle(
              fontSize: 14.0,
            ),
          )
        ],
      ),
    );
  }

}