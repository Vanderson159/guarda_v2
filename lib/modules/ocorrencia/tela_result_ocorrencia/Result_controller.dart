import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:guardaappv2/data/provider/imagem_provider.dart';
import 'package:guardaappv2/data/provider/ocorrenica_provider.dart';
import 'package:guardaappv2/modules/home/home_controller.dart';

class ResultOcorrenciaController extends GetxController{
  OcorrenciaApiClient ocorrenciaApiClient = OcorrenciaApiClient();
  HomeController homeController = HomeController();
  ImagemApiClient imagemApiClient = ImagemApiClient();
}