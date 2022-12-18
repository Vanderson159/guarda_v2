import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:guardaappv2/data/model/ocorrencia_model.dart';
import 'package:guardaappv2/data/model/user_model.dart';
import 'package:guardaappv2/modules/ocorrencia/tela_consult_ocorrencia/ConsultOcorrencia_controller.dart';
import 'package:guardaappv2/modules/ocorrencia/tela_result_ocorrencia/ResultOcorrencia_view.dart';
import 'package:guardaappv2/modules/ocorrencia/tela_result_ocorrenciaADM/ResultOcorrenciaADM_view.dart';

class ConsultOcorrenciaView extends GetView<ConsultOcorrenciaController> {
  final OcorrenciaModel ocorrenciaSelect;

  ConsultOcorrenciaView(this.ocorrenciaSelect);
  @override
  Widget build(BuildContext context) {

    ocorrenciaItemSelect(){
      UserModel user = controller.returnUser();
      if(!user.isNull){
        if(user.tipoUser == 1){
          return OcorrenciatItemADM(ocorrenciaSelect, onClick: (){});
        }else{
          return OcorrenciatItem(ocorrenciaSelect, onClick: (){});
          //return OcorrenciatItem(ocorrenciaSelect, onClick: (){});
        }
      }else{
        return Container();
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