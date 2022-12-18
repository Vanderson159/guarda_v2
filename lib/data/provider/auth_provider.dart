import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guardaappv2/data/base_url.dart';
import 'package:guardaappv2/modules/login/login_controller.dart';
import 'package:http/http.dart' as http;

class AuthApiClient {
  final http.Client httpClient = http.Client();
  String erro = 'ERRO NO AUTH API CLIENT';

  Future<Map<String, dynamic>> login(String username, String password) async {
    try {
      //var response = await http.post(baseUrl + "/login", body: {
      var response = await http.post(Uri.parse(baseUrlLogin),
          body: {"username": username, "password": password});
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        Get.defaultDialog(
            title: "Login",
            content: Text(
                "${jsonDecode(response.body)['error']} : Usuário Inválido"),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Get.offAllNamed('/login');
                },
                child: Text('OK'),
              ),
            ]);
        print('erro -get: ' + response.body);
      }
    } catch (err) {
      Get.defaultDialog(title: "Login", content: Text("$err"));
      print(err);
    }
    return json.decode(erro);
  }

  Future<Map<String, dynamic>> register(
      String username, String password) async {
    try {
      //var response = await http.post(baseUrl + "/register", body: {
      var response = await http.post(Uri.parse(baseUrlRegister),
          body: {"username": username, "password": password});
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        //Get.defaultDialog(title: "Cadastro", content: Text("${json.decode(response.body)['message']}"));
        print('erro -get: ' + response.body);
      }
    } catch (err) {
      //Get.defaultDialog(title: "Cadastro", content: Text("${err}"));
      print(err);
    }
    return json.decode(erro);
  }
}
