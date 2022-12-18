import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guardaappv2/components/nav_drawer.dart';
import 'package:guardaappv2/modules/home/home_controller.dart';

class HomeView extends GetView<HomeController> {
  NavDrawer drawer = NavDrawer();
  @override
  Widget build(BuildContext context) {
    controller.username();
      return Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
          backgroundColor: Colors.blue.shade800,
          title: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            Icon(
              Icons.person,
              size: 40,
            ),
            SizedBox(width: 5),
            Text(controller.username().toString()),
          ]),
        ),
        body: Column(
          children: [
            Expanded(
              child: GestureDetector(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(width: 1.0, color: Color(0xFF000000)),
                        left: BorderSide(width: 1.0, color: Color(0xFF000000)),
                        right: BorderSide(width: 1.0, color: Color(0xFF000000)),
                        bottom:
                        BorderSide(width: 1.0, color: Color(0xFF000000))),
                  ),
                  alignment: Alignment.center,
                  child: ListTile(
                    leading: Icon(Icons.create_outlined, size: 80),
                    title: Text(
                      'Adicionar Ocorrência',
                      style: TextStyle(fontSize: 45),
                    ),
                    onTap: () {
                      controller.telaAddOcorrencia();
                      //Navigator.pushNamed(context, 'tela-addOcorrencia');
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(width: 1.0, color: Color(0xFF000000)),
                        left: BorderSide(width: 1.0, color: Color(0xFF000000)),
                        right: BorderSide(width: 1.0, color: Color(0xFF000000)),
                        bottom:
                        BorderSide(width: 1.0, color: Color(0xFF000000))),
                  ),
                  alignment: Alignment.center,
                  child: ListTile(
                    leading: Icon(Icons.search, size: 80),
                    title: Text(
                      'Consultar Ocorrência',
                      style: TextStyle(fontSize: 45),
                    ),
                    onTap: () => {
                      controller.telaResultOcorrencia()
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      );
  }
}


