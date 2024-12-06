
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppLocale with ChangeNotifier {
  Locale _currentLocale = const Locale('en');
  Locale get currentLocale => _currentLocale;

  AppLocale() {
    Intl.defaultLocale = _currentLocale.languageCode;
  }

  void setLocale(Locale locale) {
    _currentLocale = locale;
    Intl.defaultLocale = locale.languageCode;
    notifyListeners();
  }
}