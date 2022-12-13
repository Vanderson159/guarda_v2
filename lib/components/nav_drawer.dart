import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:guardaappv2/modules/home/home_controller.dart';

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

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          criarListTile(
            icon: Icons.home,
            title: 'Home',
            context: context,
            acao: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  'tela-principalADM', (Route<dynamic> route) => false);
            },
          ),
          /*
            criarListTile(
              icon: Icons.manage_accounts,
              title: 'Administração',
              context: context,
              tela: TelaPrincipal(),
            ),
            */
          criarListTile(
            icon: Icons.add_circle,
            title: 'Nova Ocorrência',
            context: context,
            acao: () {
              Navigator.of(context).pushNamed('tela-addOcorrencia');
            },
          ),
          criarListTile(
            icon: Icons.search,
            title: 'Consultar',
            context: context,
            acao: () {
              //Navigator.of(context).pushNamed('tela-resultaddOcorrenciaADM');
            },
          ),
          criarListTile(
            icon: Icons.exit_to_app,
            title: 'Sair',
            context: context,
            acao: () {
              homeController.logOut();
            },
          ),
        ],
      ),
    );
  }
}
