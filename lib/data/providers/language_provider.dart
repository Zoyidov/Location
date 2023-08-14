import 'package:flutter/material.dart';
import 'package:login_screen_homework/utils/constants.dart';

import 'package:flutter/foundation.dart';

class LanguageSelectionProvider extends ChangeNotifier {
  String _selectedLang = langList.first;

  String get selectedLang => _selectedLang;

  void updateSelectedLang(String newLang) {
    _selectedLang = newLang;
    notifyListeners();
  }
}


