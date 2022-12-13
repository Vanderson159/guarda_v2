import 'package:guardaappv2/data/model/user_model.dart';

class AuthModel {
  UserModel? user;
  String? accessToken;
  String? tokenType;
  int? expiresIn;

  AuthModel({this.user, this.accessToken, this.tokenType, this.expiresIn});

  AuthModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    expiresIn = json['expires_in'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['access_token'] = this.accessToken;
    data['token_type'] = this.tokenType;
    data['expires_in'] = this.expiresIn;
    return data;
  }
}