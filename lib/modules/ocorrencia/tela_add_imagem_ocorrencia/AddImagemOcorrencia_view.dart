import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:guardaappv2/components/imagem_auth_dialog.dart';
import 'package:guardaappv2/components/nav_drawer.dart';
import 'package:guardaappv2/components/willPopScope.dart';
import 'package:guardaappv2/data/model/imagem_model.dart';
import 'package:guardaappv2/data/model/ocorrencia_model.dart';
import 'package:guardaappv2/modules/ocorrencia/tela_add_imagem_ocorrencia/AddImagemOcorrencia_controller.dart';
import 'package:image_picker/image_picker.dart';

class AddImagemOcorrenciaView extends GetView<AddImagemOcorrenciaController> {
  NavDrawer drawer = NavDrawer();
  String fileName = '';
  String base64Image = '';
  var bytesImage;
  String bytesString = '';
  late File? _image;
  var ocorrenciaAux = OcorrenciaModel.tempOcorrencia();
  String textoExm = "TEXTOOO";
  int flag = 0;




  @override
  Widget build(BuildContext context) {

    Future<bool?> showConfirmationDialogImage() {
      return showDialog(context: context, builder: (context){
        return AlertDialog(
          title: const Text('Nenhuma imagem selecionada para ser enviada'),
          actions: [
            OutlinedButton(onPressed: () {
              Navigator.pop(context, true);
            }, child: const Text('Ok'),),
          ],
        );
      });
    }

    getImage() async{
      return Get.defaultDialog(
        title: "Tire as fotos na vertical",
          content: Column(
            children: [
              Center(child:Text('Para uma melhor visualização'),),
              Center(child:Text('das imagens'),),

            ],
          ),
        actions: [
          Center(
            child: Column(
              children: [
                Container(
                  width: 200,
                  height: 200,
                  child: Image(
                    image: AssetImage('imagens/phone_camera.png'),
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () async{
              var image = await ImagePicker.pickImage(
                  source: ImageSource.gallery,
                  imageQuality: 80,
                  maxWidth: 1080,
                  maxHeight: 930
              );
              _image = image;
              base64Image = base64Encode(_image!.readAsBytesSync());
              fileName = _image!.path.split('/').last;
              ocorrenciaAux.base64img = base64Image;
              ocorrenciaAux.nomeImg = fileName;

              ImagemModel imagem = ImagemModel();

              imagem.nomeImg = fileName;
              imagem.image = _image;
              imagem.base64img = base64Image;
              imagem.bytes = base64Decode(base64Image);
              controller.armazenarImagem(imagem);
              Get.offAllNamed('/tela-addImgOcorrencia');
            },
            child: Text('OK'),
          ),
        ]
      );
    }

    Widget imageView(){
      if(controller.resgatarImagem() != null){
        ImagemModel imagemTemp = controller.resgatarImagem();
        var imageBytes = base64Decode(imagemTemp.base64img.toString());
        return GestureDetector(
          onTap: () async{
            await getImage();
            Get.offAllNamed('/tela-addImgOcorrencia');
          },
          child: Container(
            width: 350,
            height: 350,
            child: Image.memory(imageBytes),
          ),
        );
      }else{
        return Center(
          child: TextButton(
            onPressed: () async {
              var x = await getImage();
              if(x > 0){
                Get.offAllNamed('/tela-addImgOcorrencia');
              }
            },
            child: Icon(Icons.add_photo_alternate, size: 250,),
          ),
        );
      }
    }

    return WillPopScopeView(Scaffold(
      drawer: drawer,
      appBar: AppBar(
        title: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          Icon(
            Icons.person,
            size: 40,
          ),
          SizedBox(width: 5),
          Text(controller.username())
        ]),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: imageView(),
              ),
            ),
            SizedBox(height: 70,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (contextDialog){
                            return AlertDialog(
                              title: Text('Deseja Finalizar a Inserção de Imagens?'),
                              actions: <Widget>[
                                ElevatedButton(//nãoooooo
                                  child: Text("NÂO"),
                                  onPressed: (){
                                    Navigator.pop(context);
                                  },
                                ),
                                ElevatedButton(//nãoooooo
                                  child: Text("SIM"),
                                  onPressed: (){
                                    controller.resetarImagem();
                                    Get.offAllNamed('/home');
                                  },
                                ),
                              ],
                            );
                          });
                    },
                    child: Text(
                      'Finalizar',
                      style: TextStyle(color: Colors.blue),
                    ),
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(Size(140,50),),
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: ElevatedButton(
                    onPressed: (){
                      var imagemTemp = controller.resgatarImagem();
                      if(imagemTemp.isNull){
                        showConfirmationDialogImage();
                      }else{
                        if(imagemTemp.nomeImg != null && imagemTemp.base64img != null){
                          showDialog(
                              context: context,
                              builder: (contextDialog) {
                                return ImagemAuthDialog2(imagem: imagemTemp,);
                              });
                        }else{
                          showConfirmationDialogImage();
                        }
                      }
                    },
                    child: Text(
                      'Enviar Imagem',
                      style: TextStyle(color: Colors.blue),
                    ),
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(Size(140,50),),
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ), 1);
  }

  
}