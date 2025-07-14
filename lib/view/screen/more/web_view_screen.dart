import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_app_bar.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_loader.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  final String? title;
  final String? url;
  const WebViewScreen({super.key, required this.url, required this.title});

  @override
  WebViewScreenState createState() => WebViewScreenState();
}

class WebViewScreenState extends State<WebViewScreen> {
  bool _isLoading = true;

  late WebViewController controllerGlobal = WebViewController()
  ..setJavaScriptMode(JavaScriptMode.unrestricted)
  ..setNavigationDelegate(
    NavigationDelegate(
      onPageStarted: (String url) {
        if (kDebugMode) {
          print('Page started loading: $url');
        }
        setState(() {
          _isLoading = true;
        });
      },
      onPageFinished: (String url) {
        if (kDebugMode) {
          print('Page finished loading: $url');
        }
        setState(() {
          _isLoading = false;
        });
      },
    ),
  )
  ..loadRequest(Uri.parse(widget.url ?? ''));

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _exitApp,
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Column(
          children: [

            CustomAppBar(title: widget.title),

            Expanded(
              child: Stack(
                children: [
                  WebViewWidget(controller: controllerGlobal),

                  _isLoading ? CustomLoader(color: Theme.of(context).primaryColor) : const SizedBox.shrink(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _exitApp() async {
    if (await controllerGlobal.canGoBack()) {
      controllerGlobal.goBack();
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }
}
