import 'dart:convert';

import 'package:carros/models/entity.dart';
import 'package:carros/utils/event_bus.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CarroEvent extends Event {
  // salvar, deletar
  final String acao;

  // classico, esportivo, luxo
  final String tipo;

  CarroEvent(this.acao, this.tipo);

  @override
  String toString() {
    return "CarroEvent(acao: $acao, tipo: $tipo)";
  }
}

class Carro extends Entity {
  int id;
  String nome;
  String tipo;
  String descricao;
  String urlFoto;
  String urlVideo;
  String latitude;
  String longitude;

  Carro(
      {this.id,
      this.nome,
      this.tipo,
      this.descricao,
      this.urlFoto,
      this.urlVideo,
      this.latitude,
      this.longitude});

  latLng() {
    return LatLng(
      latitude == null || latitude.isEmpty ? 0.0 : double.parse(latitude), 
      longitude == null || longitude.isEmpty ? 0.0 : double.parse(longitude)
    );
  }

  Carro.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    nome = map['nome'];
    tipo = map['tipo'];
    descricao = map['descricao'];
    urlFoto = map['urlFoto'];
    urlVideo = map['urlVideo'];
    latitude = map['latitude'];
    longitude = map['longitude'];
  }

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    data['tipo'] = this.tipo;
    data['descricao'] = this.descricao;
    data['urlFoto'] = this.urlFoto;
    data['urlVideo'] = this.urlVideo;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }

  String toJson() {
    String jsonCarro = json.encode(toMap());
    return jsonCarro;
  }

  @override
  String toString() {
    return "Carri(id: $id, nome: $nome, tipo: $tipo, descricao: $descricao, urlFoto: $urlFoto, urlVideo: $urlVideo, latitude: $latitude, longitude: $longitude)";
  }

}
