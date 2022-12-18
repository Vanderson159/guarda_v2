import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:guardaappv2/data/model/auth_model.dart';
import 'package:guardaappv2/data/model/user_model.dart';

class HomeController extends GetxController{
  final box = GetStorage('guardaapp');
  var auth;

  void logOut(){
    box.erase();
    Get.offAllNamed('/login');
  }

  void telaAddOcorrencia(){
    Get.offNamed('/tela-addOcorrencia');
  }

  void telaResultOcorrencia(){
    AuthModel auth = box.read('auth');
    if(auth.user!.tipoUser == 1){
      Get.offNamed('/tela-resultOcorrenciaADM');
    }else{
      Get.offNamed('/tela-resultOcorrencia');
    }
  }

  String username(){
    auth = box.read('auth');
    String username = auth.user!.username.toString();
    return username;
  }

  UserModel returnUser(){
    UserModel user = box.read('userStorage');
    return user;
  }

}