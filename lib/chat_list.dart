import 'package:flutter/material.dart';
import 'package:task2/info.dart';
import 'package:task2/my_message.dart';
import 'package:task2/sender_message.dart';


class ChatList extends StatelessWidget {
  const ChatList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: messages.length,
      itemBuilder: (context, index) {
        if (messages[index]['isMe'] == true) {
          return MyMessageCard(
            message: messages[index]['text'].toString(),
            date: messages[index]['time'].toString(),
          );
        }
        return SenderMessageCard(
          profilePic: info[index]['profilePic'].toString(),
          message: messages[index]['text'].toString(),
          date: messages[index]['time'].toString(),
        );
      },
    );
  }
}