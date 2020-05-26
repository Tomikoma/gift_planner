// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gift_planner/gift/gift.dart';
import 'package:gift_planner/l10n/gift_planner_localizations.dart';

import 'package:gift_planner/person/person.dart';
import 'package:gift_planner/person/person_card.dart';
import 'package:gift_planner/providers/data_model.dart';
import 'package:provider/provider.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('DataModel', () {
    test('adding person', () {
      var model = DataModel();
      model.addPerson(Person(birth: DateTime.now(), name: "test1"));
      expect(model.persons.length, 1);
    });

    test('removing person', () {
      var model = DataModel();
      model.addPerson(Person(id: 1, birth: DateTime.now(), name: "test1"));
      model.addPerson(Person(id: 2, birth: DateTime.now(), name: "test2"));
      model.removePerson(1);
      expect(model.persons.length, 1);
    });

    test('get person', () {
      var model = DataModel();
      Person p = Person(id: 1, birth: DateTime.now(), name: "test1");
      model.addPerson(p);
      expect(model.person(1), p);
    });

    test('add gift', () {
      var model = DataModel();
      model.addPerson(Person(id: 1, birth: DateTime.now(), name: "test1"));
      model.addGift(new Gift(name: 'testGift1', personId: 1, price: 100));
      expect(model.person(1).gifts.length, 1);
    });

    test('remove gift', () {
      var model = DataModel();
      model.addPerson(Person(id: 1, birth: DateTime.now(), name: "test1"));
      model
          .addGift(new Gift(id: 1, name: 'testGift1', personId: 1, price: 100));
      model.removeGift(1, 1);
      expect(model.person(1).gifts.length, 0);
    });
  });
}

// testWidgets('Counter increments smoke test', (WidgetTester tester) async {
//   // Build our app and trigger a frame.
//   await tester.pumpWidget(MyApp());

//   // Verify that our counter starts at 0.
//   expect(find.text('0'), findsOneWidget);
//   expect(find.text('1'), findsNothing);

//   // Tap the '+' icon and trigger a frame.
//   await tester.tap(find.byIcon(Icons.add));
//   await tester.pump();

//   // Verify that our counter has incremented.
//   expect(find.text('0'), findsNothing);
//   expect(find.text('1'), findsOneWidget);
// });
