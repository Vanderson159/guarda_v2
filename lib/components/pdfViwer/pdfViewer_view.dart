import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:guardaappv2/components/pdfViwer/pdfViewer_controller.dart';

class PdfViewerView extends GetView<PdfViewerController> {
  const PdfViewerView({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments;
    String? pdfUrl = args != null ? args['pdfUrl'] : null;
    return Scaffold(
      floatingActionButton: SpeedDial(
        icon: Icons.download,
        backgroundColor: Colors.blue.shade800,
        onPress: (){
          controller.moveFileToDownloadFolder(pdfUrl!);
        },
      ),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Visualizar PDF'),
      ),
      body: PDFView(
        filePath: pdfUrl,
        enableSwipe: true,
        autoSpacing: false,
        pageSnap: true,
      ),
    );
  }
}