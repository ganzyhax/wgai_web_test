import 'dart:math';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/constants/app_text_style.dart';

class WebViewHtml extends StatefulWidget {
  final String contentTitle; // String for the title
  final String content; // HTML string for the content

  WebViewHtml({
    required this.contentTitle,
    required this.content,
  });

  @override
  _WebViewHtmlState createState() => _WebViewHtmlState();
}

class _WebViewHtmlState extends State<WebViewHtml> {
  late final WebViewController _controller;
  bool isLoading = true;
  double textScale = 1.0;

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

    // Load the HTML string content into the WebView
    _loadContent();
  }

  Future<void> _loadContent() async {
    setState(() {
      isLoading = true;
      textScale = calculateTextScale(
          widget.contentTitle); // Update the text scale based on the title
    });

    _controller.loadHtmlString(widget.content); // Load HTML content as a string
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back, color: AppColors.blackForText),
        ),
        title: Text(
          widget.contentTitle,
          style:
              AppTextStyle.titleHeading.copyWith(color: AppColors.blackForText),
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          textAlign: TextAlign.center,
          textScaler: TextScaler.linear(1), // Ensures proper scaling
        ),
      ),
      backgroundColor: AppColors.background,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0),
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : WebViewWidget(controller: _controller),
      ),
    );
  }

  double calculateTextScale(String title) {
    const double maxScale = 1.0;
    const double minScale = 0.5;
    const int targetLength = 20;

    if (title.isEmpty) return maxScale;

    double scale = targetLength / max(title.length, 20);
    return scale.clamp(minScale, maxScale);
  }
}
