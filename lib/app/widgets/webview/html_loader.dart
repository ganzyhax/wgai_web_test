import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wg_app/app/api/api.dart';
import 'package:wg_app/app/screens/personal_growth/components/personal_growth_quiz_modal.dart';
import 'package:wg_app/app/utils/local_utils.dart';
import 'package:wg_app/app/widgets/buttons/custom_button.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/constants/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:wg_app/generated/locale_keys.g.dart';
import 'package:flutter_html/flutter_html.dart'; // New package import
import 'package:http/http.dart' as http;
import 'dart:convert';

class HtmlLoader extends StatefulWidget {
  final String contentCode;
  final bool isUrl;
  final String contentUrl;
  final String contentUrlTitle;
  final String completionStatus;
  final List<Map<String, dynamic>>? quizData;

  const HtmlLoader({
    super.key,
    required this.contentCode,
    required this.isUrl,
    required this.contentUrl,
    required this.contentUrlTitle,
    required this.completionStatus,
    this.quizData,
  });

  @override
  _HtmlLoaderState createState() => _HtmlLoaderState();
}

class _HtmlLoaderState extends State<HtmlLoader> {
  bool isLoading = true;
  String? htmlContent;
  String htmlTitle = "";
  bool isTestFinished = false;
  String style = '';

  @override
  void initState() {
    super.initState();

    _loadContent();
  }

  Future<void> _loadContent() async {
    String localLang = await LocalUtils.getLanguage();
    try {
      if (widget.isUrl) {
        // Fetch the HTML content from the URL
        final response = await ApiClient.get(widget.contentUrl);

        // Fetch the external CSS file
        final cssResponse = await ApiClient.get(
            'https://v2.api.weglobal.ai/api/cognition/styles.css');
        log(cssResponse['data']);
        // Append the CSS content to the HTML inside a <style> tag
        setState(() {
          htmlContent = """
          <html>
            <head>
              <meta charset="UTF-8">
              <meta content="width=device-width,initial-scale=1" name="viewport">
              <style>
                ${cssResponse.toString()}  // Appending the CSS content
              </style>
            </head>
            <body>
              ${response.toString()}
            </body>
          </html>
        """;
          htmlTitle = widget.contentUrlTitle;
          isLoading = false;
        });
      } else {
        final data =
            await ApiClient.get('api/contentMaterials/${widget.contentCode}');

        if (data['success']) {
          // Success: parse the JSON data

          setState(() {
            htmlContent = """
            <html>
              <head>
                <meta charset="UTF-8">
                <meta content="width=device-width,initial-scale=1" name="viewport">
                
              </head>
              <body>
                ${data['data']['contentMaterial']['content'][localLang]}
              </body>
            </html>
          """;

            htmlTitle =
                data['data']['contentMaterial']['contentTitle'][localLang];
            isLoading = false;
          });
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
      appBar: AppBar(
        backgroundColor: AppColors.background,
        leading: IconButton(
          onPressed: _onBackPressed,
          icon: SvgPicture.asset('assets/icons/arrow-left.svg'),
        ),
        title: Text(
          htmlTitle,
          style:
              AppTextStyle.titleHeading.copyWith(color: AppColors.blackForText),
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          textAlign: TextAlign.center,
        ),
      ),
      backgroundColor: AppColors.whiteForText,
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : _buildHtmlContent(),
    );
  }

  Widget _buildHtmlContent() {
    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Html(
                  data: htmlContent ?? 'Failed to load content.',
                  style: {
                    "body": Style(
                      fontSize: FontSize(16), // Set a default font size
                      fontFamily: 'Inter', // Use the Inter font
                      color: Colors.black,
                    ),
                    ".chapter-subtitle": Style(
                      margin: Margins(bottom: Margin(12), top: Margin(12)),
                      fontWeight: FontWeight.bold,
                      fontSize: FontSize(18),
                      color: Colors.black, // Subtitle color
                    ),
                    ".chapter-description": Style(
                      margin: Margins(
                          bottom: Margin(16)), // Margin for descriptions
                    ),
                    ".image-section": Style(
                        alignment: Alignment.center,
                        border: Border(bottom: BorderSide())),
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
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
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
