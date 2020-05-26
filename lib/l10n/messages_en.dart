// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "addGiftName" : MessageLookupByLibrary.simpleMessage("Name"),
    "addGiftNameError" : MessageLookupByLibrary.simpleMessage("Name is required"),
    "addGiftPrice" : MessageLookupByLibrary.simpleMessage("Price"),
    "addGiftPriceError" : MessageLookupByLibrary.simpleMessage("Price is required"),
    "addGiftPriceWrongFormatError" : MessageLookupByLibrary.simpleMessage("Price should be number"),
    "addGiftTitle" : MessageLookupByLibrary.simpleMessage("Add a new gift"),
    "alertContent" : MessageLookupByLibrary.simpleMessage("Add persons so we calculate statistics"),
    "alertTitle" : MessageLookupByLibrary.simpleMessage("No persons added yet"),
    "appTitle" : MessageLookupByLibrary.simpleMessage("Gift Planner"),
    "buttonCancel" : MessageLookupByLibrary.simpleMessage("Cancel"),
    "buttonChooseContact" : MessageLookupByLibrary.simpleMessage("Choose Contact"),
    "buttonChooseDate" : MessageLookupByLibrary.simpleMessage("Choose birthdate"),
    "buttonClose" : MessageLookupByLibrary.simpleMessage("Close"),
    "buttonOk" : MessageLookupByLibrary.simpleMessage("Ok"),
    "buttonSave" : MessageLookupByLibrary.simpleMessage("Save"),
    "contactChooserNotFilled" : MessageLookupByLibrary.simpleMessage("Not set yet"),
    "contactChooserTitle" : MessageLookupByLibrary.simpleMessage("Choose from your contacts"),
    "or" : MessageLookupByLibrary.simpleMessage("or"),
    "personCardBirthDate" : MessageLookupByLibrary.simpleMessage("Born  "),
    "personCardGiftNum" : MessageLookupByLibrary.simpleMessage("Number of Gifts"),
    "personCardName" : MessageLookupByLibrary.simpleMessage("Name: "),
    "personWidgetGiftName" : MessageLookupByLibrary.simpleMessage("Giftname: "),
    "personWidgetGiftPrice" : MessageLookupByLibrary.simpleMessage("Price: "),
    "personWidgetName" : MessageLookupByLibrary.simpleMessage("Name: "),
    "personWidgetTitle" : MessageLookupByLibrary.simpleMessage("\'s datas and gifts"),
    "personsAddButtonHint" : MessageLookupByLibrary.simpleMessage("Add a person"),
    "personsAddNameField" : MessageLookupByLibrary.simpleMessage("Name"),
    "personsAddPersonErrorMessageDate" : MessageLookupByLibrary.simpleMessage("Date is required"),
    "personsAddPersonErrorMessageName" : MessageLookupByLibrary.simpleMessage("You need fill this line"),
    "personsAddPersonTitle" : MessageLookupByLibrary.simpleMessage("Add new person"),
    "statistics" : MessageLookupByLibrary.simpleMessage("Statistics"),
    "statisticsPersons" : MessageLookupByLibrary.simpleMessage("Persons"),
    "statisticsTopThreeSum" : MessageLookupByLibrary.simpleMessage("All money spent on persons (TOP 3)"),
    "statisticsTopThreeSumAvg" : MessageLookupByLibrary.simpleMessage("Average money spent on persons (TOP 3)")
  };
}
