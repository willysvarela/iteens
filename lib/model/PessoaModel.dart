import 'dart:convert';

class Pessoa {
  int idpessoa;
  String nome;
  String telefone;
  String status;
  String datanascimento;

  Pessoa({this.idpessoa, this.nome, this.telefone, this.status, this.datanascimento});

  factory Pessoa.fromMap(Map<String, dynamic> json) => new Pessoa(
        idpessoa: json['idpessoa'],
        nome: json['nome'],
        telefone: json['telefone'],
        status: json['status'],
        datanascimento: json['datanascimento'],
      );

  Map<String, dynamic> toMap() => {
        "idpessoa": idpessoa,
        "nome": nome,
        "telefone": telefone,
        "status": status,
        "datanascimento": datanascimento,
      };
}

pessoaFromJson(String str) {
  final jsonData = json.decode(str);
  return Pessoa.fromMap(jsonData);
}

pessoaToJson(Pessoa pessoa) {
  final toJson = pessoa.toMap();
  return json.encode(toJson);
}
