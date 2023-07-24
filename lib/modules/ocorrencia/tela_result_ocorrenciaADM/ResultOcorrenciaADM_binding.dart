import 'package:get/get.dart';
import 'package:guardaappv2/components/pdfViwer/pdfViewer_controller.dart';
import 'package:guardaappv2/data/provider/imagem_provider.dart';
import 'package:guardaappv2/data/provider/ocorrenica_provider.dart';
import 'package:guardaappv2/data/repository/auth_repository.dart';
import 'package:guardaappv2/modules/ocorrencia/tela_consult_ocorrencia/ConsultOcorrencia_controller.dart';
import 'package:guardaappv2/modules/ocorrencia/tela_result_ocorrenciaADM/ResultOcorrenciaADM_controller.dart';
import '../../home/home_controller.dart';

class ResultOcorrenciaADMBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<AuthRepository>(() => AuthRepository());
    Get.lazyPut<ResultOcorrenciaADMController>(() => ResultOcorrenciaADMController());
    Get.lazyPut<PdfViewerController>(() => PdfViewerController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<ConsultOcorrenciaController>(() => ConsultOcorrenciaController());
    Get.lazyPut<OcorrenciaApiClient>(() => OcorrenciaApiClient());
    Get.lazyPut<ImagemApiClient>(() => ImagemApiClient());
  }

}