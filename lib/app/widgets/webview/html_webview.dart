import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:wg_app/app/api/api.dart';
import 'package:wg_app/app/utils/local_utils.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/constants/app_text_style.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

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
  String htmlTitle = "";

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
          htmlTitle = data['data']['contentMaterial']['contentTitle'][localLang];
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
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Text(
          htmlTitle,
          style:
              AppTextStyle.titleHeading.copyWith(color: AppColors.blackForText),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset('assets/icons/arrow-left.svg'),
        ),
      ),
      backgroundColor: AppColors.whiteForText,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: htmlContent != null
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
}
