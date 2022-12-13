import 'package:get/get.dart';
import 'package:guardaappv2/modules/ocorrencia/tela_add_imagem_ocorrencia/AddImagemOcorrencia_controller.dart';

class AddImagemOcorrenciaBinding implements Bindings{
  @override
  void dependencies(){
    Get.lazyPut<AddImagemOcorrenciaController>(() => AddImagemOcorrenciaController());
    //Get.lazyPut<AuthRepository>(() => AuthRepository());
    //Get.lazyPut<AuthApiClient>(() => AuthApiClient());
  }
}