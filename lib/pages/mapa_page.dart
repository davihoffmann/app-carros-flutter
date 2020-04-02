import 'package:carros/models/carro.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapaPage extends StatelessWidget {
  final Carro carro;

  MapaPage(this.carro);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(carro.nome),
      ),
      body: _body(),
    );
  }

  _body() {
    return Container(
      child: GoogleMap(
        mapType: MapType.satellite,
        initialCameraPosition: CameraPosition(
          target: latLng(),
          zoom: 17,
        ),
        markers: Set.of(_getMarkers()),
      ),
    );
  }

  latLng() {
    return carro.latLng();
  }

  List<Marker> _getMarkers() {
    return [
      Marker(
          markerId: MarkerId("1"),
          position: carro.latLng(),
          infoWindow: InfoWindow(
            title: carro.nome,
            snippet: "Fabrica da ${carro.nome}",
            onTap: () {
              print("clicou na janela");
            },
          ),
          onTap: () {
            print("clicou no marcador");
          })
    ];
  }
}
