import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:wg_app/app/widgets/webview/html_webview.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/constants/app_icons.dart';
import 'package:wg_app/constants/app_text_style.dart';

class GrowthTestCard extends StatefulWidget {
  final String title;
  final String subTitle;
  final String icon;
  final String fullContent;
  final String interpretationLink;

  const GrowthTestCard(
      {Key? key,
      required this.icon,
      required this.subTitle,
      required this.title,
      required this.fullContent,
      required this.interpretationLink})
      : super(key: key);

  @override
  _GrowthTestCardState createState() => _GrowthTestCardState();
}

class _GrowthTestCardState extends State<GrowthTestCard> {
  bool _isExpanded = false;

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    final IconData? resolvedIcon = myIconMap[widget.icon];

    return GestureDetector(
      onTap: () {
        if (widget.interpretationLink != '') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HtmlWebView(
                contentCode: widget.interpretationLink,
                isUrl: true,
                contentUrl: widget.interpretationLink,
                contentUrlTitle: widget.title,
                completionStatus: "complete"
              ),
            ),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          if (resolvedIcon != null)
                            PhosphorIcon(
                              resolvedIcon,
                              color: AppColors.primary,
                              size: 28,
                            ),
                          SizedBox(width: 5),
                          Expanded(
                            child: Text(
                              widget.title,
                              style: AppTextStyle.heading2,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      (widget.subTitle != '')
                          ? (_isExpanded != true)
                              ? Text(
                                  widget.subTitle,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.grey[400]),
                                )
                              : SizedBox()
                          : SizedBox()
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: _toggleExpanded,
                  child: Icon(
                    _isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                  ),
                ),
              ],
            ),
            if (_isExpanded) ...[
              SizedBox(height: 10),
              Text(
                widget.fullContent,
                style: TextStyle(fontSize: 14),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
