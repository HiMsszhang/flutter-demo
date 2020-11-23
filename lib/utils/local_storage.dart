import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

///SharedPreferences 本地存储
class LocalStorage {
  static set(String key, value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (value.runtimeType.toString() == 'bool') {
      prefs.setBool(key, value);
    } else {
      prefs.setString(key, value);
    }
  }

  static get(String key, {ValueChanged<String> callback}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (callback != null) {
      callback(prefs.get(key));
    }
    return prefs.get(key);
  }

  static Future setJSON(String key, value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    value = json.encode(value);
    prefs.setString(key, value);
  }

  static getJSON(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.get(key) == null) return null;
    return json.decode(prefs.get(key));
  }

  static Future<bool> remove(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }

  static Future<bool> clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }
}
