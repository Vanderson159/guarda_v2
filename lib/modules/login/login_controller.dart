import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:guardaappv2/data/model/auth_model.dart';
import 'package:guardaappv2/data/model/user_model.dart';
import 'package:guardaappv2/data/provider/imagem_provider.dart';
import 'package:guardaappv2/data/repository/auth_repository.dart';

class LoginController extends GetxController{
  final repository = Get.find<AuthRepository>(); //pega o auth repository iniciado no bind
  final formKey = GlobalKey<FormState>(); //formkey do formulario de login
  AuthModel? auth;
  final box = GetStorage('guardaapp'); //instancia definida no arquivo main
  ImagemApiClient imagemApiClient = ImagemApiClient();
  TextEditingController usernameCtrl =  TextEditingController();
  TextEditingController passwordCtrl =  TextEditingController();

  RxBool showPassword = false.obs;
  RxBool loading = false.obs;

  void login() async{
    if(formKey.currentState!.validate()){
      loading.value = true;
      auth = await repository.login(usernameCtrl.text, passwordCtrl.text);
      UserModel? userStorage = auth!.user;

      if(!auth.isNull){
        box.remove('imagem');
        box.write('auth', auth);
        box.write('userStorage', userStorage);
        Get.offAllNamed('/home');
      }
      loading.value = false;
    }
  }

  void limpar(){
    usernameCtrl.text = '';
    passwordCtrl.text = '';
  }

  Future<void> secureScreen() async {
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  }

}