import 'dart:collection';

import 'package:flutter/widgets.dart';
import 'package:gift_planner/person/person.dart';

class DataModel with ChangeNotifier {
  List<Person> _persons = [];

  UnmodifiableListView get persons => UnmodifiableListView(_persons);

  
}