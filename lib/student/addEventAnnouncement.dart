import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:unimate/student/student_drawer.dart';

class CreateEventAnnouncement extends StatefulWidget{

  late String _eventID;
  CreateEventAnnouncement(this._eventID, {super.key});

  @override
  State<StatefulWidget> createState() => _CreateEventAnnouncementState(_eventID);
}

class _CreateEventAnnouncementState extends State<CreateEventAnnouncement>{
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late String _eventID;
  late String _title;
  late String _description;
  late DateTime _datetime;

  _CreateEventAnnouncementState(this._eventID);

  Widget _buildAnnouncementTitleField() {
    return TextFormField(
      validator: (text) {
        return HelperValidator.titleValidate(text!);
      },
      maxLength: 30,
      maxLines: 1,
      decoration:
      const InputDecoration(
        labelText: 'Title',
        hintText: 'Enter the Announcement Title',
        border: OutlineInputBorder(),
      ),
      onSaved: (value) {
        _title = value!;
      },
    );
  }

  Widget _buildAnnouncementMsgField() {
    return TextFormField(
      maxLength: 50,
      maxLines: 4,
      validator: (text) {
        return HelperValidator.AnnouncementMsgValidation(text!);
      },
      decoration:
      const InputDecoration(
        labelText: 'Message',
        hintText: 'Enter Event Message',
        border: OutlineInputBorder(),
      ),
      onSaved: (value) {
        _description = value!;
      },
    );
  }

  Future createEventAnnouncement(String title, String description) async {
    DateTime dateTime = DateTime.now();
    // convert DateTime to timestamp (in milliseconds)
    int timestamp = dateTime.millisecondsSinceEpoch;

    CollectionReference collectionReference =
    FirebaseFirestore.instance.collection('event_announcement');
    collectionReference.add({
      'title': title,
      'description': description,
      'time': timestamp,
      'event_id': FirebaseFirestore.instance.collection('event').doc(_eventID),
    }).then((DocumentReference documentReference) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Announcement Created Successfully"),
        backgroundColor: Colors.green
      ));
      //msg success

    }).catchError((error) {
// handle errors
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Announcement Creation Failed"),
          backgroundColor: Colors.red
      ));
      //msg failed
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      drawer: const StudentDrawer(),
      body: SingleChildScrollView(
        child:Column(
          children: [
            Container(
              height:220,
              margin:EdgeInsets.only(left:5.0,right:5.0,bottom:5.0,top:5.0),
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
                          "https://aurealisawards.files.wordpress.com/2016/02/announcement.gif?w=468&zoom=2"
                      )
                  )
              ),
            ),
            const SizedBox(height: 15.0),
            const Text(
                "Create New Announcement",
                style: TextStyle(
                  fontSize: 22.0,
                  color: Colors.grey,
                ),
            ),
            Divider(thickness: 2.0,),
            Container(
              margin: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: _buildAnnouncementTitleField(),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: _buildAnnouncementMsgField(),
                    ),
                    SizedBox(height: 30),
                    Container(
                      width: 150,
                      child: ElevatedButton(
                        child: const Text(
                          'Create',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                        onPressed: () {
                          print('create button pressed');
                          if (_formKey.currentState!.validate()) {
                            print('valid form');
                            _formKey.currentState!.save();
                            createEventAnnouncement(_title, _description);
                          } else {
                            print('not valid form');

                            return;
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
      ),
    );
  }
}

class HelperValidator {
  static String? titleValidate(String value) {
    RegExp exp1 = RegExp(r'\d|\W');
    if (value.isEmpty) {
      return "Name can't be empty";
    }
    if (value.length < 2) {
      return "Name must be at least 2 characters long";
    }
    if (value.length > 30) {
      return "Name must be less than 50 characters long";
    }
    if(exp1.hasMatch(value[0])){
      return "Name must be starts with a letter";
    }
    return null;
  }
  static String? AnnouncementMsgValidation(String value) {
    if (value.isEmpty) {
      return "Description can't be empty";
    }
    if (value.length < 5) {
      return "Name must be at least 5 characters long";
    }
    if (value.length > 50) {
      return "Description must be less than 50 characters long";
    }
    return null;
  }
}