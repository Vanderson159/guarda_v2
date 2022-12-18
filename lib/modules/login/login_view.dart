import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guardaappv2/modules/login/login_controller.dart';

class LoginView extends GetView<LoginController> {

  @override
  Widget build(BuildContext context) {
    //controller.secureScreen();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: controller.formKey,
            child: Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 250,
                    width: 250,
                    child: Image(
                      image: AssetImage('imagens/guardamunicipal.png'),
                    ),
                  ),
                  TextField(
                    controller: controller.usernameCtrl,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(labelText: 'Usuário'),
                    style: TextStyle(
                      fontSize: 24.0,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: TextField(
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      controller: controller.passwordCtrl,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(labelText: 'Senha'),
                      style: TextStyle(
                        fontSize: 24.0,
                      ),
                    ),
                  ),
                  Obx(
                    () => Visibility(
                      visible: !controller.loading.value,
                      child: Padding(
                        padding: EdgeInsets.only(top: 40.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 10.0),
                              child: SizedBox(
                                width: 100,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () => controller.limpar(),
                                  child: Text(
                                    'LIMPAR',
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10.0),
                              child: SizedBox(
                                width: 100,
                                height: 50,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.blue.shade800)),
                                  onPressed: () => controller.login(),
                                  child: Text('LOGIN'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Obx(
                    () => Visibility(
                      visible: controller.loading.value,
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        width: Get.width * 0.8,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(29),
                          child: FlatButton(
                            padding: EdgeInsets.symmetric(
                              vertical: 20,
                              horizontal: 40,
                            ),
                            onPressed: null,
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
