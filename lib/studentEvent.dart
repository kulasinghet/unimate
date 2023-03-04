import 'package:flutter/material.dart';
import 'package:unimate/student_drawer.dart';

class studentEvent extends StatefulWidget{

  String eventId;
  String title;
  studentEvent(this.eventId,this.title,{super.key});

  @override
  State<StatefulWidget> createState() => _studentEventState(eventId,title);
}

class _studentEventState extends State<studentEvent>{
  String eventId;
  String title;
  _studentEventState(this.eventId,this.title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title,style: TextStyle(fontSize: 20.0),),
      ),
        drawer: const StudentDrawer(),
      body: SingleChildScrollView(
        child: Column(
            children: [
              Container(
                height:220,
                margin:EdgeInsets.only(left:5,right:5,top:5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 1.0,
                    ),
                  ],
                  color: Theme.of(context).colorScheme.background,
                  image: const DecorationImage(
                    fit:BoxFit.cover,
                    image:NetworkImage(
                      "https://img.freepik.com/free-vector/events-concept-illustration_114360-931.jpg"
                    )
                  )
                ),
              ),
              Container(
                  margin:const EdgeInsets.only(top:15.0),
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("UCSC PREMISES", style:TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      )),
                      Text("2023 - 03 - 27", style:TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      )),
                      Text("8.00 AM", style:TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      )),
                    ],
                  ),
              ),
              const SizedBox(height: 15.0),
              Divider(height: 5.0,thickness: 2.0),
              Container(
                  margin:const EdgeInsets.only(left:5,right:5,top:15.0),
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text("Description",style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                      ),),
                      SizedBox(height: 10.0),
                      Text(
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                            style: TextStyle(
                              fontSize: 16.0,
                              wordSpacing: 4.0,
                              letterSpacing: 1.0,
                            ),
                      ),
                    ],
                  )
              ),
              const SizedBox(height: 10.0),
              const Divider(height: 5.0,thickness: 2.0),
              Container(
                  margin:EdgeInsets.only(left:5,right:5,top:15.0),
                child:Column(
                  children: const [
                    Text("Announcments", style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),)
                  ],
                )
              )
            ],
          )
      ),
    );
  }

}