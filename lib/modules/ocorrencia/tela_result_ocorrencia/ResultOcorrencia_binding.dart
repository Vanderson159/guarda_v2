import 'package:get/get.dart';
import 'package:guardaappv2/data/repository/auth_repository.dart';
import 'package:guardaappv2/modules/home/home_controller.dart';
import 'package:guardaappv2/modules/ocorrencia/tela_consult_ocorrencia/ConsultOcorrencia_controller.dart';
import 'package:guardaappv2/modules/ocorrencia/tela_result_ocorrencia/ResultOcorrencia_controller.dart';

class ResultOcorrenciaBinding implements Bindings{

  @override
  void dependencies() {
    Get.lazyPut<ResultOcorrenciaController>(() => ResultOcorrenciaController());
    Get.lazyPut<AuthRepository>(() => AuthRepository());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<ConsultOcorrenciaController>(() => ConsultOcorrenciaController());
  }
}