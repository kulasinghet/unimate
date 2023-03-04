import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:unimate/student/student_drawer.dart';

class addNewEvent extends StatefulWidget{
  const addNewEvent({super.key});

  @override
  State<StatefulWidget> createState() => _addNewEventState();
}

class _addNewEventState extends State<addNewEvent>{
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late String _title;
  late String _description;
  late String _venue;
  late String _date;
  late int _time;

  Widget _buildEventTitleField() {
    return TextFormField(
      validator: (text) {
        return HelperValidator.nameValidate(text!);
      },
      maxLength: 30,
      maxLines: 1,
      decoration:
      InputDecoration(
          labelText: 'Title',
          hintText: 'Enter the event Title',
          border: OutlineInputBorder(),
      ),
      onSaved: (value) {
        _title = value!;
      },
    );
  }

  Widget _buildEventDescriptionField() {
    return TextFormField(
      maxLength: 50,
      maxLines: 4,
      validator: (text) {
        return HelperValidator.descriptionValidate(text!);
      },
      decoration:
      const InputDecoration(
          labelText: 'Description',
          hintText: 'Enter Event Description',
          border: OutlineInputBorder(),
      ),
      onSaved: (value) {
        _description = value!;
      },
    );
  }

  Widget _buildEventVenueField() {
    return TextFormField(
      maxLength: 30,
      maxLines: 2,
      validator: (text) {
        if(text == null)
          {
            return "Event Venue can't be empty.";
          }
        return null;
      },
      decoration:
      const InputDecoration(
        labelText: 'Venue',
        hintText: 'Enter Event Venue',
        border: OutlineInputBorder(),
      ),
      onSaved: (value) {
        _description = value!;
      },
    );
  }

  Widget _buildEventDateField() {
    return DateTimeFormField(
        decoration: const InputDecoration(
          hintStyle: TextStyle(color: Colors.black45),
          errorStyle: TextStyle(color: Colors.redAccent),
          border: OutlineInputBorder(),
          suffixIcon: Icon(Icons.event_note),
          labelText: 'Date',
        ),
        mode: DateTimeFieldPickerMode.date,
        autovalidateMode: AutovalidateMode.always,
        validator: (date)
        {
          if(date == null)
          {
            return "Date can't be empty";
          }
          return null;
          // (e?.day ?? 0) == 1 ? 'Please not the first day' : null
        },
        onSaved: (value){
          _date = value! as String;
        },
        onDateSelected: (DateTime value) {
          print(value);
        },
    );
  }

  Widget _buildEventTimeField() {
    return DateTimeFormField(
      decoration: const InputDecoration(
        hintStyle: TextStyle(color: Colors.black45),
        errorStyle: TextStyle(color: Colors.redAccent),
        border: OutlineInputBorder(),
        suffixIcon: Icon(Icons.event_note),
        labelText: 'Time',
      ),
      mode: DateTimeFieldPickerMode.time,
      autovalidateMode: AutovalidateMode.always,
      validator: (text){
        if(text == null)
          {
            return "Time can't be empty";
          }
      },
      onSaved: (value){
        _date = value! as String;
      },
      onDateSelected: (DateTime value) {
        print(value);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create an Event'),
      ),
      drawer: const StudentDrawer(),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _buildEventTitleField(),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _buildEventDescriptionField(),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _buildEventVenueField(),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _buildEventDateField(),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _buildEventTimeField(),
                ),
                SizedBox(height: 30),
                Container(
                  width: 150,
                  child: ElevatedButton(
                    child: const Text(
                      'Create',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        print('valid form');
                        _formKey.currentState!.save();
                      } else {
                        print('not valid form');

                        return;
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HelperValidator {
  static String? nameValidate(String value) {
    RegExp exp1 = RegExp(r'\d|\W');
    if (value.isEmpty) {
      return "Name can't be empty";
    }
    if (value.length < 2) {
      return "Name must be at least 2 characters long";
    }
    if (value.length > 30) {
      return "Name must be less than 50 characters long";
    }
    if(exp1.hasMatch(value[0])){
      return "Name must be starts with a letter";
    }
    return null;
  }
  static String? descriptionValidate(String value) {
    if (value.isEmpty) {
      return "Description can't be empty";
    }
    if (value.length < 5) {
      return "Name must be at least 5 characters long";
    }
    if (value.length > 50) {
      return "Description must be less than 50 characters long";
    }
    return null;
  }
}


// @override
// Widget build(BuildContext context) {
//   final List<String> _items = [
//     'Item 1',
//     'Item 2',
//     'Item 3',
//     'Item 4',
//     'Item 5',
//     'Item 1',
//     'Item 2',
//     'Item 3',
//     'Item 4',
//     'Item 5'
//   ];
//
//   return SafeArea(
//     child: Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Create an Event', style: TextStyle(fontSize: 20.0),),
//       ),
//       drawer: const StudentDrawer(),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child:Text("form"),
//       ),
//     ),
//   );
// }