import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:main_app/models/tela_model.dart';

class TelaRepository{
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/data.json');
  }
  Future<List<Tela>> readData() async {
    try {
      final file = await _localFile;
      String dataJson = await file.readAsString();

      List<Tela> data = (json.decode(dataJson) as List)
          .map((i) => Tela.fromJson(i)).toList();
      return data;
    } catch (e) {
      print("Ocorreu o seguinte erro: $e");
      return List<Tela>();
    }
  }
  Future<bool> saveData(List<Tela> list) async {
    try {
      final file = await _localFile;
      final String data = json.encode(list);
      // Write the file
      file.writeAsString(data);
      return true;
    }catch(e){
      return false;
    }
  }
}