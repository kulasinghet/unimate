import 'package:flutter/material.dart';

class addNewEvent extends StatefulWidget{
  const addNewEvent({super.key});

  @override
  State<StatefulWidget> createState() => _addNewEventState();
}

class _addNewEventState extends State<addNewEvent>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Event List',style: TextStyle(fontSize: 20.0),),
        ),
        body: const Text("FORM"),
    );
  }

}