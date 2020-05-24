import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:gift_planner/person/ContactChooser.dart';
import 'package:gift_planner/person/person.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

class AddPersonDialog extends StatefulWidget {
  AddPersonDialog({Key key}) : super(key: key);

  @override
  _AddPersonDialogState createState() => _AddPersonDialogState();
}

class _AddPersonDialogState extends State<AddPersonDialog> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  DateTime _selectedDate;
  String dateString = "";

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
        dateString = "";
      });
    });
    print('...');
  }
  
  void chooseTelNumber(BuildContext context) async {
    if(await Permission.contacts.request().isGranted){
      Contact c = await Navigator.push(context,
        MaterialPageRoute(builder: (_) => ContactChooser())
      );
    } else if (await Permission.contacts.isPermanentlyDenied) {
      openAppSettings();
    } 
  }
  

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Container(
        child: Text("NEED TO UPDATE THIS"),
      ),
      children: [
        Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: "Név"),
                validator: (value){
                  if (value.isEmpty){
                    return "NEED TO FILL";
                  }
                  return null;
                },
              ),
              Row(
                children: [
                  Text("DATE"),
                  Text(
                    _selectedDate == null
                        ? ' No Date Chosen!'
                        : 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}',
                  ),
                  if (dateString.isNotEmpty) Text(dateString)
                ],
              ),
              FlatButton(
                textColor: Theme.of(context).primaryColor,
                child: Text(
                  'Choose Date',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onPressed: _presentDatePicker,
              ),
              FlatButton(
                textColor: Theme.of(context).primaryColor,
                child: Text(
                  'Choose tel',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onPressed: () => chooseTelNumber(context),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    textColor: Theme.of(context).errorColor,
                    child: Text("CANCEL"),
                  ),
                  FlatButton(
                    onPressed: () {
                      if (_formKey.currentState.validate() && _selectedDate != null) {
                        Navigator.of(context).pop(Person(name: _nameController.text, birth: _selectedDate));
                      } else {
                        setState(() {
                          dateString = "DATE IS REQUIRED !!!";
                        });
                      }
                    },
                    textColor: Theme.of(context).primaryColor,
                    child: Text("SAVE"),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
