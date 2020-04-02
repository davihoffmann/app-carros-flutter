import 'package:carros/pages/carro_form_page.dart';
import 'package:carros/pages/carros_page.dart';
import 'package:carros/pages/drawer_list.dart';
import 'package:carros/pages/favoritos_page.dart';
import 'package:carros/service/carro_service.dart';
import 'package:carros/utils/nav.dart';
import 'package:carros/utils/prefs.dart';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin<HomePage> {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _initTab();
  }

  _initTab() async {
    // Primeiro busca o índice nas prefs.
    int tabIndex = await Prefs.getInt("tabIndex");

    // Depois cria o TabController
    // No método build na primeira vez ele poderá estar nulo
    _tabController = TabController(length: 4, vsync: this);

    // Agora que temos o TabController e o índice da tab,
    // chama o setState para redesenhar a tela
    setState(() {
      _tabController.index = tabIndex;
    });

    _tabController.addListener(() {
      Prefs.setInt("tabIndex", _tabController.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carros'),
        bottom: _tabController == null
            ? null
            : TabBar(
                controller: _tabController,
                tabs: [
                  Tab(
                    text: "Clássicos",
                    icon: Icon(Icons.directions_car),
                  ),
                  Tab(
                    text: "Esportivo",
                    icon: Icon(Icons.directions_car),
                  ),
                  Tab(
                    text: "Luxo",
                    icon: Icon(Icons.directions_car),
                  ),
                  Tab(
                    text: "Favoritos",
                    icon: Icon(Icons.favorite),
                  ),
                ],
              ),
      ),
      body: _tabController == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : TabBarView(controller: _tabController, children: [
              CarrosPage(TipoCarro.CLASSICO),
              CarrosPage(TipoCarro.ESPORTIVO),
              CarrosPage(TipoCarro.LUXO),
              FavoritosPage()
            ]),
      drawer: DrawerList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _onClickAdicionarCarro,
      ),
    );
  }

  void _onClickAdicionarCarro() {
    push(context, CarroFormPage());
  }
}
