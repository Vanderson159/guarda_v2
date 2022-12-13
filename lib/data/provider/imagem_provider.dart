import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:guardaappv2/data/base_url.dart';
import 'package:guardaappv2/data/model/auth_model.dart';
import 'package:guardaappv2/data/model/imagem_model.dart';
import 'package:http/http.dart' as http;

class ImagemApiClient {
  final http.Client httpClient = http.Client();
  final box = GetStorage('guardaapp'); //instancia definida no arquivo main
  String erro = 'ERRO NO IMAGEM API CLIENT';

  Future<int> inserirImagem(ImagemModel imagem, int idOcorrencia) async {
    AuthModel auth = box.read('auth');
    String token = '';
    if (auth.accessToken!.isNotEmpty) {
      token = auth.accessToken!;
    }
    try {

      var response = await http.post(Uri.parse(baseUrlImagem), headers: {
        "Authorization": 'Bearer ' + token
      }, body: {
        "ocorrencia_id": idOcorrencia.toString(),
        "nomeImg": imagem.fileName.toString(),
        "base64img": imagem.base64Image.toString(),
      });
      print("STATUS CODE");
      print(response.statusCode);
      if (response.statusCode == 200) {
        return 1;
      } else {
        return 0;
      }
    } catch (err) {
      return 0;
    }
  }
}
