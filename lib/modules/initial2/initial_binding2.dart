import 'package:get/get.dart';
import 'package:guardaappv2/modules/initial/initial_controller.dart';
import 'package:http/http.dart' as http;

class InitialBinding2 implements Bindings{
  @override
  void dependencies(){
    Get.lazyPut<InitialController>(() => InitialController());
  }
}