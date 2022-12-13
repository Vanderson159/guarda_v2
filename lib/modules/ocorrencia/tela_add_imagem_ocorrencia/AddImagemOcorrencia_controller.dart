import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:guardaappv2/data/model/auth_model.dart';
import 'package:guardaappv2/data/model/imagem_model.dart';

class AddImagemOcorrenciaController extends GetxController{
  final box = GetStorage('guardaapp'); //instancia definida no arquivo main



  void armazenarImagem(ImagemModel imagem){
    box.write('imagem', imagem);
  }

  ImagemModel resgatarImagem(){
    ImagemModel imagem = box.read('imagem');
    return imagem;
  }

  String username(){
    AuthModel auth = box.read('auth');
    String username = auth.user!.username.toString();
    return username;
  }
}