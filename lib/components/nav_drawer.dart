import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guardaappv2/modules/home/home_controller.dart';
import 'package:guardaappv2/modules/ocorrencia/tela_add_imagem_ocorrencia/AddImagemOcorrencia_controller.dart';

class NavDrawer extends StatefulWidget {
  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  ListTile criarListTile(
      {required IconData icon,
      required String title,
      required BuildContext context,
      Function? acao,
      StatefulWidget? tela}) {
    return ListTile(
      leading: Icon(icon, size: 40),
      title: Text(
        title,
        style: TextStyle(fontSize: 20),
      ),
      onTap: () => {
        acao!(),
      },
    );
  }

  HomeController homeController = HomeController();
  AddImagemOcorrenciaController addImagemOcorrenciaController = AddImagemOcorrenciaController();

  @override
  Widget build(BuildContext context) {
    if(homeController.returnUser().tipoUser == 1){
      return Drawer(
        child: ListView(
          children: [
            criarListTile(
              icon: Icons.home,
              title: 'Home',
              context: context,
              acao: () {
                Get.offAllNamed('/home');
              },
            ),
            criarListTile(
              icon: Icons.add_circle,
              title: 'Nova Ocorrência',
              context: context,
              acao: () {
                Get.offAllNamed('/tela-addOcorrencia');
              },
            ),
            criarListTile(
              icon: Icons.search,
              title: 'Consultar',
              context: context,
              acao: () {
                Get.offAllNamed('/tela-resultOcorrenciaADM');
              },
            ),
            criarListTile(
              icon: Icons.exit_to_app,
              title: 'Sair',
              context: context,
              acao: () {
                addImagemOcorrenciaController.tutorialReset();
                homeController.logOut();
              },
            ),
          ],
        ),
      );
    }else{
      return Drawer(
        child: ListView(
          children: [
            criarListTile(
              icon: Icons.home,
              title: 'Home',
              context: context,
              acao: () {
                Get.offAllNamed('/home');
              },
            ),
            criarListTile(
              icon: Icons.add_circle,
              title: 'Nova Ocorrência',
              context: context,
              acao: () {
                Get.offNamed('/tela-addOcorrencia');
              },
            ),
            criarListTile(
              icon: Icons.search,
              title: 'Consultar',
              context: context,
              acao: () {
                Get.offNamed('/tela-resultOcorrencia');
              },
            ),
            criarListTile(
              icon: Icons.exit_to_app,
              title: 'Sair',
              context: context,
              acao: () {
                addImagemOcorrenciaController.tutorialReset();
                homeController.logOut();
              },
            ),
          ],
        ),
      );
    }
  }
}
