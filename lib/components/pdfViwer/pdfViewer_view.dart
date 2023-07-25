import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:guardaappv2/components/pdfViwer/pdfViewer_controller.dart';

class PdfViewerView extends GetView<PdfViewerController> {
  const PdfViewerView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<PdfViewerController>(() => PdfViewerController());
    final args = Get.arguments;
    String? pdfUrl = args != null ? args['pdfUrl'] : null;
    return Scaffold(
      floatingActionButton: SpeedDial(
        icon: Icons.download,
        backgroundColor: Colors.blue.shade800,
        onPress: () {
          controller.moveFileToDownloadFolder(pdfUrl!);
        },
      ),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Visualizar PDF'),
      ),
      body: Stack(
        children: [
          Obx(
            () => IgnorePointer(
              ignoring: controller.ignorePointer.value,
              child: PDFView(
                filePath: pdfUrl,
                enableSwipe: true,
                autoSpacing: false,
                pageSnap: true,
              ),
            ),
          ),
          Obx(
            () => Visibility(
              visible: controller.loading.value,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Download ...',
                      style: TextStyle(
                          inherit: false,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1565C0)),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      height: 50,
                      width: 50,
                      child: CircularProgressIndicator(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
