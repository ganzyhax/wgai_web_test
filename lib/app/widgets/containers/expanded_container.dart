import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/constants/app_text_style.dart';

class ExpandedContainer extends StatefulWidget {
  final String title;
  final IconData? icon;
  final Function() onTap;
  final Color? color;
  final List<dynamic> items;
  final Function(dynamic) onItemSelected;

  const ExpandedContainer({
    super.key,
    this.icon,
    required this.title,
    required this.onTap,
    this.color = AppColors.filterGray,
    required this.items,
    required this.onItemSelected,
  });

  @override
  _ExpandedContainerState createState() => _ExpandedContainerState();
}

class _ExpandedContainerState extends State<ExpandedContainer> {
  bool _isExpanded = false;

  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            widget.onTap();
            _toggleExpansion();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: widget.color,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  style: AppTextStyle.bodyText.copyWith(color: Colors.black),
                ),
                SvgPicture.asset('assets/icons/caret-down.svg'),
              ],
            ),
          ),
        ),
        if (_isExpanded)
          ConstrainedBox(
            constraints: BoxConstraints(
                maxHeight: 200.0,
                maxWidth: MediaQuery.of(context).size.width * 0.6),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widget.items.map((item) {
                  return ListTile(
                    title: Text(item),
                    onTap: () {
                      widget.onItemSelected(item);
                      _toggleExpansion();
                    },
                  );
                }).toList(),
              ),
            ),
          ),
      ],
    );
  }
}
