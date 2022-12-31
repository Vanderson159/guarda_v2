import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:guardaappv2/data/base_url.dart';
import 'package:guardaappv2/data/model/auth_model.dart';
import 'package:guardaappv2/data/model/imagem_model.dart';
import 'package:http/http.dart' as http;

class ImagemApiClient {
  final http.Client httpClient = http.Client();
  final box = GetStorage('guardaapp'); //instancia definida no arquivo main
  String erro = 'ERRO NO QRCODE API CLIENT';

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
        "nomeImg": imagem.nomeImg.toString(),
        "base64img": imagem.base64img.toString(),
      });

      if (response.statusCode == 200) {
        return 1;
      } else {
        return 0;
      }
    } catch (err) {
      return 0;
    }
  }

  Future<int> qrCodeInsert(var id) async{
    //var url = "http://192.168.1.117/guarda/ocorrencias/inserir.php";
    if(id != null){
      AuthModel auth = box.read('auth');
      String token = '';
      if (auth.accessToken!.isNotEmpty) {
        token = auth.accessToken!;
      }
      try{
        var response = await http.post(Uri.parse(baseUrlQrcodeInsert), headers: {
          "Authorization": 'Bearer ' + token
        }, body: {
          "id": id.toString()
        }
        );
        if(response.statusCode == 200){
          print('qrcode gerado da ocorrencia ${id}');
        }
      }catch (err){
        print('qrcode não gerado da ocorrencia ${id}');
      }

      return 1;
    }else{
      return 0;
    }
  }

  Future<List> buscarIdImage(var id) async{
    List listImagens = [];
    if(id != null) {
        AuthModel auth = box.read('auth');
        String token = '';
        if (auth.accessToken!.isNotEmpty) {
          token = auth.accessToken!;
        }
        try {
          var response = await http.post(
              Uri.parse(baseUrlQrcodBuscarIdImg), headers: {
            "Authorization": 'Bearer ' + token
          }, body: {
            "id": id.toString()
          }
          );
          if (response.statusCode == 200) {
            List list = json.decode(response.body);
            for(var i = 0; i < list.length; i++) {
              if(list[i]['nomeImg'] != '' && list[i]['base64img'] != ''){
                listImagens.add(ImagemModel.fromJson(json.decode(response.body)[i]));
              }
            }
            return listImagens;
          }
        } catch (err) {
          print('a ocorrencia ${id} não possui imagem ');
        }
        return listImagens;
    }else{
      return listImagens;
    }
  }


}
