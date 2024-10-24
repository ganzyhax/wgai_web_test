import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:wg_app/app/api/api.dart';
import 'package:wg_app/app/screens/personal_growth/components/personal_growth_quiz_modal.dart';
import 'package:wg_app/app/utils/local_utils.dart';
import 'package:wg_app/app/widgets/buttons/custom_button.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/constants/app_text_style.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:wg_app/generated/locale_keys.g.dart';
import 'package:webview_flutter_web/webview_flutter_web.dart';

class HtmlWebView extends StatefulWidget {
  final String contentCode;
  final bool isUrl;
  final String contentUrl;
  final String contentUrlTitle;
  final String completionStatus;
  final List<Map<String, dynamic>>? quizData;

  HtmlWebView({
    required this.contentCode,
    required this.isUrl,
    required this.contentUrl,
    required this.contentUrlTitle,
    required this.completionStatus,
    this.quizData,
  });

  @override
  _HtmlWebViewState createState() => _HtmlWebViewState();
}

class _HtmlWebViewState extends State<HtmlWebView> {
  late final WebViewController _controller;
  bool isLoading = true;
  String? htmlContent;
  String htmlTitle = "";
  double textScale = 1.0;
  bool isTestFinished = false;

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
            .loadRequest(Uri.parse('${widget.contentUrl}&lang=$localLang'));
        setState(() {
          htmlTitle = widget.contentUrlTitle;
          textScale = _calculateTextScale(htmlTitle);
        });
      } else {
        final data =
            await ApiClient.get('api/contentMaterials/${widget.contentCode}');
        if (data['success']) {
          setState(() {
            htmlContent = data['data']['contentMaterial']['content'][localLang];
            htmlTitle =
                data['data']['contentMaterial']['contentTitle'][localLang];
            textScale = _calculateTextScale(htmlTitle);
          });
          _controller.loadHtmlString(Uri.dataFromString(
            htmlContent!,
            mimeType: 'text/html',
            encoding: Encoding.getByName('utf-8'),
          ).toString());
        }
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      // Handle error appropriately (e.g., show a message)
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(60, 60),
        child: AppBar(
          forceMaterialTransparency: true,
          backgroundColor: AppColors.background,
          leading: IconButton(
            onPressed: _onBackPressed,
            icon: SvgPicture.asset('assets/icons/arrow-left.svg'),
          ),
          title: Text(
            htmlTitle,
            style: AppTextStyle.titleHeading
                .copyWith(color: AppColors.blackForText),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
        ),
      ),
      backgroundColor: AppColors.whiteForText,
      body: Padding(
        padding: EdgeInsets.zero,
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : _buildWebView(),
      ),
    );
  }

  Widget _buildWebView() {
    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              child: WebViewWidget(controller: _controller),
            ),
            SizedBox(height: 16),
          ],
        ),
        if (widget.quizData != null && widget.quizData!.isNotEmpty)
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 1.2,
                child: CustomButton(
                  text: LocaleKeys.mini_test.tr(),
                  onTap: _showQuizModal,
                ),
              ),
            ),
          ),
      ],
    );
  }

  void _showQuizModal() async {
    final res = await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return PersonalGrowthQuizModal(quizData: widget.quizData!);
      },
    );
    if (res != null && res) {
      setState(() {
        isTestFinished = true;
      });
    }
  }

  void _onBackPressed() {
    if (widget.quizData != null && widget.quizData!.isNotEmpty) {
      if (widget.completionStatus == "complete" || isTestFinished) {
        Navigator.of(context).pop(true);
      } else {
        _showTestDialog(context);
      }
    } else {
      Navigator.of(context).pop();
    }
  }

  double _calculateTextScale(String title) {
    const double maxScale = 1.0;
    const double minScale = 0.5;
    const int targetLength = 20;

    if (title.isEmpty) return maxScale;

    double scale = targetLength / max(title.length, 20);
    return scale.clamp(minScale, maxScale);
  }

  void _showTestDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Text(
            LocaleKeys.you_must_pass_the_test.tr(),
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: CustomButton(
                  height: 45,
                  bgColor: Colors.grey[400],
                  text: LocaleKeys.cancel.tr(),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: CustomButton(
                  height: 45,
                  text: LocaleKeys.start.tr(),
                  onTap: () async {
                    Navigator.pop(context);
                    final res = await showModalBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      builder: (context) {
                        return PersonalGrowthQuizModal(
                            quizData: widget.quizData!);
                      },
                    );
                    if (res != null && res) {
                      setState(() {
                        isTestFinished = true;
                      });
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
