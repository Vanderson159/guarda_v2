class GuardaModel {
  int? id;
  String? nome;
  String? email;
  int? activated;

  GuardaModel({this.id, this.nome, this.email, this.activated});

  GuardaModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    email = json['email'];
    activated = json['activated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    data['email'] = this.email;
    data['activated'] = this.activated;
    return data;
  }
}