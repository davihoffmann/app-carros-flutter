import 'package:carros/drawer_list.dart';
import 'package:carros/pages/carros_list.dart';
import 'package:carros/service/carro_service.dart';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Carros'),
          bottom: TabBar(
            tabs: [
              Tab(
                text: "Clássicos",
              ),
              Tab(
                text: "Esportivo",
              ),
              Tab(
                text: "Luxo",
              ),
            ],
          ),
        ),
        body: TabBarView(children: [
          CarrosList(TipoCarro.CLASSICO),
          CarrosList(TipoCarro.ESPORTIVO),
          CarrosList(TipoCarro.LUXO)
        ]),
        drawer: DrawerList(),
      ),
    );
  }
}
