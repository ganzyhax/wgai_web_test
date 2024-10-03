import 'package:flutter/material.dart';

class BasicExpandableContainer extends StatefulWidget {
  final String title;
  final String content;

  BasicExpandableContainer({required this.title, required this.content});

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
              child: Text(
                widget.content,
                style: TextStyle(fontSize: 16),
              ),
            ),
        ],
      ),
    );
  }
}
