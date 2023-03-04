import 'package:flutter/material.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event List',style: TextStyle(fontSize: 20.0),),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (BuildContext context,int index){
          return Column(
            children: [
              ListTile(
                leading: Image.network("https://madhack.ucscieee.com/assets/img/sculptures/david_t-shirt-min.png"),
                title:Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Text(date[index]),
                    const Expanded(
                        child: Text(
                          "Jan 12",style: TextStyle(color: Colors.blue),
                          maxLines: 2,
                        )
                    ),
                    Expanded(
                      child: Text(
                        "MadHack IEEEucsc czdsadsdfsdf sdsdfsdfsd ${items[index]}",
                        maxLines: 2,
                      ),
                    )
                  ],
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
                onTap:() {
                  print("clicked");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => studentEvent(eventId)),
                  );
                }
                ,
              ),
              const Divider(),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("Add new");
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => addNewEvent(),
            ),
          );

        },
        tooltip: "New Event",
        backgroundColor: Colors.amber,
        child: const Icon(Icons.add),
      ),
    );
  }

}
