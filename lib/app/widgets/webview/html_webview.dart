import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:wg_app/app/api/api.dart';
import 'package:wg_app/app/utils/local_utils.dart';

class HtmlWebView extends StatefulWidget {
  final String contentCode;

  HtmlWebView({required this.contentCode});

  @override
  _HtmlWebViewState createState() => _HtmlWebViewState();
}

class _HtmlWebViewState extends State<HtmlWebView> {
  late final WebViewController _controller;
  bool isLoading = true;
  String? htmlContent;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (String url) {
            setState(() {
              isLoading = false;
            });
          },
        ),
      );

    _loadContent();
  }

  Future<void> _loadContent() async {
    String localLang = await LocalUtils.getLanguage();
    try {
      var data =
          await ApiClient.get('api/contentMaterials/${widget.contentCode}');

      setState(() {
        if (data['success']) {
          htmlContent = data['data']['contentMaterial']['content'][localLang];
        }
      });
      _controller.loadHtmlString(htmlContent!);
    } catch (e) {
      // Handle errors, e.g., show an error message
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          if (htmlContent != null)
            SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: WebViewWidget(controller: _controller)),
          if (isLoading)
            Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
