import 'package:flutter/material.dart';

class studentEvent extends StatefulWidget{

  var eventId;
  studentEvent(this.eventId,{super.key});

  @override
  State<StatefulWidget> createState() => _studentEventState(eventId);
}

class _studentEventState extends State<studentEvent>{
  var eventId;
  _studentEventState(this.eventId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event List',style: TextStyle(fontSize: 20.0),),
      ),
      body: Text(eventId)
    );
  }

}