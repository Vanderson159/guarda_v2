import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guardaappv2/modules/initial/initial_controller.dart';
import 'package:guardaappv2/modules/login/login_view.dart';

class InitialView2 extends GetView<InitialController>{
  const InitialView2({super.key});
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: EasySplashScreen(
        logo: Image.asset("imagens/webdoc.png"),
        durationInSeconds: 2,
        navigator: LoginView(),
      ),
    );
  }
}