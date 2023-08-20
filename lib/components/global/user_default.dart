import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:synchronized/synchronized.dart';

class UserDefaults {
  static UserDefaults? _instance;
  static late SharedPreferences _prefs;
  static int? _userId;
  static final Lock _lock = Lock();

  static Future<UserDefaults?> getInstance() async {
    if (_instance == null) {
      await _lock.synchronized(() async {
        if (_instance == null) {
          var instance = UserDefaults._();
          await instance._init();
          _instance = instance;
        }
      });
    }
    return _instance;
  }

  UserDefaults._();

  Future _init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// set user id
  static setUserId(int? userId) => _userId = userId;

  /// real key
  static String _realKey(String key) => _userId == null ? key : '$key.$_userId';

  /// get SharedPreferences
  static SharedPreferences getSp() => _prefs;

  /// put object.
  static Future<bool> setObject(String key, Object value) {
    return _prefs.setString(key, json.encode(value));
  }

  /// get obj.
  static T? getObj<T>(String key, T Function(Map v) f, {T? defValue}) {
    final realKey = _realKey(key);
    Map? map = getObject(realKey);
    return map == null ? defValue : f(map);
  }

  /// get object.
  static Map? getObject(String key) {
    final realKey = _realKey(key);
    String? data = _prefs.getString(realKey);
    return (data == null || data.isEmpty) ? null : json.decode(data);
  }

  /// put object list.
  static Future<bool> setObjectList(String key, List<Object> list) {
    final realKey = _realKey(key);
    List<String>? dataList = list.map((value) {
      return json.encode(value);
    }).toList();
    return _prefs.setStringList(realKey, dataList);
  }

  /// get obj list.
  static List<T> getObjList<T>(
    String key,
    T Function(Map v) f, {
    List<T> defValue = const [],
  }) {
    List<Map>? dataList = getObjectList(key);
    List<T>? list = dataList?.map((value) {
      return f(value);
    }).toList();
    return list ?? defValue;
  }

  /// get object list.
  static List<Map>? getObjectList(String key) {
    final realKey = _realKey(key);
    List<String>? dataLis = _prefs.getStringList(realKey);
    return dataLis?.map((value) {
      Map dataMap = json.decode(value);
      return dataMap;
    }).toList();
  }

  /// get string.
  static String? getString(String key, {String? defValue}) {
    final realKey = _realKey(key);
    return _prefs.getString(realKey) ?? defValue;
  }

  /// put string.
  static Future<bool> setString(String key, String value) {
    final realKey = _realKey(key);
    return _prefs.setString(realKey, value);
  }

  /// get bool.
  static bool getBool(String key, {bool defValue = false}) {
    final realKey = _realKey(key);
    return _prefs.getBool(realKey) ?? defValue;
  }

  /// put bool.
  static Future<bool> setBool(String key, bool value) {
    final realKey = _realKey(key);
    return _prefs.setBool(realKey, value);
  }

  /// get int.
  static int getInt(String key, {int defValue = 0}) {
    final realKey = _realKey(key);
    return _prefs.getInt(realKey) ?? defValue;
  }

  /// put int.
  static Future<bool> setInt(String key, int value) {
    final realKey = _realKey(key);
    return _prefs.setInt(realKey, value);
  }

  /// get double.
  static double getDouble(String key, {double defValue = 0.0}) {
    final realKey = _realKey(key);
    return _prefs.getDouble(realKey) ?? defValue;
  }

  /// put double.
  static Future<bool> setDouble(String key, double value) {
    final realKey = _realKey(key);
    return _prefs.setDouble(realKey, value);
  }

  /// get string list.
  static List<String> getStringList(
    String key, {
    List<String> defValue = const [],
  }) {
    final realKey = _realKey(key);
    return _prefs.getStringList(realKey) ?? defValue;
  }

  /// put string list.
  static Future<bool> setStringList(String key, List<String> value) {
    final realKey = _realKey(key);
    return _prefs.setStringList(realKey, value);
  }

  /// get dynamic.
  static dynamic getDynamic(String key, {Object? defValue}) {
    final realKey = _realKey(key);
    return _prefs.get(realKey) ?? defValue;
  }

  /// have key.
  static bool haveKey(String key) {
    final realKey = _realKey(key);
    return _prefs.getKeys().contains(realKey);
  }

  /// contains Key.
  static bool containsKey(String key) {
    final realKey = _realKey(key);
    return _prefs.containsKey(realKey);
  }

  /// get keys.
  static Set<String> getKeys() {
    return _prefs.getKeys();
  }

  /// remove.
  static Future<bool> remove(String key) {
    final realKey = _realKey(key);
    return _prefs.remove(realKey);
  }

  /// clear.
  static Future<bool> clear() {
    return _prefs.clear();
  }

  /// Fetches the latest values from the host platform.
  static Future<void> reload() {
    return _prefs.reload();
  }
}
