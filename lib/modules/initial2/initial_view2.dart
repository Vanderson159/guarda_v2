import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guardaappv2/modules/initial/initial_controller.dart';
import 'package:guardaappv2/routes/app_routes.dart';
import 'package:http/http.dart' as http;
import 'package:splashscreen/splashscreen.dart';

class InitialView2 extends GetView<InitialController>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SplashScreen(
            seconds: 2,
            gradientBackground: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.white,
                Colors.white,
              ],
            ),
            //navigateAfterSeconds: controller.verifyAuth(),
            navigateAfterSeconds: Routes.LOGIN,
            loaderColor: Colors.transparent,
          ),
          Container(
            margin: EdgeInsets.all(100),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("imagens/webdoc.png"),
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}