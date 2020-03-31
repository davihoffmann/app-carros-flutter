import 'package:carros/models/carro.dart';
import 'package:carros/models/entity.dart';

class Favorito extends Entity {
  
  int id;
  String nome;

  Favorito.fromCarro(Carro carro) {
    this.id = carro.id;
    this.nome = carro.nome;
  }
  
  Favorito.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    nome = map['nome'];
  }

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;

    return data;
  }

}