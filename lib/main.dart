import 'package:flutter/material.dart';
import 'package:unimate/student_drawer.dart';
import 'addNewEvent.dart';
import 'studentEvent.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    var items = List<String>.generate(20, (index) => 'Item ${index+1}');
    var dates = List<String>.generate(20, (index) => 'Item ${index+1}');

    return MaterialApp(
      title: 'Event List',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      debugShowCheckedModeBanner: false,
      home: EventListBuilder(items,dates),
    );
  }
}

class EventListBuilder extends StatelessWidget{
  var items;
  var date;
  var eventId = '0';
  EventListBuilder(this.items,this.date);

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
          title: Text("All Events"),
        ),
        drawer: const StudentDrawer(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
              itemCount: items.length,
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
                          'MADhack 2.0 Delegates',
                          style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          'Jan 12',
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
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => studentEvent(eventId,'MADhack 2.0 Delegates')),
                                  );
                                },
                                child: const Text('Enter'),
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => addNewEvent(),
              ),
            );

          },
          tooltip: "Create an Event",
          backgroundColor: Colors.amber,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

}
