import 'package:carros/drawer_list.dart';
import 'package:carros/pages/carros_list.dart';
import 'package:carros/service/carro_service.dart';
import 'package:carros/utils/prefs.dart';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin<HomePage> {

  TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 3, vsync: this);

    Prefs.getInt("tabIndex").then((int tabIndex) {
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
        bottom: TabBar(
          controller: _tabController,
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
      body: TabBarView(
        controller: _tabController,
        children: [
        CarrosList(TipoCarro.CLASSICO),
        CarrosList(TipoCarro.ESPORTIVO),
        CarrosList(TipoCarro.LUXO)
      ]),
      drawer: DrawerList(),
    );
  }
}
