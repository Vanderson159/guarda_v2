import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:guardaappv2/data/model/ocorrencia_model.dart';
import 'package:guardaappv2/modules/ocorrencia/tela_consult_ocorrencia/ConsultOcorrenciaADM_controller.dart';
import 'package:guardaappv2/modules/ocorrencia/tela_result_ocorrencia/ResultOcorrencia_view.dart';

class ConsultOcorrenciaView extends GetView<ConsultOcorrenciaAdmController> {
  final OcorrenciaModel ocorrenciaSelect;

  ConsultOcorrenciaView(this.ocorrenciaSelect);
  @override
  Widget build(BuildContext context) {

    ocorrenciaItemSelect(){
      if(controller.loginController.auth!.user!.tipoUser == 1){
        return OcorrenciatItemADM(ocorrenciaSelect, onClick: (){});
      }else{
        //return OcorrenciatItem(ocorrenciaSelect, onClick: (){});
        return OcorrenciatItemADM(ocorrenciaSelect, onClick: (){});
      }
    }


    return Scaffold(
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
      body: ListView(
        children: [
          ocorrenciaItemSelect()
        ],
      ),
    );
  }

}