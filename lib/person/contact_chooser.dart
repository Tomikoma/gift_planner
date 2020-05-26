import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:gift_planner/l10n/gift_planner_localizations.dart';

class ContactChooser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(GiftPlannerLocalizations.of(context).contactChooserTitle),
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(10),
        child: FutureBuilder<Iterable<Contact>>(
            future: ContactsService.getContacts(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return ListView(
                  children: snapshot.data.map((contact) {
                    return ListTile(
                      title: Text( GiftPlannerLocalizations.of(context).personCardName +( contact.displayName != null ? contact.displayName: GiftPlannerLocalizations.of(context).contactChooserNotFilled)),
                      subtitle: Text( GiftPlannerLocalizations.of(context).personCardBirthDate +( contact.birthday != null ? contact.birthday.toString().split(" ")[0]: GiftPlannerLocalizations.of(context).contactChooserNotFilled)),
                      onTap: () {
                        Navigator.pop(context, contact);
                      },
                    );
                  }).toList(),
                );
              }
              return Center(child: CircularProgressIndicator());
            }),
      ),
    );
  }
}
