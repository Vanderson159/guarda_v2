import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guardaappv2/components/nav_drawer.dart';
import 'package:guardaappv2/components/ocorrencia_auth_dialog.dart';
import 'package:guardaappv2/components/willPopScope.dart';
import 'package:guardaappv2/data/model/ocorrencia_model.dart';
import 'package:guardaappv2/modules/ocorrencia/tela_add_ocorrencia/AddOcorrencia_controller.dart';
import 'package:image_picker/image_picker.dart';


class AddOcorrenciaView extends GetView<AddOcorrenciaController> {

  String fileName = '';
  String base64Image = '';
  var bytesImage;
  String bytesString = '';
  late File? _image;
  var ocorrenciaAux = OcorrenciaModel.tempOcorrencia();


  Map<String, dynamic> toJson() => {
    'bytes' : bytesImage,
  };

  Uint8List convertStringToUint8List(String str) {
    final List<int> codeUnits = str.codeUnits;
    final Uint8List unit8List = Uint8List.fromList(codeUnits);

    return unit8List;
  }

  String convertUint8ListToString(Uint8List uint8list) {
    return String.fromCharCodes(uint8list);
  }

  getImage() async{
    var image = await ImagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 90,
    );

    _image = image;
    base64Image = base64Encode(_image!.readAsBytesSync());
    fileName = _image!.path.split('/').last;
    ocorrenciaAux.base64img = base64Image;
    ocorrenciaAux.nomeImg = fileName;

  }


  double fontSizeForm = 23;
  String minuto = '';

  NavDrawer drawer = NavDrawer();
  bool saved = false;

  @override
  Widget build(BuildContext context) {

    controller.dataAtual();
    controller.horaAtual();

      return WillPopScopeView(Scaffold(
        drawer: drawer,
        appBar: AppBar(
          title: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            Icon(
              Icons.person,
              size: 40,
            ),
            SizedBox(width: 5),
            //Text(provider.login)
          ]),
        ),
        body: Center(
            child: ListView(
              children: [
                //campos do formulário
                Padding(
                  padding: EdgeInsets.only(left: 8, right: 8),
                  child: TextFormField(
                    controller: controller.dataController,
                    enabled: false,
                    style: TextStyle(
                        fontSize: fontSizeForm
                    ),
                    keyboardType: TextInputType.datetime,
                    decoration: InputDecoration(
                      icon: Icon(Icons.calendar_month),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8, right: 8),
                  child: TextFormField(
                    enabled: false,
                    controller: controller.timeController,
                    style: TextStyle(
                        fontSize: fontSizeForm
                    ),
                    decoration: InputDecoration(
                      icon: Icon(Icons.schedule),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8, right: 8),
                  child: TextFormField(
                    controller: controller.boAtendimentoController,
                    textInputAction: TextInputAction.next,
                    style: TextStyle(
                        fontSize: fontSizeForm
                    ),
                    decoration: InputDecoration(
                      icon: Icon(Icons.content_paste),
                      hintText: 'Boletim de atendimento',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8, right: 8),
                  child: TextFormField(
                    controller: controller.boOcorrenciaController,
                    textInputAction: TextInputAction.next,
                    style: TextStyle(
                        fontSize: fontSizeForm
                    ),
                    decoration: InputDecoration(
                      icon: Icon(Icons.mode_comment),
                      hintText: 'Boletim de ocorrência',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8, right: 8),
                  child: TextFormField(
                    controller: controller.endereco,
                    textInputAction: TextInputAction.next,
                    style: TextStyle(
                        fontSize: fontSizeForm
                    ),
                    decoration: InputDecoration(
                      icon: Icon(Icons.place),
                      hintText: 'Endereço',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8, right: 8),
                  child: TextFormField(
                    controller: controller.local,
                    textInputAction: TextInputAction.next,
                    style: TextStyle(
                        fontSize: fontSizeForm
                    ),
                    decoration: InputDecoration(
                      icon: Icon(Icons.my_location),
                      hintText: 'Local',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8, right: 8),
                  child: TextFormField(
                    controller: controller.dosfatos,
                    textInputAction: TextInputAction.next,
                    style: TextStyle(
                        fontSize: fontSizeForm
                    ),
                    decoration: InputDecoration(
                      icon: Icon(Icons.rate_review),
                      hintText: 'Dos fatos',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8, right: 8),
                  child: TextFormField(
                    controller: controller.orientacaoGuarda,
                    textInputAction: TextInputAction.done,
                    style: TextStyle(
                        fontSize: fontSizeForm
                    ),
                    decoration: InputDecoration(
                      icon: Icon(Icons.comment),
                      hintText: 'Orientação da guarda',
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(right: 10, top: 45, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: (){
                          controller.limpar();
                        },
                        child: Text(
                          'Limpar',
                          style: TextStyle(color: Colors.blue),
                        ),
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(Size(140,50),),
                          backgroundColor: MaterialStateProperty.all(Colors.white),
                        ),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: (){
                          OcorrenciaModel ocorrenciaSend = OcorrenciaModel();
                          String data = controller.dataController.text;
                          String time = controller.timeController.text;
                          ocorrenciaSend.dataHora = '$data  $time';
                          ocorrenciaSend.boletimAtendimento = controller.boAtendimentoController.text;
                          ocorrenciaSend.boletimOcorrencia = controller.boOcorrenciaController.text;
                          ocorrenciaSend.endereco = controller.endereco.text;
                          ocorrenciaSend.local = controller.local.text;
                          ocorrenciaSend.fatos = controller.dosfatos.text;
                          ocorrenciaSend.orientacaoGuarda = controller.orientacaoGuarda.text;
                          ocorrenciaSend.guardaId = controller.guardaId();
                          if(controller.verificaCampo() != ''){
                            Get.defaultDialog(
                                title: "Campos",
                                content: Text(
                                    "Preencha o campo ${controller.verificaCampo()}"),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context, false);
                                    },
                                    child: Text('OK'),
                                  ),
                                ]);
                          }else{
                            showDialog(
                                context: context,
                                builder: (contextDialog) {
                                  return OcorrenciaAuthDialog(ocorrencia: ocorrenciaSend, tipoMessage: 1,);
                                });
                          }
                        },
                        child: Text('Finalizar'),
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(Size(140,50),),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
        ),
      ), 2);

  }
}


