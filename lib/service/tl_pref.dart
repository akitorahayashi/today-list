import 'package:shared_preferences/shared_preferences.dart';

class TLPrefService {
  static final TLPrefService _instance = TLPrefService._internal();
  static SharedPreferences? _pref;

  TLPrefService._internal();

  factory TLPrefService() {
    return _instance;
  }

  Future<SharedPreferences> get getPref async {
    _pref ??= await SharedPreferences.getInstance();
    return _pref!;
  }
}
