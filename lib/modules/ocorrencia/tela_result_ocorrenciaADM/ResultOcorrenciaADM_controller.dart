import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:guardaappv2/api_pdf/pdf_api.dart';
import 'package:guardaappv2/data/model/ocorrencia_model.dart';
import 'package:guardaappv2/data/provider/imagem_provider.dart';
import 'package:guardaappv2/data/provider/ocorrenica_provider.dart';
import 'package:guardaappv2/modules/home/home_controller.dart';

class ResultOcorrenciaADMController extends GetxController{
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
}