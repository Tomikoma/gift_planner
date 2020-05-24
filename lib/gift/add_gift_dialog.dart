import 'package:flutter/material.dart';

import 'gift.dart';

class AddGiftDialog extends StatefulWidget {
  @override
  _AddGiftDialogState createState() => _AddGiftDialogState();
}

class _AddGiftDialogState extends State<AddGiftDialog> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _priceController = TextEditingController();

  bool isNumeric(String s) {
 if (s == null) {
   return false;
 }
 return double.tryParse(s) != null;
}

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text("UPDATE TIHS"),
      children: [
        Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: "NAME"),
                controller: _nameController,
                validator: (value){
                  if (value.isEmpty){
                    return "NEED TO FILL";
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "PRICE"),
                controller: _priceController,
                keyboardType: TextInputType.number,
                validator: (value){
                  if (value.isEmpty){
                    return "NEED TO FILL";
                  } else if (!isNumeric(value)) {
                    return "NUMBER NEEDED";
                  }
                  return null;
                },
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
                      if (_formKey.currentState.validate()) {
                        Navigator.of(context).pop(Gift(name: _nameController.text, price: int.parse(_priceController.text)));
                      }
                    },
                    textColor: Theme.of(context).primaryColor,
                    child: Text("SAVE"),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
