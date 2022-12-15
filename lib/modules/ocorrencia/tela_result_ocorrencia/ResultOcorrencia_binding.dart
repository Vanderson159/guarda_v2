import 'package:get/get.dart';
import 'package:guardaappv2/modules/ocorrencia/tela_result_ocorrencia/Result_controller.dart';

import '../../home/home_controller.dart';

class ResultOcorrenciaBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ResultOcorrenciaController>(() => ResultOcorrenciaController());
    Get.lazyPut<HomeController>(() => HomeController());
  }

}