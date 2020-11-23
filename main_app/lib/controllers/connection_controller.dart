import 'package:flutter/material.dart';

class ConnectionController with ChangeNotifier{
  bool _conected = false;
  bool get connected{
    return _conected;
  }
  void invert(){
    _conected = !_conected;
    notifyListeners();
  }
}