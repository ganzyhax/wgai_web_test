import 'package:flutter/material.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/constants/app_text_style.dart';

class GrowthTestCard extends StatefulWidget {
  final String title;
  final String subTitle;
  final String fullContent;

  const GrowthTestCard({
    Key? key,
    required this.subTitle,
    required this.title,
    required this.fullContent,
  }) : super(key: key);

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
    return Container(
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
                        Icon(
                          Icons.star,
                          size: 30,
                          color: AppColors.primary,
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
                    Text(
                      widget.subTitle,
                      style: TextStyle(fontSize: 15, color: Colors.grey[400]),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: _toggleExpanded,
                child: Icon(
                  _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
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
    );
  }
}