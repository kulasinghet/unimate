import 'package:flutter/material.dart';
import 'package:unimate/student/student_drawer.dart';

import 'course.dart';

class StudentAssignment extends StatefulWidget {
  const StudentAssignment({Key? key}) : super(key: key);

  @override
  State<StudentAssignment> createState() => _StudentAssignmentState();
}

class _StudentAssignmentState extends State<StudentAssignment> {
  @override
  Widget build(BuildContext context) {
    String _selectedOption = 'Option 1';

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("All Assignments"),
        ),
        drawer: const StudentDrawer(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 6, right: 6),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 12.0,
                      right: 12.0,
                    ),
                    child: DropdownButton<String>(
                      dropdownColor: Colors.amber,
                      isExpanded: true,
                      value: 'All Assignments',
                      icon: const Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                      underline: Container(
                        height: 2,
                        color: Colors.amber,
                      ),
                      onChanged: (String? newValue) {},
                      items: <String>[
                        'All Assignments',
                        'Data Structures and Algorithms',
                        'Database 2'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Theme.of(context).colorScheme.background,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'SCS2012 - Assignment Title',
                                  style: TextStyle(
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Checkbox(
                                  value: true,
                                  visualDensity: VisualDensity.comfortable,
                                  onChanged: (bool? changed) {},
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 4.0,
                            ),
                            const Text(
                              'This is a small description of what the assignment is about !',
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                            const SizedBox(
                              height: 12.0,
                            ),
                            const Text(
                              'Deadline: 2023-05-12',
                              style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.green),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
