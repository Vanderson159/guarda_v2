import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:guardaappv2/components/willPopScope.dart';
import 'package:guardaappv2/data/model/user_model.dart';

class ResponseDialog extends StatelessWidget {

  final String title;
  final String message;
  final String buttonText1;
  final String buttonText2;
  final IconData icon;
  final Color colorIcon;
  final int? tipoImagem;
  int? flagAcao = 0;

  ResponseDialog({
    this.title = "",
    this.message = "",
    required this.icon,
    this.buttonText1 = 'Não',
    this.buttonText2 = 'SIM',
    this.colorIcon = Colors.black,
    this.tipoImagem,
    this.flagAcao
  });




  @override
  Widget build(BuildContext context) {
    final box = GetStorage('guardaapp'); //instancia definida no arquivo main
    if(message == 'A imagem foi adicionada com sucesso'){
      return AlertDialog(
        title: Visibility(
          child: Text(title),
          visible: title.isNotEmpty,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Visibility(
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Icon(
                  icon,
                  size: 64,
                  color: colorIcon,
                ),
              ),
              visible: icon != null,
            ),
            Visibility(
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24.0,
                  ),
                ),
              ),
              visible: message.isNotEmpty,
            )
          ],
        ),
        actions: <Widget>[
          ElevatedButton(//////SIMMMM
            child: Text(buttonText2),
            onPressed: (){
              UserModel user = box.read('userStorage');
              if(user.tipoUser == 0){
                if(tipoImagem == 1){
                  box.remove('imagem');
                  Get.offAllNamed('/tela-addImgOcorrencia');
                }else{
                  Get.offAllNamed('/home');
                }
              }
              if(user.tipoUser == 1){
                if(tipoImagem == 1){
                  box.remove('imagem');
                  Get.offAllNamed('/tela-addImgOcorrencia');
                }else{
                  Get.offAllNamed('/home');
                }
              }
            },
          ),
        ],
      );
    }else{
      if(flagAcao == 2){
        return WillPopScopeView(AlertDialog(
          title: Visibility(
            child: Text(title),
            visible: title.isNotEmpty,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Visibility(
                child: Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Icon(
                    icon,
                    size: 64,
                    color: colorIcon,
                  ),
                ),
                visible: icon != null,
              ),
              Visibility(
                child: Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Text(
                    message,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24.0,
                    ),
                  ),
                ),
                visible: message.isNotEmpty,
              )
            ],
          ),
          actions: <Widget>[
            ElevatedButton(//nãoooooo
              child: Text("OK"),
              onPressed: (){

              },
            ),
          ],
        ), 3);
      }else{
        return AlertDialog(
          title: Visibility(
            child: Text(title),
            visible: title.isNotEmpty,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Visibility(
                child: Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Icon(
                    icon,
                    size: 64,
                    color: colorIcon,
                  ),
                ),
                visible: icon != null,
              ),
              Visibility(
                child: Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Text(
                    message,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24.0,
                    ),
                  ),
                ),
                visible: message.isNotEmpty,
              )
            ],
          ),
          actions: <Widget>[
            ElevatedButton(//nãoooooo
              child: Text(buttonText1),
              onPressed: (){
                Get.offAllNamed('/home');
              },
            ),
            ElevatedButton(//////SIMMMM
              child: Text(buttonText2),
              onPressed: (){

              },
            ),
          ],
        );
      }
    }
  }
}

class SuccessDialog extends StatelessWidget {
  final String title;
  final String message;
  final IconData icon;
  final int? tipoImagem;
  final int? flagAcao;

  SuccessDialog(
    this.message, {
    this.title = 'Success',
    this.icon = Icons.done, this.tipoImagem, this.flagAcao
  });

  @override
  Widget build(BuildContext context) {
    return ResponseDialog(
      title: title,
      message: message,
      icon: icon,
      colorIcon: Colors.green,
      tipoImagem: tipoImagem,
      flagAcao: flagAcao,
    );
  }
}

class FailureDialog extends StatelessWidget {
  final String title;
  final String message;
  final IconData icon;
  final int? flagAcao;

  FailureDialog(
      this.message, {
        this.title = 'Failure',
        this.icon = Icons.warning,
        this.flagAcao
      });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Visibility(
        child: Text(title),
        visible: title.isNotEmpty,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Visibility(
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Icon(
                icon,
                size: 64,
                color: Colors.red,
              ),
            ),
            visible: icon != null,
          ),
          Visibility(
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
            ),
            visible: message.isNotEmpty,
          )
        ],
      ),
      actions: <Widget>[
        ElevatedButton(//////SIMMMM
          child: Text("OK"),
          onPressed: (){
            Get.offAllNamed('/home');
          },
        ),
      ],
    );
  }
}
