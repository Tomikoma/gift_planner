import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:gift_planner/db/sql.dart';
import 'package:gift_planner/l10n/gift_planner_localizations.dart';
import 'package:gift_planner/person/add_person_dialog.dart';
import 'package:gift_planner/person/person.dart';
import 'package:gift_planner/person/person_card.dart';
import 'package:gift_planner/person/person_widget.dart';
import 'package:gift_planner/person/picture/person_icon.dart';
import 'package:gift_planner/person/picture/person_picture.dart';
import 'package:gift_planner/providers/data_model.dart';
import 'package:gift_planner/statistics/statistics_widget.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final firstCamera = cameras.first;
  DataModel model = DataModel();
  await model.initPersonsWithGifts();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => model),
      Provider.value(value: firstCamera)
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        initialRoute: '/',
        routes: {
          '/': (_) => Home(),
          '/person': (_) => PersonWidget(),
          '/stat': (_) => StatisticsWidget()
        },
        localizationsDelegates: [
          GiftPlannerLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        supportedLocales: [const Locale('en', ''), const Locale('hu', '')],
        theme: ThemeData(
          primarySwatch: Colors.blue,
          //visualDensity: VisualDensity.adaptivePlatformDensity,
        ));
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<void> _addPerson(BuildContext context) async {
    var person = await showDialog<Person>(
        context: context, builder: (BuildContext context) => AddPersonDialog());
    if (person != null) {
      person.id = await Person.insertPerson(person);
      setState(() {
        person.gifts = [];
        Provider.of<DataModel>(context, listen: false).addPerson(person);
      });
    }
  }

  void _showDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(GiftPlannerLocalizations.of(context).alertTitle),
            content: Text(GiftPlannerLocalizations.of(context).alertContent),
            actions: [
              new FlatButton(
                onPressed: () => Navigator.pop(context),
                child: Text(GiftPlannerLocalizations.of(context).buttonClose),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    PopupMenuButton popUpMenu = PopupMenuButton(
        itemBuilder: (context) => [
              PopupMenuItem(
                value: 1,
                child: Text(GiftPlannerLocalizations.of(context).statistics),
              )
            ],
        onSelected: (value) {
          switch (value) {
            case 1:
              if (Provider.of<DataModel>(context, listen: false)
                      .persons
                      .length >
                  0) {
                Navigator.pushNamed(context, '/stat');
              } else {
                _showDialog(context);
              }

              break;
          }
        });
    return Scaffold(
      appBar: AppBar(
        title: Text(GiftPlannerLocalizations.of(context).appTitle),
        actions: [popUpMenu],
      ),
      body: Consumer<DataModel>(
        builder: (context, dataModel, child) {
          return ListView(
            padding: EdgeInsets.all(8),
            children: [
              ...dataModel.persons.map((person) {
                print((person as Person).gifts);
                return PersonCard(
                  personId: person.id,
                );
              })
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        //onPressed: _incrementCounter,
        onPressed: () => _addPerson(context),
        tooltip: GiftPlannerLocalizations.of(context).personsAddButtonHint,
        child: Icon(Icons.person_add),
      ),
    );
  }
}
