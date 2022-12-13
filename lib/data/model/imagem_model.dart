import 'dart:io';
import 'dart:typed_data';

class ImagemModel{
  int idOcorrencia;
  String base64img = '';
  String nomeImg;
  String fileName = '';
  File? image;
  String? base64Image;
  var bytes;

  ImagemModel(this.idOcorrencia, this.nomeImg, this.base64img);

  setidOcorrencia(int x){
    idOcorrencia = x;
  }

  setBase64img(String base64img){
    this.base64img = base64img;
  }

  setFileName(String fileName){
    this.fileName = fileName;
  }

  setImage(var image){
    this.image = image;
  }

  setBytes(var bytes){
    this.bytes = bytes;
  }

}