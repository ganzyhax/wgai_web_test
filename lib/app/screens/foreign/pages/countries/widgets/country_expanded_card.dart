import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class CountryExpandableContainer extends StatefulWidget {
  final Map<String, dynamic> data;

  CountryExpandableContainer({required this.data});

  @override
  _CountryExpandableContainerState createState() =>
      _CountryExpandableContainerState();
}

class _CountryExpandableContainerState
    extends State<CountryExpandableContainer> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    String languageCode =
        context.locale.languageCode; // Get the current language code

    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), // Rounded corners
          color: Colors.white),
      child: Column(
        children: [
          // The clickable header
          InkWell(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded; // Toggle expand/collapse state
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // The title for the expandable container (you can customize it)
                  Text(
                    widget.data['name'][context.locale
                        .languageCode], // General title for the container
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

          // The content that shows all titles and HTML contents of sections
          if (_isExpanded)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widget.data['sections'].map<Widget>((section) {
                  String title = section['title'][languageCode] ?? 'No Title';
                  String content =
                      section['content'][languageCode] ?? 'No Content';

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Display the title with bold font
                        Text(
                          title,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                            height: 8.0), // Spacing between title and content

                        // Render the HTML content
                        Html(
                          data: content,
                        ),
                        Divider(), // Optional: Add a line between sections
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }
}
