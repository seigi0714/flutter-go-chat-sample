import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:helloworld/entity/chat.dart';
import 'package:helloworld/notifier/user_notifier.dart';

class ChatItem extends ConsumerWidget {
  const ChatItem({Key key, this.message}) : super(key: key);

  final ChatMessage message;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userName = ref.watch(userProvider);
    return Container(
      constraints: BoxConstraints(
        maxWidth: 480.0,
      ),
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
      child: Row(
        mainAxisAlignment: message.userName != userName
            ? MainAxisAlignment.start
            : MainAxisAlignment.end,
        children: [
          if (message.userName != userName) _userIcon(message.userName),
          SizedBox(
            width: 10,
          ),
          Card(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
              child: Text(
                message.message,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _userIcon(String name) {
    return Column(
      children: [
        CircleAvatar(
          backgroundImage: _dummyIconImage(),
          backgroundColor: Colors.transparent, // 背景色
        ),
        Text(message.userName),
      ],
    );
  }

  ImageProvider<Object> _dummyIconImage() {
    return AssetImage("images/dummy_user.png");
  }
}
