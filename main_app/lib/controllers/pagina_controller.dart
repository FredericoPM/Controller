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
  Future<void> _update() async{
    await repository.saveData(telas);
    await getAll();
  }

  Future<void> add(Tela novaTela) async{
    try {
      telas.add(novaTela);
      _update();
    }catch(Erro){
      print("Ocorreu o seguinte erro: $Erro");
    }
  }

  Future<void> remove(String nomeRemovida) async {
    try {
      this.telas.removeWhere((item) => item.nomeTela == nomeRemovida);
    } catch (Erro) {
      print("Ocorreu o seguinte erro: $Erro");
    }
  }

  Future<void> update(int id) async{
    try{

    }catch(Erro){
      print("Ocorreu o seguinte erro: $Erro");
    }
  }
}