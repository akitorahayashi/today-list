import 'package:shared_preferences/shared_preferences.dart';

class TLPref {
  static final TLPref _instance = TLPref._internal();
  static SharedPreferences? _pref;

  TLPref._internal();

  factory TLPref() {
    return _instance;
  }

  Future<SharedPreferences> get getPref async {
    _pref ??= await SharedPreferences.getInstance();
    return _pref!;
  }
}
