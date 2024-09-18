import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:wg_app/app/api/api.dart';
import 'package:wg_app/app/utils/local_utils.dart';
import 'package:wg_app/app/widgets/appbar/custom_appbar.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/constants/app_text_style.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math';
import 'package:easy_localization/easy_localization.dart';

class HtmlWebView extends StatefulWidget {
  final String contentCode;
  final bool isUrl;
  final String contentUrl;
  final String contentUrlTitle;

  HtmlWebView(
      {required this.contentCode,
      required this.isUrl,
      required this.contentUrl,
      required this.contentUrlTitle});

  @override
  _HtmlWebViewState createState() => _HtmlWebViewState();
}

class _HtmlWebViewState extends State<HtmlWebView> {
  late final WebViewController _controller;
  bool isLoading = true;
  String? htmlContent;
  String htmlTitle = "";
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

    _loadContent();
  }

  Future<void> _loadContent() async {
    String localLang = await LocalUtils.getLanguage();
    try {
      if (widget.isUrl) {
        await _controller
            .loadRequest(Uri.parse(widget.contentUrl + "&lang=" + localLang));
        setState(() {
          htmlTitle = widget.contentUrlTitle;
          textScale = calculateTextScale(htmlTitle);
        });
      } else {
        var data =
            await ApiClient.get('api/contentMaterials/${widget.contentCode}');
        setState(() {
          if (data['success']) {
            htmlContent = data['data']['contentMaterial']['content'][localLang];
            htmlTitle =
                data['data']['contentMaterial']['contentTitle'][localLang];
            textScale = calculateTextScale(htmlTitle);
          }
        });
        _controller.loadHtmlString(htmlContent!);
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(60, 60),
          child: CustomAppbar(title: htmlTitle, withBackButton: true)),
      backgroundColor: AppColors.whiteForText,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0),
        child: isLoading == false
            ? Column(
                children: [
                  Expanded(
                    child: WebViewWidget(controller: _controller),
                  ),
                  SizedBox(height: 16), // This adds 16px space at the bottom
                ],
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
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
