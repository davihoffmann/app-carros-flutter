import 'package:carros/pages/login_page.dart';
import 'package:carros/utils/nav.dart';
import 'package:flutter/material.dart';

class DrawerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://avatars0.githubusercontent.com/u/5316112?s=460&u=99fadd40fba9d24786f9fc5682eeb267e3827350&v=4"),
              ),
              accountName: Text("Davi Prada Hoffmann"),
              accountEmail: Text("davi.phoffmann@gmail.com"),
            ),
            ListTile(
              leading: Icon(Icons.star),
              title: Text('Favoritos'),
              subtitle: Text('mais informaçoes...'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text('Ajuda'),
              subtitle: Text('mais informaçoes...'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Logout'),
              subtitle: Text('Desconectar...'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () => _onClickLogout(context),
            )
          ],
        ),
      ),
    );
  }

  _onClickLogout(BuildContext context) {
    Navigator.pop(context);
    push(context, LoginPage(), replace: true);
  }
}
