import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lecle_downloads_path_provider/lecle_downloads_path_provider.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class PdfViewerController extends GetxController{
  String filePath = '';
  RxBool loading = false.obs;
  RxBool ignorePointer = false.obs;

  Future <String> openPdf(String name, String base64Pdf) async{
    var pdfBytes = base64Decode(base64Pdf);
    final dir = await getApplicationDocumentsDirectory();

    // Defina o nome do subdiretório que você deseja criar
    String subDirectoryName = "pdf_gerados";

    // Obtenha o caminho completo para o subdiretório
    String subDirectoryPath = '${dir.path}/$subDirectoryName';

    await checkDirectoryExists(subDirectoryPath).then((value) async {
      if (!value) {
        // Crie o diretório, caso ainda não exista
        await Directory(subDirectoryPath).create(recursive: true);
      }
    });

    final file = File('$subDirectoryPath/$name');
    await file.writeAsBytes(pdfBytes);

    return file.path;
  }

  Future<bool> checkDirectoryExists(String dirPath) async {
    final directory = Directory(dirPath);
    bool exists = await directory.exists();

    if (exists) {
      return true;
    } else {
      return false;
    }
  }

  void copyFile(String sourcePath, String destinationPath) {
    File sourceFile = File(sourcePath);
    if (sourceFile.existsSync()) {
      sourceFile.copySync(destinationPath);
      debugPrint('Arquivo copiado com sucesso!');
    } else {
      debugPrint('Arquivo de origem não encontrado.');
    }
  }

  Future<void> moveFileToDownloadFolder(String filePath) async{
    loading.value= true;
    try {
      var downloadsPath = (await DownloadsPath.downloadsDirectory())?.path;

      checkDirectoryExists(downloadsPath!).then((value) async {
        if (!value) {
           await Directory(downloadsPath).create(recursive: true);
           debugPrint('diretorio criado: $downloadsPath');
        }
      });
      // Extrair o nome do arquivo a partir do caminho do arquivo original
      String fileName = filePath.split('/').last;

      // Construir o novo caminho do arquivo na pasta de downloads
      String newFilePath = '$downloadsPath/$fileName';

      copyFile(filePath, newFilePath);
    } catch (e) {
      debugPrint('Erro ao mover o arquivo: $e');
    }
    loading.value= false;
  }

  void callViewPdf(String pdfUrl) {
    Get.toNamed('/visualizar-pdf', arguments: {'pdfUrl': pdfUrl});
  }

  Future<String?> getDownloadPath() async {
    Directory? directory;
    try {
      if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      } else {
        directory = Directory('/storage/emulated/0/Download');
        // Put file in global download folder, if for an unknown reason it didn't exist, we fallback
        // ignore: avoid_slow_async_io
        if (!await directory.exists()) directory = await getExternalStorageDirectory();
      }
    } catch (err, stack) {
      debugPrint("Cannot get download folder path");
    }
    return directory?.path;
  }
}