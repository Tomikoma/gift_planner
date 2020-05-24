import 'package:flutter/material.dart';
import 'package:gift_planner/gift/add_gift_dialog.dart';
import 'package:gift_planner/gift/gift.dart';
import 'package:gift_planner/person/person.dart';
import 'package:gift_planner/person/picture/person_picture.dart';

class PersonWidget extends StatefulWidget {
  final Person person;
  PersonWidget({this.person});

  @override
  _PersonWidgetState createState() => _PersonWidgetState();
}

class _PersonWidgetState extends State<PersonWidget> {

  Future<void> _addGift(BuildContext context) async {
    var gift = await showDialog<Gift>(
        context: context,
        builder: (BuildContext contexxt) => AddGiftDialog());
    if (gift != null) {
      gift.personId = widget.person.id;
      print(gift.name + ", " + gift.price.toString() + ", " + gift.personId.toString());
      gift.id = await Gift.insertGift(gift);
      setState(() {
        //provider?
        widget.person.gifts.add(gift);
        print(widget.person.gifts);
      });
    } else {
      print("NULL GIFT");
    }
  }

  @override
  void initState() {
    super.initState();
    loadGifts();
  }

  Future<void> loadGifts() async {
    var giftsLoaded = await Gift.gifts(widget.person.id);
    setState(() {
      widget.person.gifts = giftsLoaded;
    });
  }

  removeGift(giftId) async {
    await Gift.removeGift(giftId);
    setState(() {
      widget.person.gifts.removeWhere((element) => element.id == giftId);
    }); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.person.name),
        actions: [
        IconButton(icon: Icon(Icons.add) ,onPressed: () => _addGift(context),)
      ],),
      body: Column(children: [
        Card(
          child: Row(
            children: [
              PersonPicture(personId: widget.person.id,),
              Text(widget.person.name),
              Text(widget.person.birth.toString())
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
              itemCount: widget.person.gifts.length,
              itemBuilder: (context, index) {
                var gift = widget.person.gifts[index];
                return Card(
                  child: ListTile(
                    // children: [
                    //   Text(widget.person.gifts[index].name + ": "),
                    //   Text(widget.person.gifts[index].price.toString()),
                    // ],
                    leading: CircleAvatar(
                      radius: 20,
                    ),
                    title: Text(gift.name),
                    subtitle: Text(gift.price.toString() + " Ft"),
                    trailing: IconButton(icon: Icon(Icons.delete), color: Colors.red, onPressed: () => removeGift(gift.id),),
                  ),
                );
              }),
        )
      ]),
    );
  }
}
