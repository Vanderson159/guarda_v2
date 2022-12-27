import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:guardaappv2/data/base_url.dart';
import 'package:guardaappv2/data/model/auth_model.dart';
import 'package:guardaappv2/data/model/ocorrencia_model.dart';
import 'package:http/http.dart' as http;

class OcorrenciaApiClient {
  final http.Client httpClient = http.Client();
  final box = GetStorage('guardaapp'); //instancia definida no arquivo main
  String erro = 'ERRO NO OCORRÊNCIA API CLIENT';

  Future inserir(OcorrenciaModel ocorrencia) async {
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
        OcorrenciaModel ocorrenciaModel =
            OcorrenciaModel.fromJson(json.decode(response.body));
        box.write('ocorrencia', ocorrenciaModel);
        return 1;
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

  Future<List<OcorrenciaModel>> listarDados() async {
    AuthModel auth = box.read('auth');
    String token = '';
    if (auth.accessToken!.isNotEmpty) {
      token = auth.accessToken!;
    }
    try {
      var response = await http.get(Uri.parse(baseUrlOcorrencias),
          headers: {"Authorization": 'Bearer ' + token});
      if (response.statusCode == 200) {
        List list = json.decode(response.body);
        List<OcorrenciaModel>? ocorrencias = [];
        for (var i = 0; i < list.length; i++) {
          if (list[i]['arquivado'] != 1) {
            ocorrencias.add(OcorrenciaModel.fromJson(list[i]));
          }
        }

        if (ocorrencias.isEmpty) {
          Get.defaultDialog(
              title: "Nenhuma ocorrência encontrada",
              content: Text(':('),
              actions: [
                ElevatedButton(
                  onPressed: () => Get.offAllNamed('/home'),
                  child: Text('OK'),
                ),
              ]);
        }
        return ocorrencias;
      } else {
        Get.defaultDialog(
            title: "Erro ao listar ocorrências",
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

  Future<String> buscarQrcode(var id) async {
    var qrcode;
    AuthModel auth = box.read('auth');
    String token = '';
    if (auth.accessToken!.isNotEmpty) {
      token = auth.accessToken!;
    }

    try {
      var response = await http.post(Uri.parse(baseUrlQrcodBuscarQrCode),
          headers: {"Authorization": 'Bearer ' + token},
          body: {"id": id.toString()});

      if (response.statusCode == 200) {
        qrcode = json.decode(response.body);
        return qrcode['qrcode'].toString();
      }
    } catch (err) {
      return '';
    }
    return '';
  }

  Future<int> arquivar(int id) async {
    if (id != null) {
      AuthModel auth = box.read('auth');
      String token = '';
      if (auth.accessToken!.isNotEmpty) {
        token = auth.accessToken!;
      }
      var response = await http.post(Uri.parse(baseUrlArquivar),
          headers: {"Authorization": 'Bearer ' + token},
          body: {"id": id.toString()});

      if (response.statusCode == 200) {
        return 1;
      }else{
        return 0;
      }
    }
    return 0;
  }
}
