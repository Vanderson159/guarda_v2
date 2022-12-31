import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guardaappv2/components/response_dialog.dart';
import 'package:guardaappv2/data/model/ocorrencia_model.dart';
import 'package:guardaappv2/data/provider/ocorrenica_provider.dart';
import 'package:provider/provider.dart';

class OcorrenciaAuthDialog extends StatefulWidget {
  final OcorrenciaModel ocorrencia;
  int tipoMessage;

  OcorrenciaAuthDialog({required this.ocorrencia, required this.tipoMessage});

  @override
  State<OcorrenciaAuthDialog> createState() =>
      _OcorrenciaAuthDialogState(ocorrencia, tipoMessage);
}

class _OcorrenciaAuthDialogState extends State<OcorrenciaAuthDialog> {
  final OcorrenciaModel ocorrencia;
  int tipoMessage;
  String label = '';
  int flag = 1;
  OcorrenciaApiClient OcorrenciaClient = OcorrenciaApiClient();

  _OcorrenciaAuthDialogState(this.ocorrencia, this.tipoMessage);

  void _showFailureMessage(BuildContext context,
      {String message = 'Erro desconhecido'}) {
    showDialog(
        context: context,
        builder: (contextDialog) {
          return FailureDialog(message);
        });
  }

  @override
  Widget build(BuildContext context) {
    int? ocorrenciaArq = ocorrencia.id;

    if (tipoMessage == 1) {
      label = 'Tem certeza que deseja inserir a ocorrência?';
    }
    if (tipoMessage == 2) {
      label = 'Tem certeza que deseja arquivar a ocorrência $ocorrenciaArq?';
    }

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
            if (flag == 1) {
              setState(() {
                //seta pra 0 para evitar que o user ative o evento de enviar mais de uma vez
                flag = 0;
              });
              if (tipoMessage == 1) {
                OcorrenciaClient.inserir(ocorrencia).then((value) {
                  if(value == 1){
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (contextDialog) {
                        return AlertDialog(
                            title: Center(
                              child: Text('Ocorrência inserida'),
                            ),
                            actions: [
                              Center(
                                child: Column(
                                  children: [
                                    Text(
                                        "A ocorrência foi inserida com sucesso!"),
                                    Text(
                                        "Deseja adicionar imagens a ocorrência?"),
                                    Padding(
                                      padding: EdgeInsets.only(top: 5),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {
                                              Get.offAllNamed('/home');
                                            },
                                            child: Text('Não'),
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              Get.offAllNamed(
                                                  '/tela-addImgOcorrencia');
                                            },
                                            child: Text('Sim'),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ]);
                      },
                    );
                  }else{
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (contextDialog) {
                        return AlertDialog(
                            title: Center(
                              child: Text('Erro ao inserir a ocorrência'),
                            ),
                            actions: [
                              Center(
                                child: Column(
                                  children: [
                                    Text("Retornar ao inicio"),
                                    Padding(
                                      padding: EdgeInsets.only(top: 5),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {
                                              Get.offAllNamed('/home');
                                            },
                                            child: Text('OK'),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ]);
                      },
                    );
                  }

                });
              }
              if (tipoMessage == 2) {
                OcorrenciaClient.arquivar(ocorrenciaArq!).then((value) {
                  if (value == 1) {
                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (contextDialog) {
                          return SuccessDialog(
                            'Arquivado com Sucesso',
                            tipoImagem: 0,
                            flagAcao: 2,
                          );
                        });
                  } else {
                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (contextDialog) {
                          return FailureDialog('Erro ao Arquivar');
                        });
                  }
                });
              }
            }
          },
          child: Text('SIM'),
        ),
      ],
    );
  }
}
