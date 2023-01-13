import 'package:get/get.dart';
import 'package:guardaappv2/api_pdf/pdf_api.dart';
import 'package:guardaappv2/data/model/ocorrencia_model.dart';
import 'package:guardaappv2/data/provider/imagem_provider.dart';
import 'package:guardaappv2/data/provider/ocorrenica_provider.dart';
import 'package:guardaappv2/modules/home/home_controller.dart';

class ResultOcorrenciaController extends GetxController{
  OcorrenciaApiClient ocorrenciaApiClient = OcorrenciaApiClient();
  HomeController homeController = HomeController();
  ImagemApiClient imagemApiClient = ImagemApiClient();

  RxBool loadingPdf = false.obs;

  void pdfCall(OcorrenciaModel ocorrencia) async {
    loadingPdf.value = true;
    imagemApiClient.buscarIdImage(ocorrencia.id).then((value) async {
      if (value.isEmpty) {
        final pdfFile = await PdfApi.generatePDF(ocorrenciaAUX: ocorrencia);
        loadingPdf.value = false;
        PdfApi.openFile(pdfFile);
      } else {
        imagemApiClient
            .qrCodeInsert(ocorrencia.id)
            .then((value2) async {
          ocorrenciaApiClient
              .buscarQrcode(ocorrencia.id)
              .then((value3) async {
            String base64 = value3;
            final pdfFile = await PdfApi.generatePDF(ocorrenciaAUX: ocorrencia, imagens: value, base64qrcode: base64);
            loadingPdf.value = false;
            PdfApi.openFile(pdfFile);
          });
        });
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