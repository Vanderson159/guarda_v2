class OcorrenciaModel {
  int? id;
  String? dataHora;
  String? boletimAtendimento;
  String? boletimOcorrencia;
  String? endereco;
  String? local;
  String? fatos;
  String? orientacaoGuarda;
  int? arquivado;
  String? qrcode;
  int? guardaId;
  String? nomeImg;
  String? base64img;

  OcorrenciaModel(
  this.id,
        this.dataHora,
        this.boletimAtendimento,
        this.boletimOcorrencia,
        this.endereco,
        this.local,
        this.fatos,
        this.orientacaoGuarda,{
        this.arquivado,
        this.qrcode,
        this.guardaId});

  OcorrenciaModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dataHora = json['dataHora'];
    boletimAtendimento = json['boletimAtendimento'];
    boletimOcorrencia = json['boletimOcorrencia'];
    endereco = json['endereco'];
    local = json['local'];
    fatos = json['fatos'];
    orientacaoGuarda = json['orientacaoGuarda'];
    arquivado = json['arquivado'];
    qrcode = json['qrcode'];
    guardaId = json['guarda_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['dataHora'] = this.dataHora;
    data['boletimAtendimento'] = this.boletimAtendimento;
    data['boletimOcorrencia'] = this.boletimOcorrencia;
    data['endereco'] = this.endereco;
    data['local'] = this.local;
    data['fatos'] = this.fatos;
    data['orientacaoGuarda'] = this.orientacaoGuarda;
    data['arquivado'] = this.arquivado;
    data['qrcode'] = this.qrcode;
    data['guarda_id'] = this.guardaId;
    return data;
  }

  static OcorrenciaModel tempOcorrencia(){
    OcorrenciaModel x = OcorrenciaModel(0, '', '', '', '', '', '', '');
    return x;
  }

  String toString(){
    return 'BO${this.id}';
  }
}