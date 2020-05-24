import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:gift_planner/db/sql.dart';
import 'package:gift_planner/l10n/gift_planner_localizations.dart';
import 'package:gift_planner/person/add_person_dialog.dart';
import 'package:gift_planner/person/person.dart';
import 'package:gift_planner/person/person_widget.dart';
import 'package:gift_planner/person/picture/person_icon.dart';
import 'package:gift_planner/person/picture/person_picture.dart';
import 'package:gift_planner/statistics/statistics_widget.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final firstCamera = cameras.first;

  runApp(MyApp(firstCamera));
}

class MyApp extends StatelessWidget {
  static CameraDescription camera;

  MyApp(CameraDescription c) {
    camera = c;
  }

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
  List<Person> persons = [];

  Future<void> _addPerson(BuildContext context) async {
    var person = await showDialog<Person>(
        context: context,
        builder: (BuildContext contexxt) => AddPersonDialog());
    if (person != null) {
      print(person.name + ", " + person.birth.toIso8601String());
      final sql = SQL();
      final db = await sql.database;
      person.id = await db.insert('persons', person.toMap());
      setState(() {
        //provider?
        person.gifts = [];
        persons.add(person);
      });
    } else {
      print("NULL PERSON");
    }
  }

  removePerson(int personId) async {
    await Person.removePerson(personId);
    setState(() {
      persons.removeWhere((element) => element.id == personId);
    });
    final path = join(
      (await getApplicationDocumentsDirectory()).path,
      'person$personId.png',
    );
    final file = File(path);
    if (file.existsSync()) {
      file.deleteSync();
      print("DELETED");
    }
  }

  @override
  void initState() {
    super.initState();
    loadPersons();
  }

  Future<void> loadPersons() async {
    var personsLoaded = await Person.persons();
    setState(() {
      persons = personsLoaded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(GiftPlannerLocalizations.of(context).appTitle),
      ),
      body: Container(
          child: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: persons.length,
        itemBuilder: (context, index) {
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
                  personId: persons[index].id,
                ),
              ),
              title: Text(
                persons[index].name,
                style: Theme.of(context).textTheme.headline6,
              ),
              subtitle: Text(persons[index].birth.toString().split(" ")[0]),
              //onTap: () => Navigator.pushNamed(context, '/person', arguments: persons[index]),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => PersonWidget(person: persons[index]))),
              trailing: IconButton(
                icon: Icon(Icons.remove_circle),
                onPressed: () => removePerson(persons[index].id),
                color: Colors.red,
              ),
            ),
          );
        },
      )),
      floatingActionButton: FloatingActionButton(
        //onPressed: _incrementCounter,
        onPressed: () => _addPerson(context),
        tooltip: 'ADD PERSON',
        child: Icon(Icons.person_add),
      ),
    );
  }
}
