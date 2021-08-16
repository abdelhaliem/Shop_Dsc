import 'package:dsc_shop/main.dart';
import 'package:flutter/cupertino.dart';

class Language extends ChangeNotifier {
  String _lang = language;
  getLanguage() {
    return _lang;
  }

  setLanguage(String lang) {
    _lang = lang;
    notifyListeners();
  }

  String tLanguage() {
    if (getLanguage() == 'AR') {
      return 'اللغه';
    } else {
      return "Language";
    }
  }

  String tLogOut() {
    if (getLanguage() == 'AR') {
      return 'تسجيل خروج';
    } else if (getLanguage() == 'EN') {
      return "LogOut";
    }
  }

  String tDarkMode() {
    if (getLanguage() == 'AR') {
      return 'الوضع المظلم';
    } else if (getLanguage() == 'EN') {
      return "DarkMode";
    }
  }

  String tAbout() {
    if (getLanguage() == 'AR') {
      return 'حول';
    } else if (getLanguage() == 'EN') {
      return "About";
    }
  }

  String tCategory() {
    if (getLanguage() == 'AR') {
      return 'الاقسام :';
    } else if (getLanguage() == 'EN') {
      return "Category :";
    }
  }

  String tDescription() {
    if (getLanguage() == 'AR') {
      return 'الوصف :';
    } else if (getLanguage() == 'EN') {
      return "Description :";
    }
  }
}
