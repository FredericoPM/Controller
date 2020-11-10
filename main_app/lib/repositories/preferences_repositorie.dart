import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences{
  Future<bool> loadTheme() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getBool('theme') ?? false;
  }
  storeTheme(bool theme) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('theme', theme);
  }
}