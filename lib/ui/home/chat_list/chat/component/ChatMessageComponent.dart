import 'package:chat/AppColors.dart';
import 'package:chat/data/model/ChatMessage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ChatProfileImage.dart';

class ChatMessageComponent extends StatelessWidget {
  late ChatMessage chatMessage;
  bool isChatWithChatGPT;

  ChatMessageComponent({ super.key, required this.chatMessage, required this.isChatWithChatGPT });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: chatMessage.isSender
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!chatMessage.isSender) const SizedBox(width: 10),
        if (!chatMessage.isSender)
          ChatProfileImage(chatMessage: chatMessage, width: 36, height: 36, isChatWithChatGPT: isChatWithChatGPT),
        Flexible(
            child: Column(
          crossAxisAlignment: chatMessage.isSender
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.end,
          children: [
            _chatBubble(chatMessage, context),
            const SizedBox(height: 5),
            _chatTime(chatMessage),
          ],
        ))
      ],
    );
  }

  Widget _chatTime(ChatMessage chatMessage) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(chatMessage.timestamp);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Text(
        '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}',
        style: const TextStyle(
          fontSize: 9,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }

  Widget _chatBubble(ChatMessage chatMessage, BuildContext context) {
    return Container(
      constraints:
      BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.65),
      decoration: BoxDecoration(
        color: chatMessage.isSender
            ? AppColors.color_FFFFE10C
            : AppColors.color_FFFFFFFF,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Text(
        chatMessage.message,
        style: const TextStyle(
          color: AppColors.color_FF000000,
          fontSize: 14,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}