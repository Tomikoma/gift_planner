import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'messages_all.dart';

class GiftPlannerLocalizations {
  final String localeName;

  GiftPlannerLocalizations(this.localeName);

  static Future<GiftPlannerLocalizations> load(Locale locale) {
    final String name =
        locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      return GiftPlannerLocalizations(localeName);
    });
  }

  static GiftPlannerLocalizations of(BuildContext context) {
    return Localizations.of<GiftPlannerLocalizations>(
        context, GiftPlannerLocalizations);
  }

  static const LocalizationsDelegate<GiftPlannerLocalizations> delegate =
      _GiftPlannerLocalizationDeleage();

  String get appTitle {
    return Intl.message('Gift Planner', name: 'appTitle', locale: localeName);
  }

  String get personCardName {
    return Intl.message('Name: ', name: 'personCardName', locale: localeName);
  }

  String get personCardBirthDate {
    return Intl.message('Born  ',
        name: 'personCardBirthDate', locale: localeName);
  }

  String get personCardGiftNum {
    return Intl.message('Number of Gifts',
        name: 'personCardGiftNum', locale: localeName);
  }

  String get statistics {
    return Intl.message('Statistics', name: 'statistics', locale: localeName);
  }

  String get statisticsTopThreeSumAvg {
    return Intl.message('Average money spent on persons (TOP 3)',
        name: 'statisticsTopThreeSumAvg', locale: localeName);
  }

  String get statisticsPersons {
    return Intl.message('Persons',
        name: 'statisticsPersons', locale: localeName);
  }

  String get statisticsTopThreeSum {
    return Intl.message('All money spent on persons (TOP 3)',
        name: 'statisticsTopThreeSum', locale: localeName);
  }

  String get personsAddButtonHint {
    return Intl.message('Add a person',
        name: 'personsAddButtonHint', locale: localeName);
  }

    String get personsAddNameField {
    return Intl.message('Name',
        name: 'personsAddNameField', locale: localeName);
  }

  String get personsAddPersonTitle {
    return Intl.message('Add new person',
        name: 'personsAddPersonTitle', locale: localeName);
  }

  String get personsAddPersonErrorMessageName {
    return Intl.message('You need fill this line',
        name: 'personsAddPersonErrorMessageName', locale: localeName);
  }

  String get personsAddPersonErrorMessageDate {
    return Intl.message('Date is required',
        name: 'personsAddPersonErrorMessageDate', locale: localeName);
  }

  String get alertTitle {
    return Intl.message('No persons added yet',
        name: 'alertTitle', locale: localeName);
  }

  String get alertContent {
    return Intl.message('Add persons so we calculate statistics',
        name: 'alertContent', locale: localeName);
  }

  String get buttonCancel {
    return Intl.message('Cancel', name: 'buttonCancel', locale: localeName);
  }

  String get buttonOk {
    return Intl.message('Ok', name: 'buttonOk', locale: localeName);
  }

  String get buttonSave {
    return Intl.message('Save', name: 'buttonSave', locale: localeName);
  }

  String get buttonClose {
    return Intl.message('Close', name: 'buttonClose', locale: localeName);
  }

  String get buttonChooseDate {
    return Intl.message('Choose birthdate',
        name: 'buttonChooseDate', locale: localeName);
  }

  String get or {
    return Intl.message('or', name: 'or', locale: localeName);
  }

  String get buttonChooseContact {
    return Intl.message('Choose Contact',
        name: 'buttonChooseContact', locale: localeName);
  }

  String get contactChooserTitle {
    return Intl.message('Choose from your contacts',
        name: 'contactChooserTitle', locale: localeName);
  }

  String get contactChooserNotFilled {
    return Intl.message('Not set yet',
        name: 'contactChooserNotFilled', locale: localeName);
  }

  String get personWidgetTitle {
    return Intl.message('\'s datas and gifts',
        name: 'personWidgetTitle', locale: localeName);
  }

  String get personWidgetName {
    return Intl.message('Name: ', name: 'personWidgetName', locale: localeName);
  }

  String get personWidgetGiftName {
    return Intl.message('Giftname: ',
        name: 'personWidgetGiftName', locale: localeName);
  }

  String get personWidgetGiftPrice {
    return Intl.message('Price: ',
        name: 'personWidgetGiftPrice', locale: localeName);
  }

  String get addGiftTitle {
    return Intl.message('Add a new gift',
        name: 'addGiftTitle', locale: localeName);
  }

  String get addGiftName {
    return Intl.message('Name', name: 'addGiftName', locale: localeName);
  }

  String get addGiftNameError {
    return Intl.message('Name is required',
        name: 'addGiftNameError', locale: localeName);
  }

  String get addGiftPrice {
    return Intl.message('Price', name: 'addGiftPrice', locale: localeName);
  }

  String get addGiftPriceError {
    return Intl.message('Price is required',
        name: 'addGiftPriceError', locale: localeName);
  }

  String get addGiftPriceWrongFormatError {
    return Intl.message('Price should be number',
        name: 'addGiftPriceWrongFormatError', locale: localeName);
  }
}

class _GiftPlannerLocalizationDeleage
    extends LocalizationsDelegate<GiftPlannerLocalizations> {
  const _GiftPlannerLocalizationDeleage();

  @override
  bool isSupported(Locale locale) => ['en', 'hu'].contains(locale.languageCode);

  @override
  Future<GiftPlannerLocalizations> load(Locale locale) =>
      GiftPlannerLocalizations.load(locale);

  @override
  bool shouldReload(LocalizationsDelegate<GiftPlannerLocalizations> old) =>
      false;
}
