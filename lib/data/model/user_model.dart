class UserModel {
  int? id;
  String? username;
  int? activated;
  int? guarda_id;
  int? tipoUser;

  UserModel({this.id, this.username, this.activated, this.guarda_id, this.tipoUser});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    activated = json['activated'];
    guarda_id = json['guarda_id'];
    tipoUser = json['tipoUser'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['activated'] = this.activated;
    data['guarda_id'] = this.guarda_id;
    data['tipoUser'] = this.tipoUser;
    return data;
  }
}