import 'package:get/get.dart';
import 'package:guardaappv2/data/provider/auth_provider.dart';
import 'package:guardaappv2/data/repository/auth_repository.dart';
import 'package:guardaappv2/modules/ocorrencia/tela_add_ocorrencia/AddOcorrencia_controller.dart';

class AddOcorrenciaBinding implements Bindings{
  @override
  void dependencies(){
    Get.lazyPut<AddOcorrenciaController>(() => AddOcorrenciaController());
    Get.lazyPut<AuthRepository>(() => AuthRepository());
    Get.lazyPut<AuthApiClient>(() => AuthApiClient());
  }
}