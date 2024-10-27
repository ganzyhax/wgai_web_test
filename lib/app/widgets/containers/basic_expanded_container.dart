import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class BasicExpandableContainer extends StatefulWidget {
  final String title;
  final String content;
  final bool? isHtmlContent;

  BasicExpandableContainer(
      {required this.title, required this.content, this.isHtmlContent = false});

  @override
  _BasicExpandableContainerState createState() =>
      _BasicExpandableContainerState();
}

class _BasicExpandableContainerState extends State<BasicExpandableContainer> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15), // Circular border radius
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Icon(
                    _isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ),
          if (_isExpanded)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: (widget.isHtmlContent == true)
                  ? Html(data: widget.content)
                  : Text(
                      widget.content,
                      style: TextStyle(fontSize: 16),
                    ),
            ),
        ],
      ),
    );
  }
}
