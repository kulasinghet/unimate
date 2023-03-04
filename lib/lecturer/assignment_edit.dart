import 'package:flutter/material.dart';

class EditAssignment extends StatefulWidget {
  const EditAssignment({Key? key}) : super(key: key);

  @override
  State<EditAssignment> createState() => _EditAssignmentState();
}

class _EditAssignmentState extends State<EditAssignment> {
  String _courseID = '';
  String _assignName = '';
  String _assignDesc = '';
  String _deadline = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Edit Assignment"),
          actions: <Widget>[
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.delete),
              tooltip: "Delete",
            )
          ],
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
          labelText: 'Assignment Title', hintText: 'Graphs'),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a valid Name';
        } else {
          return null;
        }
      },
      onSaved: (value) {
        setState(() {
          _assignName = value.toString();
        });
      },
    ));

    formWidget.add(TextFormField(
      decoration: const InputDecoration(
          labelText: 'Description'),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a Name';
        } else {
          return null;
        }
      },
      onSaved: (value) {
        setState(() {
          _assignDesc = value.toString();
        });
      },
    ));

    formWidget.add(TextFormField(
      decoration:
      const InputDecoration(labelText: 'Deadline', hintText: 'Monday 8.00 AM'),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a Date';
        } else {
          return null;
        }
      },
      onSaved: (value) {
        setState(() {
          _deadline = value.toString();
        });
      },
    ));

    formWidget.add(ElevatedButton(child: const Text('Save'), onPressed: () {}));

    return formWidget;
  }
}
