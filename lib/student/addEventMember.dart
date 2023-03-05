import 'package:flutter/material.dart';

class AddEventMember extends StatefulWidget {
  @override
  _AddEventMemberState createState() => _AddEventMemberState();
}

class _AddEventMemberState extends State<AddEventMember> {
  List<String> members = [
    'Member 1',
    'Member 2',
    'Member 3',
    'Member 4',
    'Member 5',
    'Member 6',
    'Member 7',
    'Member 8',
    'Member 9',
    'Member 10'
  ];
  List<String> filteredMembers = [];

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredMembers = members;
  }

  void filterMembers(String query) {
    List<String> filteredList = [];
    if (query.isNotEmpty) {
      members.forEach((member) {
        if (member.toLowerCase().contains(query.toLowerCase())) {
          filteredList.add(member);
        }
      });
      setState(() {
        filteredMembers = filteredList;
      });
    } else {
      setState(() {
        filteredMembers = members;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: searchController,
          decoration: InputDecoration(
            hintText: 'Search members...',
          ),
          onChanged: (query) {
            filterMembers(query);
          },
        ),
      ),
      body: ListView.builder(
        itemCount: filteredMembers.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Container(
              margin:const EdgeInsets.only(left:5,right:5,top:5.0),
              padding: const EdgeInsets.only(left:10,right:10,top:15.0,bottom: 15.0),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.circular(10),
              ),
              child:ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(filteredMembers[index]),
                        ElevatedButton(
                          onPressed: (){
                            //add member for the event
                          },
                          child: Text("Add"),
                        )
                      ],
                    ),
                  ),

            ),
          );
        },
      ),
    );
  }
}