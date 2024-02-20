import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';
import 'package:task2/chat_list.dart';
import 'package:task2/info.dart';

import 'colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runZonedGuarded(() async {
    await SendbirdChat.init(appId: 'BC823AD1-FBEA-4F08-8F41-CF0D9D280FBF');
    await SendbirdChat.connect(
        'sendbird_open_channel_14092_bf4075fbb8f12dc0df3ccc5c653f027186ac9211',
        accessToken: "f93b05ff359245af400aa805bafd2a091a173064",
        apiHost: "api-BC823AD1-FBEA-4F08-8F41-CF0D9D280FBF.sendbird.com");
    final openChannel = await OpenChannel.getChannel(
        "api-BC823AD1-FBEA-4F08-8F41-CF0D9D280FBF.sendbird.com");

    await openChannel.enter();
    openChannel
        .sendUserMessage(UserMessageCreateParams(message: 'hello there'));
    runApp(MyApp(
      openChannel: openChannel,
    ));
  }, (e, s) {
    throw e;
  });
}

class MyApp extends StatelessWidget {
  final OpenChannel openChannel;
  const MyApp({super.key, required this.openChannel});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backgroundColor,
      ),
      home: MobileChatScreen(
        openChannel: openChannel,
      ),
    );
  }
}

class MobileChatScreen extends StatefulWidget {
  final OpenChannel openChannel;
  const MobileChatScreen({super.key, required this.openChannel});

  @override
  State<MobileChatScreen> createState() => _MobileChatScreenState();
}

class _MobileChatScreenState extends State<MobileChatScreen> {
  final TextEditingController _textController = TextEditingController();
  void initState() {
    super.initState();
    _loadPreviousMessages();
  }

  Future<void> _loadPreviousMessages() async {
    final messages = await widget.openChannel.getMessagesByTimestamp(
      DateTime.now().millisecondsSinceEpoch,
      MessageListParams(),
    );
  }

  void _sendMessage() async {
    try {
      final messageText = _textController.text;
      if (messageText.isNotEmpty) {
        final UserMessage userMessage = widget.openChannel
            .sendUserMessage(UserMessageCreateParams(message: messageText));
        _textController.clear();
      }
    } catch (e) {
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back_ios),
        ),
        backgroundColor: backgroundColor,
        title: Text(
          info[0]['name'].toString(),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Column(
        children: [
          const Expanded(
            child: ChatList(),
          ),
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Icon(
                  Icons.add,
                  color: Colors.grey,
                ),
              ),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: mobileChatBoxColor,
                    suffixIcon: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Icon(
                        Icons.arrow_circle_up,
                        color: Colors.grey,
                      ),
                    ),
                    hintText: '메시지를 입력하세요!',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    contentPadding: const EdgeInsets.all(10),
                  ),
                  onSubmitted: (value) {
                    _sendMessage();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
