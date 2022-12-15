import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guardaappv2/modules/home/home_view.dart';

class WillPopScopeView extends StatefulWidget{
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
    return showDialog(context: context, builder: (context){
      if(tipo == 3){
        return AlertDialog(
          title: const Text('Deseja voltar?'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Não'),),
            OutlinedButton(onPressed: () {
                Get.offAllNamed('/home');
            }, child: const Text('Sim'),),
          ],
        );
      }else{
        return AlertDialog(
          title: const Text('Deseja sair sem salvar?'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancelar'),),
            OutlinedButton(onPressed: () {
              if(tipo == 2){
                Get.offAllNamed('/home');
              }else{
                Get.offAllNamed('/home');
              }
            }, child: const Text('Sair'),),
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
        if(!saved){
          final confirmation = await showConfirmationDialog();
          return confirmation ?? false;
        }
        return true;
      },
    );
  }
}

