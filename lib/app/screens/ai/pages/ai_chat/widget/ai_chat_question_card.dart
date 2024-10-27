import 'package:flutter/material.dart';

class AiChatQuestionCard extends StatelessWidget {
  final String text;
  const AiChatQuestionCard({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: Color(0xFFEFEFF3)),
      child: Text(
        text,
        style: TextStyle(color: Colors.black45, fontSize: 18),
      ),
    );
  }
}
