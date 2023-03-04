import 'package:flutter/material.dart';
import 'package:unimate/lecturer/assignment_edit.dart';

class AssignmentListPage extends StatefulWidget {
  const AssignmentListPage({Key? key}) : super(key: key);

  @override
  State<AssignmentListPage> createState() => _AssignmentListPageState();
}

class _AssignmentListPageState extends State<AssignmentListPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 12, 8, 0),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                  right: 8.0,
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
                  shrinkWrap: true,
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      color: const Color.fromRGBO(241, 214, 147, .8),
                      elevation: 1,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 6.0),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        title: const Text(
                          "SCS2012 - Assignment Title",
                          style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, .72),
                              fontWeight: FontWeight.bold),
                        ),
                        // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                        subtitle: Container(
                          padding: const EdgeInsets.only(top: 10),
                          child: Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const <Widget>[
                                Text("This is a small description of what the assignment is about !",
                                    style: TextStyle(
                                        color: Color.fromRGBO(0, 0, 0, .52))),
                                Text("Deadline: 2023-05-12",
                                    style: TextStyle(
                                        color: Colors.green),
                                )
                              ],
                            ),
                          ),
                        ),

                        trailing: const Icon(Icons.keyboard_arrow_right,
                            color: Color.fromRGBO(0, 0, 0, .32), size: 30.0),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                            return const EditAssignment();
                          }));
                        },
                      ),
                    );
                  }))
        ],
      ),
    );
  }
}

// class _AssignmentListPageState extends State<AssignmentListPage> {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.fromLTRB(8, 12, 8, 0),
//             child: Container(
//               decoration: const BoxDecoration(
//                 color: Colors.amber,
//                 borderRadius: BorderRadius.all(Radius.circular(12)),
//               ),
//               width: double.infinity,
//               child: Padding(
//                 padding: const EdgeInsets.only(
//                   left: 8.0,
//                   right: 8.0,
//                 ),
//                 child: DropdownButton<String>(
//                   dropdownColor: Colors.amber,
//                   isExpanded: true,
//                   value: 'All Assignments',
//                   icon: const Icon(Icons.arrow_drop_down),
//                   iconSize: 24,
//                   elevation: 16,
//                   style: const TextStyle(
//                       color: Colors.black,
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold),
//                   underline: Container(
//                     height: 2,
//                     color: Colors.amber,
//                   ),
//                   onChanged: (String? newValue) {},
//                   items: <String>[
//                     'All Assignments',
//                     'Data Structures and Algorithms',
//                     'Database 2'
//                   ].map<DropdownMenuItem<String>>((String value) {
//                     return DropdownMenuItem<String>(
//                       value: value,
//                       child: Text(value),
//                     );
//                   }).toList(),
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(height: 8),
//           Expanded(
//             child: ListView.builder(
//               itemCount: 10,
//               itemBuilder: (BuildContext context, int index) {
//                 return Card(
//                   elevation: 1,
//                   shape: RoundedRectangleBorder(
//                     side: BorderSide(
//                       color: Theme.of(context).colorScheme.background,
//                     ),
//                     borderRadius: const BorderRadius.all(Radius.circular(12)),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             const Text(
//                               'SCS2012 - Assignment Title',
//                               style: TextStyle(
//                                 fontSize: 22.0,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             Checkbox(
//                               value: true,
//                               visualDensity: VisualDensity.comfortable,
//                               onChanged: (bool? changed) {},
//                             )
//                           ],
//                         ),
//                         const SizedBox(
//                           height: 4.0,
//                         ),
//                         const Text(
//                           'This is a small description of what the assignment is about !',
//                           style: TextStyle(
//                             fontSize: 16.0,
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 12.0,
//                         ),
//                         const Text(
//                           'Deadline: 2023-05-12',
//                           style: TextStyle(
//                               fontSize: 14.0,
//                               fontWeight: FontWeight.bold,
//                               fontStyle: FontStyle.italic,
//                               color: Colors.green),
//                         )
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
