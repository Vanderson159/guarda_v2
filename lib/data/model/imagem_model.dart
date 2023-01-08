import 'dart:convert';
import 'dart:io';

class ImagemModel {
  int? id;
  int? ocorrenciaId;
  String? nomeImg;
  String? base64img;
  var bytes;
  var image;
  var imageFilePath;

  ImagemModel({this.id, this.ocorrenciaId, this.nomeImg, this.base64img});

  ImagemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ocorrenciaId = json['ocorrencia_id'];
    nomeImg = json['nomeImg'];
    base64img = json['base64img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ocorrencia_id'] = this.ocorrenciaId;
    data['nomeImg'] = this.nomeImg;
    data['base64img'] = this.base64img;
    return data;
  }


  //lista de img para json
  static listToJson(List<ImagemModel> list){
    var imagensMap = list.map((e){
      return{
        "nomeImg" : e.nomeImg.toString(),
        "base64img" : e.base64img.toString(),
      };
    }).toList();
    String imagensString = jsonEncode(imagensMap);
    return imagensString;
  }
}