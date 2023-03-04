import 'package:flutter/material.dart';
import 'package:unimate/student_drawer.dart';

class AllCoursePage extends StatefulWidget {
  const AllCoursePage({Key? key}) : super(key: key);

  @override
  State<AllCoursePage> createState() => _AllCoursePageState();
}

class _AllCoursePageState extends State<AllCoursePage> {
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
          title: Text("All Courses"),
        ),
        drawer: const StudentDrawer(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
              itemCount: 10,
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
                          'SCS2012 Data Structures and Algorithms',
                          style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          'Saman Kumara',
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
                                onPressed: () {},
                                child: Text('Enter'),
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
      ),
    );
  }
}
