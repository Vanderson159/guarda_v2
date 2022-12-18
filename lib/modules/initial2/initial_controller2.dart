import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:guardaappv2/routes/app_routes.dart';

class InitialController2 extends GetxController{
  final box = GetStorage('guardaapp');
  var auth;

  String verifyAuth(){
    auth = box.read('auth');
    if(auth != null){
      return Routes.HOME;
    }else{
      return Routes.LOGIN;
    }
  }
}