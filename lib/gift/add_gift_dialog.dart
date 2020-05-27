import 'package:flutter/material.dart';
import 'package:gift_planner/l10n/gift_planner_localizations.dart';

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
      title: Text(GiftPlannerLocalizations.of(context).addGiftTitle),
      children: [
        Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: GiftPlannerLocalizations.of(context).addGiftName),
                controller: _nameController,
                validator: (value){
                  if (value.isEmpty){
                    return GiftPlannerLocalizations.of(context).addGiftNameError;
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: GiftPlannerLocalizations.of(context).addGiftPrice),
                controller: _priceController,
                keyboardType: TextInputType.number,
                validator: (value){
                  if (value.isEmpty){
                    return GiftPlannerLocalizations.of(context).addGiftPriceError;
                  } else if (!isNumeric(value)) {
                    return GiftPlannerLocalizations.of(context).addGiftPriceWrongFormatError;
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
                    child: Text(GiftPlannerLocalizations.of(context).buttonCancel),
                  ),
                  FlatButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        Navigator.of(context).pop(Gift(name: _nameController.text, price: int.parse(_priceController.text)));
                      }
                    },
                    textColor: Theme.of(context).primaryColor,
                    child: Text(GiftPlannerLocalizations.of(context).buttonSave),
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
