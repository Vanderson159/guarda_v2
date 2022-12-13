import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:guardaappv2/data/model/auth_model.dart';

class HomeController extends GetxController{
  final box = GetStorage('guardaapp');


  void logOut(){
    box.erase();
    Get.offAllNamed('/login');
  }

  void telaAddOcorrencia(){
    Get.offAllNamed('/tela-addOcorrencia');
  }

  String username(){
    AuthModel auth = box.read('auth');
    String username = auth.user!.username.toString();
    return username;
  }

}