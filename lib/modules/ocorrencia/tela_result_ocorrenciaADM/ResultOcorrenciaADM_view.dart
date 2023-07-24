import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:guardaappv2/components/ocorrencia_auth_dialog.dart';
import 'package:guardaappv2/components/response_dialog.dart';
import 'package:guardaappv2/components/willPopScope.dart';
import 'package:guardaappv2/data/model/ocorrencia_model.dart';
import 'package:guardaappv2/modules/ocorrencia/searchOcorrencias/custom_search.dart';
import 'package:guardaappv2/modules/ocorrencia/tela_result_ocorrenciaADM/ResultOcorrenciaADM_controller.dart';

List<OcorrenciaModel>? ocorrencialist = [];

class ResultOcorrenciaADMView extends GetView<ResultOcorrenciaADMController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScopeView(
        Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                IconButton(
                  onPressed: () {
                    showSearch(context: context, delegate: CustomSearchDelegate(controller.listOcorrenciaModel, controller.homeController.returnUser().tipoUser));
                  },
                  icon: const Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                Expanded(child: Text(''),),
                Icon(
                  Icons.person,
                  size: 40,
                ),
                SizedBox(width: 5),
                Text(controller.homeController.username())
              ],
            ),
          ),
          body: FutureBuilder<List<OcorrenciaModel>>(
            initialData: [],
            future: controller.ocorrenciaApiClient.listarDados(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  break;
                case ConnectionState.waiting:
                  return Progress();
                case ConnectionState.active:
                  break;
                case ConnectionState.done:
                  //final List<Ocorrencia>? ocorrencias = snapshot.data;

                  ocorrencialist = snapshot.data;
                  if (ocorrencialist == null) {
                    return FailureDialog('Falha ao listar ocorrências');
                  } else {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        final OcorrenciaModel ocorrencia = ocorrencialist![index];
                        controller.listOcorrenciaModel.add(ocorrencia);
                        return OcorrenciatItemADM(
                          ocorrencia,
                          onClick: () {},
                          index: index,
                        );
                      },
                      itemCount: ocorrencialist!.length,
                    );
                  }
              }
              return Text('Unknown error');
            },
          ),
        ),
        3);
  }
}

class OcorrenciatItemADM extends GetView<ResultOcorrenciaADMController> {
  final OcorrenciaModel ocorrencia;
  final Function onClick;
  final index;

  OcorrenciatItemADM(this.ocorrencia, {required this.onClick, this.index});
  final TextEditingController _pesquisaController = TextEditingController();

  String titulo() {
    String aux = ocorrencia.id.toString();
    String titulo = 'BO$aux';
    return titulo;
  }

  @override
  Widget build(BuildContext context) {
    alertaFunc(String label) {
      return showDialog(
          context: context,
          builder: (contextDialog) {
            return AlertDialog(
              title: Text(label),
              actions: <Widget>[
                ElevatedButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          });
    }

    preView(context) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(
            () => Visibility(
              visible: controller.loadingPdf.value,
              child: Center(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  width: Get.width * 0.8,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(29),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 40,
                      ),
                      child: ElevatedButton(
                        onPressed: null,
                        child: CircularProgressIndicator(
                          color: Colors.blue.shade800,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Obx(
            () => Visibility(
              visible: !controller.loadingPdf.value,
              child: AlertDialog(
                title: Center(child: Text('Ocorrência: ${ocorrencia.id}')),
                content: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Data Hora:'),
                      Text(
                        controller
                            .convertDataTime(ocorrencia.dataHora.toString()),
                      ),
                      Text('Endereço:'),
                      Text(
                        ocorrencia.endereco.toString(),
                      ),
                      Text('Local:'),
                      Text(
                        ocorrencia.local.toString(),
                      ),
                      Text('Fatos:'),
                      Text(
                        ocorrencia.fatos.toString(),
                      ),
                      Text('BO Atendimento:'),
                      Text(
                        ocorrencia.boletimAtendimento.toString(),
                      ),
                      Text('BO Ocorrência:'),
                      Text(
                        ocorrencia.boletimOcorrencia.toString(),
                      ),
                      Text('Orientação Guarda:'),
                      Text(
                        ocorrencia.orientacaoGuarda.toString(),
                      ),
                    ],
                  ),
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      controller.pdfCall(ocorrencia);
                    },
                    child: Text('IMPRIMIR'),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }

    Widget view(context) {
      return Column(
        children: [
          Card(
            child: ListTile(
              trailing: Wrap(
                spacing: 12, // space between two icons
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (contextDialog) {
                            return preView(context);
                          });
                    },
                    icon: Icon(Icons.visibility),
                  ),
                  IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (contextDialog) {
                            return OcorrenciaAuthDialog(
                              ocorrencia: ocorrencia,
                              tipoMessage: 2,
                            );
                          });
                    },
                    icon: Icon(Icons.delete),
                  ),
                ],
              ),
              onTap: () => onClick(),
              title: Text(
                titulo(),
                // ignore: prefer_const_constructors
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
              subtitle: Text(
                controller.convertDataTime(ocorrencia.dataHora.toString()),
                // ignore: prefer_const_constructors
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ),
          ),
        ],
      );
    }

    return view(context);
  }
}

class Progress extends StatelessWidget {
  final String message;

  Progress({this.message = 'Loading'});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              color: Colors.blue.shade800,
            ),
            SizedBox(
              height: 10,
            ),
            Text(message)
          ],
        ),
      ),
    );
  }
}
