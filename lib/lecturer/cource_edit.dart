import 'package:flutter/material.dart';

class EditCourse extends StatefulWidget {
  const EditCourse({Key? key}) : super(key: key);

  @override
  State<EditCourse> createState() => _EditCourseState();
}

class _EditCourseState extends State<EditCourse> {
  String _courseID = '';
  String _courseName = '';
  String _lecturerName = '';
  String _lecTime = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Edit Course Details"),
        ),
        body: ListView(
          children: getFormWidget(),
        ));
  }

  List<Widget> getFormWidget() {
    List<Widget> formWidget = [];

    formWidget.add(TextFormField(
      decoration:
          const InputDecoration(labelText: 'Course ID', hintText: 'SCS 2023'),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a valid ID';
        } else {
          return null;
        }
      },
      onSaved: (value) {
        setState(() {
          _courseID = value.toString();
        });
      },
    ));

    formWidget.add(TextFormField(
      decoration: const InputDecoration(
          labelText: 'Course Name', hintText: 'Data Structures and Algorithms'),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a valid Name';
        } else {
          return null;
        }
      },
      onSaved: (value) {
        setState(() {
          _courseName = value.toString();
        });
      },
    ));

    formWidget.add(TextFormField(
      decoration: const InputDecoration(
          labelText: 'Lecturer', hintText: 'Asitha Perera'),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a Name';
        } else {
          return null;
        }
      },
      onSaved: (value) {
        setState(() {
          _lecturerName = value.toString();
        });
      },
    ));

    formWidget.add(TextFormField(
      decoration:
          const InputDecoration(labelText: 'Date', hintText: 'Monday 8.00 AM'),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a Date';
        } else {
          return null;
        }
      },
      onSaved: (value) {
        setState(() {
          _lecTime = '';
        });
      },
    ));

    formWidget.add(ElevatedButton(child: const Text('Save'), onPressed: () {}));

    return formWidget;
  }
}
