import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'messages_all.dart';

class GiftPlannerLocalizations {
  final String localeName;

  GiftPlannerLocalizations(this.localeName);

  static Future<GiftPlannerLocalizations> load(Locale locale){
    final String name = locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_){
      return GiftPlannerLocalizations(localeName);
    });
  }

  static GiftPlannerLocalizations of(BuildContext context) {
    return Localizations.of<GiftPlannerLocalizations>(context,GiftPlannerLocalizations);
  }

  static const LocalizationsDelegate<GiftPlannerLocalizations> delegate = _GiftPlannerLocalizationDeleage();

  
  String get appTitle {
    return Intl.message(
      'Gift Planner',
      name: 'appTitle',
      locale: localeName
    );
  }

  
}

class _GiftPlannerLocalizationDeleage extends LocalizationsDelegate<GiftPlannerLocalizations> {
  const _GiftPlannerLocalizationDeleage();

  @override
  bool isSupported(Locale locale) => ['en', 'hu'].contains(locale.languageCode);

  @override
  Future<GiftPlannerLocalizations> load(Locale locale) =>GiftPlannerLocalizations.load(locale);

  @override
  bool shouldReload(LocalizationsDelegate<GiftPlannerLocalizations> old) => false;
}