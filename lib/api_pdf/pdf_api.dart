import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:guardaappv2/data/model/guarda_model.dart';
import 'package:guardaappv2/data/model/imagem_model.dart';
import 'package:guardaappv2/data/model/ocorrencia_model.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:pdf/widgets.dart' as p;


class PdfApi {

  static Future<File> generatePDF({OcorrenciaModel? ocorrenciaAUX, GuardaModel? guardaAUX, List<dynamic>? imagens = null, String? base64qrcode}) async {
    final pdf = Document();
    String titulo = '';


    if (ocorrenciaAUX != null) {

      final String id = ocorrenciaAUX.id.toString();
      titulo = 'BO$id';
      final String dataHora = ocorrenciaAUX.dataHora.toString();
      final String boletimAtendimento = ocorrenciaAUX.boletimAtendimento.toString();
      final String boletimOcorrencia = ocorrenciaAUX.boletimOcorrencia.toString();
      final String endereco = ocorrenciaAUX.endereco.toString();
      final String local = ocorrenciaAUX.local.toString();
      final String fatos = ocorrenciaAUX.fatos.toString();
      final String orientacaoGuarda = ocorrenciaAUX.orientacaoGuarda.toString();
      final imageJpg = (await rootBundle.load('imagens/guardamunicipal.png')).buffer.asUint8List();

      List<p.Widget> widgets = [];

      verificaQrcode(){
        if(base64qrcode != null){
          final imageQrcode = base64Decode(base64qrcode);
          widgets.add(
            p.Padding(
              padding: p.EdgeInsets.only(left: -15, top: 100),
              child: p.Column(mainAxisAlignment: p.MainAxisAlignment.center, children: [
                p.Text('PARA VISUALIZAR AS IMAGENS NA RESOLUÇÂO ORIGINAL ESCANEIE O QRCODE'),
                p.Container(
                  height: 200,
                  width: 200,
                  child: p.Image(p.MemoryImage(imageQrcode),
                      fit: p.BoxFit.cover),
                ),
              ]),
            ),
          );
        }
      }


      //logo da instituição
      widgets.add(
        p.Row(
          mainAxisAlignment: p.MainAxisAlignment.center,
          children: [
            p.Container(
              width: 100,
              height: 100,
              child: p.Image(p.MemoryImage(imageJpg), fit: p.BoxFit.cover),
            ),
            p.SizedBox(height: 20),
          ],
        ),
      );
      //informações da ocorrência
      widgets.add(
        p.Column(
          mainAxisAlignment: p.MainAxisAlignment.start,
          crossAxisAlignment: p.CrossAxisAlignment.start,
          children: [
            p.Center(child: p.Text('Relatório da Ocorrência')),
            p.SizedBox(height: 20),
            p.Text('ID da Ocorrência: $id'),
            p.SizedBox(height: 20),
            p.Text('Data e Hora da Ocorrência: $dataHora'),
            p.SizedBox(height: 20),
            p.Text('Endereço: $endereco'),
            p.SizedBox(height: 20),
            p.Text('Localização: $local'),
            p.SizedBox(height: 20),
            p.Text('Dos fatos: $fatos'),
            p.SizedBox(height: 20),
            p.Text('Boletim Atendimento: $boletimAtendimento'),
            p.SizedBox(height: 20),
            p.Text('Boletim Ocorrênica: $boletimOcorrencia'),
            p.SizedBox(height: 20),
            p.Text('Orientação da Guarda: $orientacaoGuarda'),
          ],
        ),
      );


      if(imagens != null){
        //imagens da ocorrência
        int tamanhoLista = imagens.length;
        int count = 0;

        //caso o numero de imagens da ocorrencia for par
        if(imagens.length % 2 == 0){
          do{
            ImagemModel img = imagens[count];
            ImagemModel img2 = imagens[count+1];

            final imageJpg2 = base64Decode(img.base64img.toString());
            final imageJpg3 = base64Decode(img2.base64img.toString());

            widgets.add(
              p.Padding(
                padding: p.EdgeInsets.only(left: -15),
                child: p.Row(mainAxisAlignment: p.MainAxisAlignment.center, children: [
                  p.Container(
                    child: p.Image(p.MemoryImage(imageJpg2),
                        fit: p.BoxFit.cover, width: 250, height: 350),
                  ),
                  p.SizedBox(width: 20),
                  p.Container(
                    child: p.Image(p.MemoryImage(imageJpg3),
                        fit: p.BoxFit.cover, width: 250, height: 350),
                  ),
                ]),
              ),
            );
            count = count + 2;
          }while(count < tamanhoLista);
        }else{
          //caso o tamanho da lista de imagem for maior que um e for impar
          if(tamanhoLista > 1){
            int duplas = (tamanhoLista/2).toInt();
            print("PRINT DUPLAS");
            print(duplas);
            int flag = 0;

            do{
              ImagemModel img = imagens[count];
              ImagemModel img2 = imagens[count+1];

              final imageJpg2 = base64Decode(img.base64img.toString());
              final imageJpg3 = base64Decode(img2.base64img.toString());

              widgets.add(
                p.Padding(
                  padding: p.EdgeInsets.only(left: -15),
                  child: p.Row(mainAxisAlignment: p.MainAxisAlignment.center, children: [
                    p.Container(
                      child: p.Image(p.MemoryImage(imageJpg2),
                          fit: p.BoxFit.cover, width: 250, height: 350),
                    ),
                    p.SizedBox(width: 20),
                    p.Container(
                      child: p.Image(p.MemoryImage(imageJpg3),
                          fit: p.BoxFit.cover, width: 250, height: 350),
                    ),
                  ]),
                ),
              );
              count = count + 2;
            }while(count < duplas*2);

            ImagemModel img = imagens.last;

            final imageJpg2 = base64Decode(img.base64img.toString());

            widgets.add(
              p.Padding(
                padding: p.EdgeInsets.only(left: -15, top: 20),
                child: p.Row(mainAxisAlignment: p.MainAxisAlignment.center, children: [
                  p.Container(
                    child: p.Image(p.MemoryImage(imageJpg2),
                        fit: p.BoxFit.cover, width: 250, height: 350),
                  ),
                ]),
              ),
            );

          }else{

            //caso seja somente uma imagem
            ImagemModel img = imagens[0];

            final imageJpg2 = base64Decode(img.base64img.toString());

            widgets.add(
              p.Padding(
                padding: p.EdgeInsets.only(left: -15),
                child: p.Row(mainAxisAlignment: p.MainAxisAlignment.center, children: [
                  p.Container(
                    height: 650,
                    width: 450,
                    child: p.Image(p.MemoryImage(imageJpg2),
                        fit: p.BoxFit.cover),
                  ),
                ]),
              ),
            );
          }
        }
        verificaQrcode();
      }

      pdf.addPage(
        p.MultiPage(
          pageFormat: PdfPageFormat.a4,
          build: (context) => widgets, //here goes the widgets list
        ),
      );  
    }

    return saveDocument(name: '$titulo.pdf', pdf: pdf);
  }

  static Future<File> generateImage() async {
    final pdf = Document();

    final imageJpg =
        (await rootBundle.load('assets/person.jpg')).buffer.asUint8List();

    pdf.addPage(
      p.Page(
          pageFormat: PdfPageFormat.a4,
          build: (Context context) {
            return FullPage(
              ignoreMargins: true,
              child: p.Image(p.MemoryImage(imageJpg), fit: p.BoxFit.cover),
            );
          }),
    );

    return saveDocument(name: 'my_example.pdf', pdf: pdf);
  }

  static Future<File> saveDocument({
    required String name,
    required Document pdf,
  }) async {
    final bytes = await pdf.save();

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');

    await file.writeAsBytes(bytes);

    return file;
  }

  static Future openFile(File file) async {
    final url = file.path;
    await OpenFile.open(url);
  }
}
