import 'package:flutter/material.dart';
import 'package:unimate/lecturer/course.dart';

class CourseListPage extends StatefulWidget {
  const CourseListPage({Key? key}) : super(key: key);

  @override
  State<CourseListPage> createState() => _CourseListPageState();
}

class _CourseListPageState extends State<CourseListPage> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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
                leading: Container(
                    padding: const EdgeInsets.only(right: 12.0),
                    height: double.infinity,
                    decoration: const BoxDecoration(
                        border: Border(
                            right:
                                BorderSide(width: 1.0, color: Colors.black26))),
                    child: const Text(
                      "SCS2012",
                      style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, .64),
                          fontWeight: FontWeight.bold),
                    )),
                title: const Text(
                  "SCS2012 Data Structures and Algorithms",
                  style: TextStyle(
                      color: Color.fromRGBO(0, 0, 0, .72),
                      fontWeight: FontWeight.bold),
                ),
                // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                subtitle: Row(
                  children: const <Widget>[
                    Text(" Saman Kumara",
                        style: TextStyle(color: Color.fromRGBO(0, 0, 0, .52)))
                  ],
                ),
                trailing: const Icon(Icons.keyboard_arrow_right,
                    color: Color.fromRGBO(0, 0, 0, .32), size: 30.0),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                  return const LectureCourse();
                }));
              },
            ),
          );
        });
  }
}
