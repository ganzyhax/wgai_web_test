import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wg_app/app/widgets/buttons/custom_button.dart';
import 'package:wg_app/constants/app_colors.dart';
import 'package:wg_app/generated/locale_keys.g.dart';

class AiChatBuildCard extends StatefulWidget {
  final List<dynamic> messages;
  final bool isLoading;

  const AiChatBuildCard({
    super.key,
    required this.messages,
    required this.isLoading,
  });

  @override
  _AiChatBuildCardState createState() => _AiChatBuildCardState();
}

class _AiChatBuildCardState extends State<AiChatBuildCard> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
  }

  @override
  void didUpdateWidget(covariant AiChatBuildCard oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Scroll when messages are added or loading state changes
    if (widget.messages.length > oldWidget.messages.length ||
        widget.isLoading != oldWidget.isLoading) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
    }
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      Future.delayed(Duration(milliseconds: 300), () {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeOut,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var filteredMessages = widget.messages
        .where((message) => message['role'] != 'system')
        .toList();

    return Container(
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
        controller: _scrollController,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        itemCount: filteredMessages.length + (widget.isLoading ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == filteredMessages.length && widget.isLoading) {
            return _buildLoadingIndicator();
          }

          final message = filteredMessages[index];
          final isBot = message['role'] == 'assistant';

          return _buildMessageBubble(context, message, isBot, index);
        },
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: AppColors.whiteForText,
          borderRadius: BorderRadius.circular(12),
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
            Text(
              LocaleKeys.thinking.tr() + '...',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageBubble(
      BuildContext context, dynamic message, bool isBot, int index) {
    return Align(
      alignment: isBot ? Alignment.centerLeft : Alignment.centerRight,
      child: Column(
        crossAxisAlignment:
            isBot ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment:
                isBot ? MainAxisAlignment.start : MainAxisAlignment.end,
            children: isBot
                ? [
                    Image.asset(
                      'assets/images/splash_image.png',
                      width: 35,
                      height: 35,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(width: 5),
                    Text('WEGLOBAL.AI')
                  ]
                : [
                    CircleAvatar(
                      radius: 16,
                      backgroundImage: NetworkImage(
                        'https://i.pinimg.com/736x/61/f7/5e/61f75ea9a680def2ed1c6929fe75aeee.jpg',
                      ),
                    ),
                    SizedBox(width: 5),
                    Text(LocaleKeys.you.tr())
                  ],
          ),
          SizedBox(height: 10),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            padding: EdgeInsets.all(15),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 1,
            ),
            decoration: BoxDecoration(
              color: isBot ? AppColors.primary : Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment:
                  isBot ? CrossAxisAlignment.start : CrossAxisAlignment.end,
              children: [
                Text(
                  message['content'],
                  style: TextStyle(
                    color: isBot ? Colors.white : Colors.black,
                    fontSize: 16,
                  ),
                ),
                if (isBot && index == widget.messages.length - 1)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      CustomButton(
                        text: 'Я не удовлетворен консультацией',
                        onTap: () {},
                        bgColor: Colors.white.withOpacity(0.4),
                      ),
                      SizedBox(height: 8),
                      CustomButton(
                        text: 'Закончить Чат',
                        onTap: () {},
                        textColor: AppColors.primary,
                        bgColor: Colors.white,
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
