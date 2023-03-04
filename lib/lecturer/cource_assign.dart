import 'package:flutter/material.dart';

class AssignedStudentsList extends StatefulWidget {
  const AssignedStudentsList({Key? key}) : super(key: key);

  @override
  State<AssignedStudentsList> createState() => _AssignedStudentsListState();
}

class _AssignedStudentsListState extends State<AssignedStudentsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Assigned Students"),
      ),
      body: ListView.builder(
          shrinkWrap: true,
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              color: const Color.fromRGBO(241, 214, 147, .8),
              elevation: 1,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                title: const Text(
                  "Student ID",
                  style: TextStyle(
                      color: Color.fromRGBO(0, 0, 0, .72),
                      fontWeight: FontWeight.bold),
                ),
                // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                subtitle: Row(
                  children: const <Widget>[
                    Text("Student Name",
                        style: TextStyle(color: Color.fromRGBO(0, 0, 0, .52)))
                  ],
                ),
                trailing: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.delete),
                  tooltip: "Delete",
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _displayTextInputDialog(context);
          print(_textFieldController.text);
        },
        tooltip: 'Add student',
        child: const Icon(Icons.add),
      ),
    );
  }

  final TextEditingController _textFieldController = TextEditingController();

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Student'),
          content: TextField(
            controller: _textFieldController,
            decoration: const InputDecoration(hintText: "Please enter the student ID"),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
