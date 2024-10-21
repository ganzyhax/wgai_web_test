import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wg_app/app/widgets/webview/html_loader.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:wg_app/app/widgets/webview/html_webview.dart';

class PersonalGrowthCard extends StatelessWidget {
  final bool? isFinished;
  final String title;
  final String subTitle;
  final int type;
  final Function() onTap;
  final bool? isTesting;
  final String? interpretationLink;
  const PersonalGrowthCard(
      {Key? key,
      this.isFinished = false,
      required this.type,
      required this.onTap,
      required this.subTitle,
      required this.title,
      this.isTesting = false,
      this.interpretationLink})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.transparent,
        ),
        child: Row(
          crossAxisAlignment:
              CrossAxisAlignment.center, // Center the row's children
          children: [
            Image.asset(
              (type == 1)
                  ? 'assets/images/personal_frame_1.png'
                  : (type == 2)
                      ? 'assets/images/personal_frame_2.png'
                      : 'assets/images/personal_frame_3.png',
              width: 80,
              height: (type == 2) ? 120 : 80,
            ),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Center the column's content
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 16),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    subTitle,
                    style: TextStyle(color: Colors.grey[500], fontSize: 15),
                  ),
                ],
              ),
            ),
            if (isFinished == true && isTesting == true)
              GestureDetector(
                onTap: () {
                  (!kIsWeb)
                      ? Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HtmlWebView(
                                contentCode: "",
                                isUrl: true,
                                contentUrl: interpretationLink!,
                                contentUrlTitle: "",
                                completionStatus: "complete"),
                          ),
                        )
                      : Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HtmlLoader(
                                contentCode: "",
                                isUrl: true,
                                contentUrl: interpretationLink!,
                                contentUrlTitle: "",
                                completionStatus: "complete"),
                          ),
                        );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Text(
                    (interpretationLink != null)
                        ? LocaleKeys.personalGrowthResultsButton.tr()
                        : LocaleKeys.in_progress_check.tr(),
                    style: TextStyle(fontSize: 14),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color(0xFFE5E5EA),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
