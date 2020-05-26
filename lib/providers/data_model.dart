import 'dart:collection';

import 'package:flutter/widgets.dart';
import 'package:gift_planner/gift/gift.dart';
import 'package:gift_planner/person/person.dart';

class DataModel with ChangeNotifier {
  List<Person> _persons = [];

  UnmodifiableListView get persons => UnmodifiableListView(_persons);

  Future<void> initPersonsWithGifts() async {
    _persons = await Person.persons();
    _persons.forEach((element) async {
      element.gifts = await Gift.gifts(element.id);
      print(element.gifts);
      notifyListeners();
    });
  }

  void addPerson(Person person){
    _persons.add(person);
    notifyListeners();
  }

  void removePerson(int personId){
    _persons.removeWhere((element) => element.id == personId);
    notifyListeners();
  }

  void removeGift(int giftId,int personId){
    _persons.where((element) => element.id == personId).first.gifts.removeWhere((element) => element.id == giftId);
    notifyListeners();
  }

  void addGift(Gift gift){
    _persons.where((element) => element.id == gift.personId).first.gifts.add(gift);
    notifyListeners();
  }

  Person person(int personId){
    return _persons.where((element) => element.id == personId).first;
  }
  
}