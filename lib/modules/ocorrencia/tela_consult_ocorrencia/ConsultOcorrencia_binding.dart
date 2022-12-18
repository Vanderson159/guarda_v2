import 'package:get/get.dart';
import 'package:guardaappv2/data/repository/auth_repository.dart';
import 'package:guardaappv2/modules/ocorrencia/tela_consult_ocorrencia/ConsultOcorrencia_controller.dart';

class ConsultOcorrenciabinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<AuthRepository>(() => AuthRepository());
    Get.lazyPut<ConsultOcorrenciaController>(() => ConsultOcorrenciaController());
  }

}