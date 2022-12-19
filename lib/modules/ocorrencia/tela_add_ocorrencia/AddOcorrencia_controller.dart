import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:guardaappv2/data/model/auth_model.dart';
import 'package:guardaappv2/data/repository/auth_repository.dart';
import 'package:guardaappv2/modules/home/home_controller.dart';

class AddOcorrenciaController extends GetxController{
  final repository = Get.find<AuthRepository>(); //pega o auth repository iniciado no bind
  final formKey = GlobalKey<FormState>(); //formkey do formulario de login
  AuthModel? auth;
  final box = GetStorage('guardaapp'); //instancia definida no arquivo main
  HomeController homeController = HomeController();
  TextEditingController dataController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController boAtendimentoController = TextEditingController();
  TextEditingController boOcorrenciaController = TextEditingController();
  TextEditingController endereco = TextEditingController();
  TextEditingController local = TextEditingController();
  TextEditingController dosfatos = TextEditingController();
  TextEditingController orientacaoGuarda = TextEditingController();

  RxBool showPassword = false.obs;
  RxBool loading = false.obs;

  String verificaCampo(){
    if(boAtendimentoController.text.isEmpty){
      return 'Boletim de atendimento!';
    }
    if(boOcorrenciaController.text.isEmpty){
      return 'Boletim de ocorrência!';
    }
    if(endereco.text.isEmpty){
      return 'endereço!';
    }
    if(local.text.isEmpty){
      return 'local!';
    }
    if(dosfatos.text.isEmpty){
      return 'dos fatos!';
    }
    if(orientacaoGuarda.text.isEmpty){
      return 'Orientação da guarda!';
    }

    return '';
  }


  void dataAtual(){
    DateTime dataTempo = DateTime.now();
    late String dia;
    late String mes;
    late String ano = dataTempo.year.toString();

    if(dataTempo.day <= 9){
      int aux = dataTempo.day;
      dia = '0$aux';
    }else{
      int aux = dataTempo.day;
      dia = aux.toString();
    }
    if(dataTempo.month <= 9){
      int aux = dataTempo.month;
      mes = '0$aux';
    }else{
      int aux = dataTempo.month;
      mes = aux.toString();
    }

    dataController.text = '$dia/$mes/$ano';
  }
  void horaAtual(){
    DateTime dataTempo = DateTime.now();
    late String hora;
    late String minuto;

    if(dataTempo.hour <= 9){
      int aux = dataTempo.hour;
      hora = '0$aux';
    }else{
      int aux = dataTempo.hour;
      hora = aux.toString();
    }
    if(dataTempo.minute <= 9){
      int aux = dataTempo.minute;
      minuto = '0$aux';
    }else{
      int aux = dataTempo.minute;
      minuto = aux.toString();
    }

    timeController.text = '$hora:$minuto';
  }
  void limpar(){
    boAtendimentoController.text = '';
    boOcorrenciaController.text = '';
    dosfatos.text = '';
    endereco.text = '';
    local.text = '';
    orientacaoGuarda.text = '';
  }
  int? guardaId(){
      auth = box.read('auth');
      return auth?.user!.guarda_id;
  }


}