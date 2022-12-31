import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guardaappv2/modules/ocorrencia/tela_add_imagem_ocorrencia/AddImagemOcorrencia_controller.dart';

class WillPopScopeView extends StatefulWidget {
  Widget? view;
  int? tipo;

  WillPopScopeView(this.view, this.tipo);

  @override
  State<WillPopScopeView> createState() => _WillPopScopeViewState(view!, tipo!);
}

class _WillPopScopeViewState extends State<WillPopScopeView> {
  bool saved = false;
  Widget view;
  int? tipo;
  _WillPopScopeViewState(this.view, this.tipo);

  Future<bool?> showConfirmationDialog() {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          if (tipo == 3) {
            return AlertDialog(
              title: const Text('Deseja voltar?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: Text('Não', style: TextStyle(color: Colors.blue.shade800),),
                ),
                OutlinedButton(
                  onPressed: () {
                    Get.offAllNamed('/home');
                  },
                  child: Text('Sim', style: TextStyle(color: Colors.blue.shade800),),
                ),
              ],
            );
          } else {
            return AlertDialog(
              title: const Text('Deseja sair sem salvar?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: Text('Cancelar', style: TextStyle(color: Colors.blue.shade800),),
                ),
                OutlinedButton(
                  onPressed: () {
                    if (tipo == 2) {
                      Get.offAllNamed('/home');
                    } else {
                      AddImagemOcorrenciaController addImagemOcorrenciaController = AddImagemOcorrenciaController();
                      addImagemOcorrenciaController.resetarImagem();
                      Get.offAllNamed('/home');
                    }
                  },
                  child: Text('Sair', style: TextStyle(color: Colors.blue.shade800),),
                ),
              ],
            );
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: view,
      onWillPop: () async {
        if (!saved) {
          final confirmation = await showConfirmationDialog();
          return confirmation ?? false;
        }
        return true;
      },
    );
  }
}
