import 'package:flutter/material.dart';

class LectureCourse extends StatefulWidget {
  const LectureCourse({Key? key}) : super(key: key);

  @override
  State<LectureCourse> createState() => _LectureCourseState();
}

class _LectureCourseState extends State<LectureCourse> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Course Details"),
        ),
        body: Center(
          child: SizedBox(
            height: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'SCS 1220 Data Structures and Algorithms',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Text("Saman Kumara"),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      color: Colors.amber,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: SizedBox(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.4,
                        height: 40,
                        child: const Center(
                          child: Text(
                            'Monday 8.00 AM',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    child: ElevatedButton(
                        onPressed: () {}, child: const Text("Mark Attendance")),
                  ),
                  SizedBox(
                    width: 150,
                    child: ElevatedButton(
                        onPressed: () {}, child: const Text("Assignments")),
                  ),

                  const SizedBox(height: 30,),

                  const Text(
                    'Announcements',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                        child: Card(
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: Theme
                                  .of(context)
                                  .colorScheme
                                  .background,
                            ),
                            borderRadius: const BorderRadius.all(Radius
                                .circular(12)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: const [
                                Text(
                                  '2022-04-01 08:00 AM',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                Text(
                                  "s simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                        child: Card(
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: Theme
                                  .of(context)
                                  .colorScheme
                                  .background,
                            ),
                            borderRadius: const BorderRadius.all(Radius
                                .circular(12)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: const [
                                Text(
                                  '2022-04-01 08:00 AM',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                Text(
                                  "s simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        )
    );
  }
}