import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:guardaappv2/components/response_dialog.dart';
import 'package:guardaappv2/data/model/imagem_model.dart';
import 'package:guardaappv2/data/model/ocorrencia_model.dart';
import 'package:guardaappv2/data/provider/imagem_provider.dart';


class ImagemAuthDialog2 extends StatefulWidget {
  final ImagemModel imagem;

  ImagemAuthDialog2({required this.imagem});

  @override
  State<ImagemAuthDialog2> createState() => _ImagemAuthDialog2State(imagem);
}

class _ImagemAuthDialog2State extends State<ImagemAuthDialog2> {
  final ImagemModel imagem;
  final ImagemApiClient ImagemApi = ImagemApiClient();
  _ImagemAuthDialog2State(this.imagem);

  @override
  Widget build(BuildContext context) {
    final box = GetStorage('guardaapp'); //instancia definida no arquivo main
    OcorrenciaModel ocorrencia = box.read('ocorrencia');

    int? idLast = ocorrencia.id;
    String label = 'Tem certeza que desaja inserir a imagem na ocorrência $idLast?';
    return AlertDialog(
      title: Text(label),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('NÃO'),
        ),
        TextButton(
          onPressed: () {
            imagem.setidOcorrencia(idLast!);

            ImagemApi.inserirImagem(imagem, idLast).then((value){
              if (value == 1) {
                showDialog(
                    context: context,
                    builder: (contextDialog) {
                      return SuccessDialog(
                        'A imagem foi adicionada com sucesso',
                        tipoImagem: 1,
                      );
                    });
              } else {
                showDialog(
                    context: context,
                    builder: (contextDialog) {
                      return FailureDialog('Erro ao inserir');
                    });
              }
            });

          },
          child: Text('SIM'),
        ),
      ],
    );
  }
}
