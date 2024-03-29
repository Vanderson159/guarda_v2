import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:guardaappv2/data/model/auth_model.dart';
import 'package:guardaappv2/data/model/imagem_model.dart';
import 'package:guardaappv2/data/model/ocorrencia_model.dart';

class AddImagemOcorrenciaController extends GetxController{
  final box = GetStorage('guardaapp'); //instancia definida no arquivo main


  int? idOcorrenciaAtual(){
    OcorrenciaModel ocorrencia = box.read('ocorrencia');
    int? id = ocorrencia.id;
    return id;
  }

  int tutorialGet(){
    int tutorial = box.read('tutorial');
    return tutorial;
  }

  void tutorialVisto(){
    box.write('tutorial', 1);
  }

  void tutorialReset(){
    box.write('tutorial', 0);
  }

  void armazenarImagem(List<ImagemModel> imagem){
    box.write('imagem', imagem);
  }

  void resetarImagem(){
    box.remove('imagem');
  }

  List<ImagemModel> resgatarImagem(){
    List<ImagemModel> imagem = box.read('imagem');
    return imagem;
  }

  String username(){
    AuthModel auth = box.read('auth');
    String username = auth.user!.username.toString();
    return username;
  }
}