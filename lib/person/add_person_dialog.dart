import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:gift_planner/l10n/gift_planner_localizations.dart';
import 'package:gift_planner/person/contact_chooser.dart';
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
  }

  void chooseContact(BuildContext context) async {
    if (await Permission.contacts.request().isGranted) {
      Contact c = await Navigator.push(
          context, MaterialPageRoute(builder: (_) => ContactChooser()));
      if (c == null) {
        return;
      }
      setState(() {
        if (c.displayName != null) {
          _nameController.text = c.displayName;
        }
        if (c.birthday != null) {
          _selectedDate = c.birthday;
          dateString = "";
        }
      });
    } else if (await Permission.contacts.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: EdgeInsets.all(5),
      title: Container(
        child: Text(GiftPlannerLocalizations.of(context).personsAddPersonTitle),
      ),
      children: [
        Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: GiftPlannerLocalizations.of(context).personsAddNameField),
                validator: (value) {
                  if (value.isEmpty) {
                    return GiftPlannerLocalizations.of(context).addGiftNameError;
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    GiftPlannerLocalizations.of(context).personCardBirthDate,
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  if (_selectedDate != null)
                    Text(
                      '${DateFormat.yMd().format(_selectedDate)}',
                    ),
                  //if (dateString.isNotEmpty) Text(dateString)
                ],
              ),
              if (dateString.isNotEmpty)
                Text(
                  dateString,
                  style: TextStyle(color: Theme.of(context).errorColor),
                ),
              FlatButton(
                textColor: Theme.of(context).primaryColor,
                child: Text(
                  GiftPlannerLocalizations.of(context).buttonChooseDate,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onPressed: _presentDatePicker,
              ),
              Text(GiftPlannerLocalizations.of(context).or),
              FlatButton(
                textColor: Theme.of(context).primaryColor,
                child: Text(
                  GiftPlannerLocalizations.of(context).buttonChooseContact,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onPressed: () => chooseContact(context),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    textColor: Theme.of(context).errorColor,
                    child: Text(GiftPlannerLocalizations.of(context).buttonCancel),
                  ),
                  FlatButton(
                    onPressed: () {
                      if (_formKey.currentState.validate() &&
                          _selectedDate != null) {
                        Navigator.of(context).pop(Person(
                            name: _nameController.text, birth: _selectedDate));
                      } else {
                        setState(() {
                          dateString = GiftPlannerLocalizations.of(context).personsAddPersonErrorMessageDate;
                        });
                      }
                    },
                    textColor: Theme.of(context).primaryColor,
                    child: Text(GiftPlannerLocalizations.of(context).buttonSave),
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
