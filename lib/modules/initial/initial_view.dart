import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guardaappv2/modules/initial/initial_controller.dart';
import 'package:guardaappv2/modules/initial2/initial_view2.dart';

class InitialView extends GetView<InitialController>{
  const InitialView({super.key});
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: EasySplashScreen(
        logo: Image.asset("imagens/guardamunicipal.png"),
        durationInSeconds: 2,
        navigator: const InitialView2(),
      ),
    );
  }
}