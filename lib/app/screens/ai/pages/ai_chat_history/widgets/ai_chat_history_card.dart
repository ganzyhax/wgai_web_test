import 'package:flutter/material.dart';

class AiChatHistoryCard extends StatelessWidget {
  final String title;
  final String? message;
  final int? unreadedMessageCount;
  const AiChatHistoryCard(
      {super.key,
      required this.title,
      this.message,
      this.unreadedMessageCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Color(0xFFE9E9EF),
      ),
      child: Row(
        children: [
          Image.asset(
            'assets/images/splash_image.png',
            width: 35,
            height: 35,
            fit: BoxFit.contain,
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.65,
                    child: Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text('10:32am',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[400]))
                ],
              ),
              SizedBox(height: 10),
              (message == null)
                  ? Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            40,
                          ),
                          color: Colors.grey),
                      padding: EdgeInsets.only(
                          top: 2, bottom: 2, left: 10, right: 10),
                      child: Center(
                          child: Text('Ended',
                              style: TextStyle(color: Colors.white))),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 1.5,
                          child: Text(
                            message!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        (unreadedMessageCount != null)
                            ? Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      40,
                                    ),
                                    color: Colors.red),
                                padding: EdgeInsets.only(
                                    top: 2, bottom: 2, left: 10, right: 10),
                                child: Center(
                                    child: Text(
                                        '+' + unreadedMessageCount.toString(),
                                        style: TextStyle(color: Colors.white))),
                              )
                            : SizedBox()
                      ],
                    ),
            ],
          )
        ],
      ),
    );
  }
}
