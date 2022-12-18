import 'package:guardaappv2/data/model/auth_model.dart';
import 'package:guardaappv2/data/provider/auth_provider.dart';
import 'package:guardaappv2/modules/login/login_controller.dart';


class AuthRepository{
  final AuthApiClient apiClient = AuthApiClient();
  Future<AuthModel> login(String username, String password) async {
    return AuthModel.fromJson(await apiClient.login(username, password));
  }
}