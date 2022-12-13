import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:guardaappv2/data/base_url.dart';
import 'package:guardaappv2/data/model/auth_model.dart';
import 'package:guardaappv2/data/model/ocorrencia_model.dart';
import 'package:guardaappv2/modules/login/login_controller.dart';
import 'package:http/http.dart' as http;

class OcorrenciaApiClient {
  final http.Client httpClient = http.Client();
  final box = GetStorage('guardaapp'); //instancia definida no arquivo main
  String erro = 'ERRO NO OCORRÊNCIA API CLIENT';

  Future<Map<String, dynamic>> inserir(OcorrenciaModel ocorrencia) async {
    AuthModel auth = box.read('auth');
    String token = '';
    if (auth.accessToken!.isNotEmpty) {
      token = auth.accessToken!;
    }
    try {
      var response = await http.post(Uri.parse(baseUrlOcorrencia), headers: {
        "Authorization": 'Bearer ' + token
      }, body: {
        "dataHora": ocorrencia.dataHora.toString(),
        "boletimAtendimento": ocorrencia.boletimAtendimento.toString(),
        "boletimOcorrencia": ocorrencia.boletimOcorrencia.toString(),
        "endereco": ocorrencia.endereco.toString(),
        "local": ocorrencia.local.toString(),
        "fatos": ocorrencia.fatos.toString(),
        "orientacaoGuarda": ocorrencia.orientacaoGuarda.toString(),
        "guarda_id": ocorrencia.guardaId.toString(),
      });
      if (response.statusCode == 200) {
        OcorrenciaModel ocorrenciaModel = OcorrenciaModel.fromJson(json.decode(response.body));
        box.write('ocorrencia', ocorrenciaModel);

        Get.defaultDialog(
            title: "Ocorrência inserida",
            content: Text(
                "A ocorrência foi inserida com sucesso, deseja adicionar imagens a ocorrência?"),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Get.offAllNamed('/home');
                },
                child: Text('Não'),
              ),
              ElevatedButton(
                onPressed: () {
                  Get.offAllNamed('/tela-addImgOcorrencia');
                },
                child: Text('Sim'),
              ),
            ]);
        return json.decode(response.body);
      } else {
        Get.defaultDialog(
            title: "Inserção de Ocorrência",
            content: Text(
                "${jsonDecode(response.body)['error']} : Falha ao Inserir"));
        print('erro -get: ' + response.body);
      }
    } catch (err) {
      Get.defaultDialog(
        title: "Erro na Inserção de Ocorrência",
        content: Text("$err"),
      );
      print(err);
    }
    return json.decode(erro);
  }
}
