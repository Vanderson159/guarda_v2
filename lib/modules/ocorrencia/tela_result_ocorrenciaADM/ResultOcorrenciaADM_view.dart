import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:guardaappv2/api_pdf/pdf_api.dart';
import 'package:guardaappv2/components/ocorrencia_auth_dialog.dart';
import 'package:guardaappv2/components/response_dialog.dart';
import 'package:guardaappv2/components/willPopScope.dart';
import 'package:guardaappv2/data/model/ocorrencia_model.dart';
import 'package:guardaappv2/modules/ocorrencia/tela_consult_ocorrencia/ConsultOcorrencia_view.dart';
import 'package:guardaappv2/modules/ocorrencia/tela_result_ocorrenciaADM/ResultOcorrenciaADM_controller.dart';


List<OcorrenciaModel>? ocorrencialist = [];
class ResultOcorrenciaADMView extends GetView<ResultOcorrenciaADMController> {
  @override
  Widget build(BuildContext context) {
      return WillPopScopeView(
          Scaffold(
            appBar: AppBar(
              title: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                Icon(
                  Icons.person,
                  size: 40,
                ),
                SizedBox(width: 5),
                Text(controller.homeController.username())
              ]),
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
class OcorrenciatItemADM extends StatefulWidget {
  final OcorrenciaModel ocorrencia;
  final Function onClick;
  final index;

  OcorrenciatItemADM(this.ocorrencia, {required this.onClick, this.index});

  @override
  State<OcorrenciatItemADM> createState() => _OcorrenciatItemADMState();
}

class _OcorrenciatItemADMState extends State<OcorrenciatItemADM> {
  final TextEditingController _pesquisaController = TextEditingController();

  alertaFunc(String label){
    return showDialog(
        context: context,
        builder: (contextDialog){
          return AlertDialog(
            title: Text(label),
            actions: <Widget>[
              ElevatedButton(
                child: Text('OK'),
                onPressed: (){
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  String titulo() {
    String aux = widget.ocorrencia.id.toString();
    String titulo = 'BO$aux';
    return titulo;
  }

  @override
  Widget build(BuildContext context) {
    ResultOcorrenciaADMController resultOcorrenciaController = ResultOcorrenciaADMController();
    void pdfCall() async {
      resultOcorrenciaController.imagemApiClient.buscarIdImage(widget.ocorrencia.id).then((value) async{
        if (value.isEmpty) {
          final pdfFile = await PdfApi.generatePDF(ocorrenciaAUX: widget.ocorrencia);
          PdfApi.openFile(pdfFile);
        } else {
          resultOcorrenciaController.imagemApiClient.qrCodeInsert(widget.ocorrencia.id).then((value2) async{
            resultOcorrenciaController.ocorrenciaApiClient.buscarQrcode(widget.ocorrencia.id).then((value3) async{
              String base64 = value3;
              final pdfFile = await PdfApi.generatePDF(
                  ocorrenciaAUX: widget.ocorrencia,
                  imagens: value,
                  base64qrcode: base64);
              PdfApi.openFile(pdfFile);
            });
          });
        }
      });
    }
    return widget.index == 0
        ? Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextFormField(
                keyboardType: TextInputType.number,
                enabled: true,
                controller: _pesquisaController,
                style: TextStyle(fontSize: 23),
                decoration: InputDecoration(
                  hintText: 'Ex: 235',
                  icon: Icon(
                    Icons.search,
                    size: 30,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 5),
              child: ElevatedButton(
                onPressed: () {
                  if(_pesquisaController.text == ''){
                    alertaFunc('Informe um número para ser pesquisado');
                  }else{
                    var listOcorrenciaSelect = ocorrencialist!.where((element) => element.id == int.parse(_pesquisaController.text)).toList();
                    if(listOcorrenciaSelect.length <= 0){
                      alertaFunc('Ocorrência Inexistente');
                    }else{
                      OcorrenciaModel ocorrenciaSelect = OcorrenciaModel(listOcorrenciaSelect[0].id, listOcorrenciaSelect[0].dataHora, listOcorrenciaSelect[0].boletimAtendimento, listOcorrenciaSelect[0].boletimOcorrencia, listOcorrenciaSelect[0].endereco, listOcorrenciaSelect[0].local, listOcorrenciaSelect[0].fatos, listOcorrenciaSelect[0].orientacaoGuarda);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ConsultOcorrenciaView(ocorrenciaSelect),),
                      );
                    }
                  }
                },
                child: Text('Pesquisar'),
              ),
            ),
          ],
        ),
        Card(
          child: ListTile(
            trailing: Wrap(
              spacing: 12, // space between two icons
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    pdfCall();
                  },
                  icon: Icon(Icons.picture_as_pdf),
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (contextDialog) {
                          return OcorrenciaAuthDialog(
                            ocorrencia: widget.ocorrencia,
                            tipoMessage: 2,
                          );
                        });
                  },
                  icon: Icon(Icons.delete),
                ),
              ],
            ),
            onTap: () => widget.onClick(),
            title: Text(
              titulo(),
              // ignore: prefer_const_constructors
              style: TextStyle(
                fontSize: 24.0,
              ),
            ),
            subtitle: Text(
              widget.ocorrencia.dataHora.toString(),
              // ignore: prefer_const_constructors
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
          ),
        )
      ],
    )
        : Card(
      child: ListTile(
        trailing: Wrap(
          spacing: 12, // space between two icons
          children: <Widget>[
            IconButton(
              onPressed: () {
                pdfCall();
              },
              icon: Icon(Icons.picture_as_pdf),
            ),
            IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (contextDialog) {
                      return OcorrenciaAuthDialog(
                        ocorrencia: widget.ocorrencia,
                        tipoMessage: 2,
                      );
                    });
              },
              icon: Icon(Icons.delete),
            ),
          ],
        ),
        onTap: () => widget.onClick(
          pdfCall(),
        ),
        title: Text(
          titulo(),
          // ignore: prefer_const_constructors
          style: TextStyle(
            fontSize: 24.0,
          ),
        ),
        subtitle: Text(
          widget.ocorrencia.dataHora.toString(),
          // ignore: prefer_const_constructors
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),
    );
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
          children:[
            CircularProgressIndicator(),
            SizedBox(height: 10,),
            Text(message)
          ],
        ),
      ),
    );
  }
}