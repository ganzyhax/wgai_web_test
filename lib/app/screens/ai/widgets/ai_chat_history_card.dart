import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AiChatHistoryCardNew extends StatelessWidget {
  final String title;
  final String date;
  const AiChatHistoryCardNew(
      {super.key, required this.title, required this.date});

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.parse(date);
    final DateFormat formatter = DateFormat('hh:mm a');

    String chatDate = formatter.format(dateTime.toLocal());
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color.fromARGB(255, 228, 227, 227)),
      child: Row(
        children: [
          Image.asset(
            'assets/images/splash_image.png',
            width: 25,
            height: 25,
            fit: BoxFit.contain,
          ),
          SizedBox(
            width: 8,
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width / 2.5,
              child: Text(
                title,
                style: TextStyle(fontWeight: FontWeight.w500),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )),
          Text(
            chatDate,
            style: TextStyle(color: Colors.grey),
          )
        ],
      ),
    );
  }
}
