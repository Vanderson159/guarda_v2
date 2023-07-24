import 'package:get/get.dart';
import 'package:guardaappv2/components/pdfViwer/pdfViewer_controller.dart';

class PdfViewerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PdfViewerController>(() => PdfViewerController());
  }
}