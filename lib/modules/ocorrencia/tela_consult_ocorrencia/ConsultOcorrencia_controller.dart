import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:guardaappv2/data/model/user_model.dart';
import 'package:guardaappv2/modules/home/home_controller.dart';
import 'package:guardaappv2/modules/login/login_controller.dart';

class ConsultOcorrenciaController extends GetxController{
  LoginController loginController = LoginController();
  HomeController homeController = HomeController();

  final box = GetStorage('guardaapp');


  UserModel returnUser(){
    UserModel user = box.read('userStorage');
    return user;
  }

}