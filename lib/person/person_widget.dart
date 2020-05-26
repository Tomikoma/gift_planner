import 'package:flutter/material.dart';
import 'package:gift_planner/gift/add_gift_dialog.dart';
import 'package:gift_planner/gift/gift.dart';
import 'package:gift_planner/l10n/gift_planner_localizations.dart';
import 'package:gift_planner/person/person.dart';
import 'package:gift_planner/person/picture/person_picture.dart';
import 'package:gift_planner/providers/data_model.dart';
import 'package:provider/provider.dart';

class PersonWidget extends StatefulWidget {
  final int personId;
  PersonWidget({this.personId});

  @override
  _PersonWidgetState createState() => _PersonWidgetState();
}

class _PersonWidgetState extends State<PersonWidget> {
  Future<void> _addGift(BuildContext context) async {
    var gift = await showDialog<Gift>(
        context: context, builder: (BuildContext context) => AddGiftDialog());
    if (gift != null) {
      gift.personId = widget.personId;
      gift.id = await Gift.insertGift(gift);
      setState(() {
        Provider.of<DataModel>(context, listen: false)
            .addGift(gift);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    //loadGifts();
  }

  removeGift(BuildContext context, int giftId) async {
    await Gift.removeGift(giftId);
    setState(() {
      Provider.of<DataModel>(context, listen: false)
          .removeGift(giftId, widget.personId);
    });
  }

  @override
  Widget build(BuildContext context) {
    Person person = Provider.of<DataModel>(context).person(widget.personId);
    return Scaffold(
      appBar: AppBar(
        title: Text(person.name),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _addGift(context),
          )
        ],
      ),
      body: Column(children: [
        Card(
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: PersonPicture(
                  personId: person.id,
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start ,
                    children: [
                      Text(GiftPlannerLocalizations.of(context).personWidgetName + person.name),
                      SizedBox(height: 5),
                      Text(GiftPlannerLocalizations.of(context).personCardBirthDate + person.birth.toString().split(" ")[0]),
                      SizedBox(height: 5),
                      Text(GiftPlannerLocalizations.of(context).personCardGiftNum + person.gifts.length.toString())
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
              itemCount: person.gifts.length,
              itemBuilder: (context, index) {
                var gift = person.gifts[index];
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage('images/gift.png'),
                      radius: 25,
                    ),
                    title: Text(GiftPlannerLocalizations.of(context).personWidgetGiftName + gift.name),
                    subtitle: Text(GiftPlannerLocalizations.of(context).personWidgetGiftPrice + gift.price.toString() + " Ft"),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      color: Colors.red,
                      onPressed: () => removeGift(context, gift.id),
                    ),
                  ),
                );
              }),
        )
      ]),
    );
  }
}
