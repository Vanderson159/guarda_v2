import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:guardaappv2/components/pdfViwer/pdfViewer_controller.dart';
import 'package:guardaappv2/data/model/ocorrencia_model.dart';
import 'package:guardaappv2/data/provider/imagem_provider.dart';
import 'package:guardaappv2/data/provider/ocorrenica_provider.dart';
import 'package:guardaappv2/modules/home/home_controller.dart';

class ResultOcorrenciaADMController extends GetxController{
  OcorrenciaApiClient ocorrenciaApiClient = OcorrenciaApiClient();
  HomeController homeController = HomeController();
  ImagemApiClient imagemApiClient = ImagemApiClient();
  List<OcorrenciaModel> listOcorrenciaModel = [];
  PdfViewerController pdfViewerController = PdfViewerController();

  RxBool loadingPdf = false.obs;

  void pdfCall(OcorrenciaModel ocorrencia) async {
    ocorrenciaApiClient.gerarPdf(ocorrencia.id).then((value) {
      if (value.length > 0) {
        pdfViewerController.openPdf(value[1], value[0]).then((value) {
          if (value != '') {
            pdfViewerController.callViewPdf(value);
          }
        });
      }else{
        print('erro ao gerar pdf');
      }
    });
  }

  String convertDataTime(String dataHora){
    String data = dataHora;
    var datetime = data.split(' ');
    var dateUSA = datetime[0].split('-');
    String ano = dateUSA[0];
    String mes = dateUSA[1];
    String dia = dateUSA[2];
    String time = datetime[1];
    String dateBR = "$dia-$mes-$ano $time";
    return dateBR;
  }
}