import 'package:carros/models/usuario.dart';
import 'package:carros/pages/login_page.dart';
import 'package:carros/service/firebase_service.dart';
import 'package:carros/utils/nav.dart';
import 'package:flutter/material.dart';

class DrawerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<Usuario> future = Usuario.get();

    return SafeArea(
      child: Drawer(
        child: ListView(
          children: <Widget>[
            FutureBuilder<Usuario>(
                future: future,
                builder: (context, snapshot) {
                  Usuario usuario = snapshot.data;

                  return usuario != null ? _userHeader(usuario) : Container();
                }),
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

  UserAccountsDrawerHeader _userHeader(Usuario user) {
    return UserAccountsDrawerHeader(
      currentAccountPicture: user.urlFoto != null
          ? CircleAvatar(
              backgroundImage: NetworkImage(user.urlFoto),
            )
          : FlutterLogo(),
      accountName: Text(user.nome ?? ''),
      accountEmail: Text(user.email),
    );
  }

  _onClickLogout(BuildContext context) {
    Usuario.clear();
    FirebaseService().logout();
    Navigator.pop(context);
    push(context, LoginPage(), replace: true);
  }
}
