import 'package:flutter/material.dart';
class MultipleLightsController{
  List<Map> _lightsMap = [];

  List<Map> get lightsMap{
    return _lightsMap;
  }

  void add(String title){
    Map aux =  new Map();
    aux['LightState'] = false;
    aux['Title'] = title;
    _lightsMap.add(aux);
  }
  void remove(String title){
    this.lightsMap.removeWhere((item) => item['Title'] == title);
  }

}