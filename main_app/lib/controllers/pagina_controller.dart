import 'package:main_app/models/tela_model.dart';
import 'package:main_app/repositories/tela_repository.dart';

class PaginaController{
  TelaRepository repository = TelaRepository();
  List<Tela> telas = [];

  Future<void> getAll() async{
    try{
      final allList = await repository.readData();
      telas.clear();
      telas.addAll(allList);
    }catch(Erro){
      print("Ocorreu o seguinte erro: $Erro");
    }
  }
  Future<void> _updateData() async{
    await repository.saveData(telas);
    await getAll();
  }

  Future<void> add(Tela novaTela) async{
    try {
      telas.add(novaTela);
      _updateData();
    }catch(Erro){
      print("Ocorreu o seguinte erro: $Erro");
    }
  }

  Future<void> remove(int idRemovida) async {
    try {
      telas.removeWhere((item) => item.idTela == idRemovida);
      _updateData();
    } catch (Erro) {
      print("Ocorreu o seguinte erro: $Erro");
    }
  }

  Future<void> update(Tela updated) async{
    try{
      int pos= telas.indexWhere((element) => element.idTela == updated.idTela);
      telas[pos] = updated;
      _updateData();
    }catch(Erro){
      print("Ocorreu o seguinte erro: $Erro");
    }
  }
}