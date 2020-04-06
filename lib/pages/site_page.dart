import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SitePage extends StatefulWidget {
  @override
  _SitePageState createState() => _SitePageState();
}

class _SitePageState extends State<SitePage> {
  WebViewController controller;
  var _stackIndex = 1;
  var _showProgress = true;
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Site"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh), onPressed: _onClickRefresh)
        ],
      ),
      body: _webView(),
    );
  }

  _webView() {
    return IndexedStack(index: _stackIndex, children: <Widget>[
      Column(
        children: <Widget>[
          Expanded(
            child: WebView(
              initialUrl: "https://unidavi.edu.br/",
              onWebViewCreated: (controller) {
                this.controller = controller;
              },
              javascriptMode: JavascriptMode.unrestricted,
              navigationDelegate: _onRequest,
              onPageFinished: _onPageFinished,
            ),
          )
        ],
      ),
      Container(
        color: Colors.white,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      Opacity(
        opacity: _showProgress ? 1 : 0,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      )
    ]);
  }

  void _onClickRefresh() {
    this.controller.reload();
  }

  FutureOr<NavigationDecision> _onRequest(NavigationRequest navigation) {
    print(navigation.url);

    return NavigationDecision.navigate;
  }

  void _onPageFinished(String url) {
    setState(() {
      _stackIndex = 0;
      _showProgress = false;
    });
  }
}
