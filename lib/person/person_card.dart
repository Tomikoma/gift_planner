import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gift_planner/l10n/gift_planner_localizations.dart';
import 'package:gift_planner/providers/data_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'person.dart';
import 'person_widget.dart';
import 'picture/person_icon.dart';

class PersonCard extends StatefulWidget {
  final int personId;

  PersonCard({this.personId});

  @override
  _PersonCardState createState() => _PersonCardState();
}

class _PersonCardState extends State<PersonCard> {
  _removePerson(BuildContext context) async {
    await Person.removePerson(widget.personId);
    setState(() {
      Provider.of<DataModel>(context, listen: false)
          .removePerson(widget.personId);
    });
    final path = join(
      (await getApplicationDocumentsDirectory()).path,
      'person${widget.personId}.png',
    );
    final file = File(path);
    if (file.existsSync()) {
      file.deleteSync();
    }
  }

  @override
  Widget build(BuildContext context) {
    Person person = Provider.of<DataModel>(context).person(widget.personId);
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 20,
          backgroundColor: Colors.grey[350],
          child: PersonIcon(
            personId: widget.personId,
          ),
        ),
        title: Text(
          person.name,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(GiftPlannerLocalizations.of(context).personCardGiftNum +
            person.gifts.length.toString()),
        // onTap: () => Navigator.of(context).push(MaterialPageRoute(
        //     builder: (context) => PersonWidget(personId: person.id,))),
        onTap: () => Navigator.of(context).push(PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                PersonWidget(
                  personId: person.id,
                ),
            transitionsBuilder: (
              context,
              animation,
              secondaryAnimation,
              child,
            ) =>
                SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(1, 0),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                ))),
        trailing: IconButton(
          icon: Icon(Icons.remove_circle),
          onPressed: () => _removePerson(context),
          color: Colors.red,
        ),
      ),
    );
  }
}
