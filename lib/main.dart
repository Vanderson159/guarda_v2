import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:guardaappv2/routes/app_routes.dart';
import 'package:guardaappv2/routes/app_pages.dart';
import 'package:guardaappv2/theme/app_theme.dart';
//scrcpy --tcpip=192.168.1.116:5555
void main() async{
  await GetStorage.init('guardaapp'); // nome para o storage do app
  runApp(
      GetMaterialApp(
        title: "Guarda App",
        debugShowCheckedModeBanner: false,
        theme: appThemeData,
        initialRoute: Routes.INITIAL,
        getPages: AppPages.routes,
        //initialBinding: ,
      )
  );
}