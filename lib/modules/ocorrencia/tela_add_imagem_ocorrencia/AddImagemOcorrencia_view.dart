import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
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
  final ImagePicker _picker = ImagePicker();
  String fileName = '';
  String base64Image = '';
  var bytesImage;
  String bytesString = '';
  var _image;
  var ocorrenciaAux = OcorrenciaModel.tempOcorrencia();
  String textoExm = "TEXTOOO";
  int flag = 0;
  List<ImagemModel> listImagens = [];


  @override
  Widget build(BuildContext context) {
    Future<bool?> showConfirmationDialogImage() {
      return showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Nenhuma imagem selecionada para ser enviada'),
              actions: [
                OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: const Text('Ok'),
                ),
              ],
            );
          });
    }

    xfileToFile(List<XFile> list) {
      List<File> listImage = [];
      for (int i = 0; i < list.length; i++) {
        File? imagefile = File(list[i].path);
        listImage.add(imagefile);
      }
      return listImage;
    }

    getImage() async {
      if (controller.tutorialGet() == null || controller.tutorialGet() == 0) {
        return Get.defaultDialog(
            title: "AVISO",
            content: Column(
              children: [
                Center(
                  child: Text('Para uma melhor visualização'),
                ),
                Center(
                  child: Text('das imagens, recomendamos que as fotos sejam capturadas na vertical.'),
                ),
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
                onPressed: () async {
                  List<XFile>? images = await _picker.pickMultiImage(
                      imageQuality: 80, maxWidth: 1080, maxHeight: 930);

                  List<File> fileImg = xfileToFile(images);

                  for (int i = 0; i < fileImg.length; i++) {
                    ImagemModel imgModel = ImagemModel();
                    var imgFile = fileImg[i];
                    base64Image = base64Encode(imgFile.readAsBytesSync());
                    fileName = imgFile.path.split('/').last;
                    ocorrenciaAux.base64img = base64Image;
                    ocorrenciaAux.nomeImg = fileName;
                    imgModel.nomeImg = fileName;
                    imgModel.image = imgFile;
                    imgModel.base64img = base64Image;
                    imgModel.bytes = base64Decode(base64Image);
                    imgModel.imageFilePath = imgFile.path;
                    listImagens.add(imgModel);
                  }

                  if(controller.resgatarImagem() == null || controller.resgatarImagem().length < 1){
                    controller.armazenarImagem(listImagens);
                  }else{
                    List<ImagemModel> temp;
                    temp = listImagens + controller.resgatarImagem();
                    controller.armazenarImagem(temp);
                  }
                  controller.tutorialVisto();
                  Get.offAllNamed('/tela-addImgOcorrencia');
                },
                child: Text('OK'),
              ),
            ]);
      } else {
        List<XFile>? images = await _picker.pickMultiImage(imageQuality: 80, maxWidth: 1080, maxHeight: 930);

        List<File> fileImg = xfileToFile(images);

        for (int i = 0; i < fileImg.length; i++) {
          ImagemModel imgModel = ImagemModel();
          var imgFile = fileImg[i];
          base64Image = base64Encode(imgFile.readAsBytesSync());
          fileName = imgFile.path.split('/').last;
          ocorrenciaAux.base64img = base64Image;
          ocorrenciaAux.nomeImg = fileName;
          imgModel.nomeImg = fileName;
          imgModel.image = imgFile;
          imgModel.base64img = base64Image;
          imgModel.bytes = base64Decode(base64Image);
          imgModel.imageFilePath = imgFile.path;
          listImagens.add(imgModel);
        }

        if(controller.resgatarImagem() == null || controller.resgatarImagem().length < 1){
          controller.armazenarImagem(listImagens);
        }else{
          List<ImagemModel> temp;
          temp = listImagens + controller.resgatarImagem();
          controller.armazenarImagem(temp);
        }
        controller.tutorialVisto();
        Get.offAllNamed('/tela-addImgOcorrencia');
      }
    }

    imagesBytes(List<ImagemModel> list) {
      List<Uint8List> listBytes = [];
      for (int i = 0; i < list.length; i++) {
        listBytes.add(base64Decode(list[i].base64img.toString()));
      }
      return listBytes;
    }

    viewsImages(List<Uint8List> listBytes) {
      List<dynamic> imagens = [];

      for (int i = 0; i < listBytes.length; i++) {
        imagens.add(
          Container(
            width: 350,
            height: 450,
            child: Column(
              children: [
                Image.memory(
                  listBytes[i],
                  width: 350,
                  height: 350,
                ),
                SizedBox(
                  height: 4,
                ),
                TextButton(
                  onPressed: () {
                    List<ImagemModel> aux = controller.resgatarImagem();
                    aux.removeAt(i);
                    controller.armazenarImagem(aux);
                    Get.offAllNamed('/tela-addImgOcorrencia');
                  },
                  child: Text(
                    "Remover Imagem",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
          ),
        );
      }

      return Carousel(autoplay: false, images: imagens);
    }

    Widget imageView() {
      if (controller.resgatarImagem() != null && controller.resgatarImagem().length > 0) {
        List<ImagemModel> listImagemTemp = controller.resgatarImagem();
        List<Uint8List> listBytes = imagesBytes(listImagemTemp);

        return Container(
          width: 350,
          height: 450,
          child: viewsImages(listBytes),
        );
      } else {
        return Container(
          alignment: Alignment.center,
          width: 350,
          height: 450,
          child: Center(
            child: Icon(
              Icons.add_photo_alternate,
              size: 350,
              color: Colors.blue.shade800,
            ),
          ),
        );
      }
    }

    int? idOcorrenciaAtual = controller.idOcorrenciaAtual();
    return WillPopScopeView(
        Scaffold(
          floatingActionButton: SpeedDial(
            backgroundColor: Colors.blue.shade800,
            animatedIcon: AnimatedIcons.menu_close,
            children: [
              SpeedDialChild(
                child: Icon(Icons.add_a_photo),
                label: 'Selecionar Imagens',
                onTap: (){
                  getImage();
                }
              ),
              SpeedDialChild(
                  child: Icon(Icons.save),
                  label: 'Salvar Imagens',
                  onTap: (){
                    List<ImagemModel> imagemTemp =
                    controller.resgatarImagem();
                    if (imagemTemp.isNull) {
                      showConfirmationDialogImage();
                    } else {
                      if (controller.resgatarImagem() != null) {
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (contextDialog) {
                              return ImagemAuthDialog2(
                                imagem: imagemTemp,
                              );
                            });
                      } else {
                        showConfirmationDialogImage();
                      }
                    }
                  }
              ),
              SpeedDialChild(
                  child: Icon(Icons.done),
                  label: 'Finalizar',
                  onTap: (){
                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (contextDialog) {
                          return AlertDialog(
                            title: Text(
                                'Deseja Finalizar a Inserção de Imagens?'),
                            actions: <Widget>[
                              ElevatedButton(
                                //nãoooooo
                                child: Text("NÂO"),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              ElevatedButton(
                                //nãoooooo
                                child: Text("SIM"),
                                onPressed: () {
                                  controller.resetarImagem();
                                  Get.offAllNamed('/home');
                                },
                              ),
                            ],
                          );
                        });
                  }
              ),
            ],
          ),
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text("Ocorrência: $idOcorrenciaAtual", style: TextStyle(
                        fontSize: 20
                    ),),
                    Center(
                      child: imageView(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        1);
  }
}
