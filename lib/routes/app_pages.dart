import 'package:get/get.dart';
import 'package:guardaappv2/data/model/ocorrencia_model.dart';
import 'package:guardaappv2/modules/home/home_binding.dart';
import 'package:guardaappv2/modules/home/home_view.dart';
import 'package:guardaappv2/modules/login/login_binding.dart';
import 'package:guardaappv2/modules/login/login_view.dart';
import 'package:guardaappv2/modules/ocorrencia/tela_add_imagem_ocorrencia/AddImagemOcorrencia_binding.dart';
import 'package:guardaappv2/modules/ocorrencia/tela_add_imagem_ocorrencia/AddImagemOcorrencia_view.dart';
import 'package:guardaappv2/modules/ocorrencia/tela_add_ocorrencia/AddOcorrencia_binding.dart';
import 'package:guardaappv2/modules/ocorrencia/tela_add_ocorrencia/AddOcorrencia_view.dart';
import 'package:guardaappv2/modules/ocorrencia/tela_consult_ocorrencia/ConsultOcorrenciaADM_binding.dart';
import 'package:guardaappv2/modules/ocorrencia/tela_consult_ocorrencia/ConsultOcorrenciaADM_view.dart';
import 'package:guardaappv2/modules/ocorrencia/tela_result_ocorrencia/ResultOcorrencia_binding.dart';
import 'package:guardaappv2/modules/ocorrencia/tela_result_ocorrencia/ResultOcorrencia_view.dart';
import 'package:guardaappv2/routes/app_routes.dart';

class AppPages{
  static final routes = [
    GetPage(
      name: Routes.LOGIN,
      page: ()=> LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.HOME,
      page: ()=> HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.TELA_ADD_OCORRENCIA,
      page: ()=> AddOcorrenciaView(),
      binding: AddOcorrenciaBinding(),
    ),
    GetPage(
      name: Routes.TELA_ADD_IMG_OCORRENCIA,
      page: ()=> AddImagemOcorrenciaView(),
      binding: AddImagemOcorrenciaBinding(),
    ),
    GetPage(
      name: Routes.TELA_RESULT_CORRENCIA_ADM,
      page: ()=> ResultOcorrenciaView(),
      binding: ResultOcorrenciaBinding(),
    ),
    GetPage(
      name: Routes.TELA_CONSULT_CORRENCIA_ADM,
      page: ()=> ConsultOcorrenciaView(OcorrenciaModel.tempOcorrencia()),
      binding: ConsultOcorrenciaADMbinding(),
    ),
    /*
    GetPage(
      name: Routes.WELCOME,
      page: ()=> WelcomeView(),
      binding: WelcomeBinding(),
    ),
    GetPage(
      name: Routes.SIGNUP,
      page: ()=> SignupView(),
      binding: SignupBinding(),
    ),

    */
  ];
}