import 'package:get/get.dart';
import 'package:guardaappv2/data/repository/auth_repository.dart';
import 'package:guardaappv2/modules/initial/initial_controller.dart';
import 'package:guardaappv2/modules/login/login_controller.dart';

class InitialBinding2 implements Bindings{
  @override
  void dependencies(){
    Get.lazyPut<InitialController>(() => InitialController());
    Get.lazyPut<LoginController>(() => LoginController());
    Get.lazyPut<AuthRepository>(() => AuthRepository());
  }
}