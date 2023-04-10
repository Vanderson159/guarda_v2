import 'package:flutter/material.dart';
import 'package:guardaappv2/data/model/ocorrencia_model.dart';
import 'package:guardaappv2/modules/ocorrencia/tela_result_ocorrencia/ResultOcorrencia_view.dart';
import 'package:guardaappv2/modules/ocorrencia/tela_result_ocorrenciaADM/ResultOcorrenciaADM_view.dart';

class CustomSearchDelegate extends SearchDelegate {
  int? admin = 0; //para verificar se user e ou nao admin
  List<OcorrenciaModel> cacheList = [];
  CustomSearchDelegate(this.cacheList, this.admin);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    List<OcorrenciaModel> matchQuery = cacheList.where(
          (element) =>
          element.toString().toLowerCase().contains((query.toLowerCase())),
    ).toList();

    if(matchQuery.isEmpty){
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.search_off_outlined,
              size: 150,
            ),
            Text(
              'Nenhum resultado encontrado',
              style: TextStyle(fontSize: 25),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }
    if(admin == 1){
      return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index){
          var result = matchQuery[index];
          return OcorrenciatItemADM(
            result,
            onClick: () {},
            index: index,
          );
        },
      );
    }else{
      return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index){
          var result = matchQuery[index];
          return OcorrenciatItem(
            result,
            onClick: () {},
            index: index,
          );
        },
      );
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<OcorrenciaModel> matchQuery = cacheList.where(
          (element) =>
          element.toString().toLowerCase().contains((query.toLowerCase())),
    ).toList();

    if(matchQuery.isEmpty){
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.search_off_outlined,
              size: 150,
            ),
            Text(
              'Nenhum resultado encontrado',
              style: TextStyle(fontSize: 25),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    if(admin == 1){
      return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index){
          var result = matchQuery[index];
          return OcorrenciatItemADM(
            result,
            onClick: () {},
            index: index,
          );
        },
      );
    }else{
      return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index){
          var result = matchQuery[index];
          return OcorrenciatItem(
            result,
            onClick: () {},
            index: index,
          );
        },
      );
    }
  }

}