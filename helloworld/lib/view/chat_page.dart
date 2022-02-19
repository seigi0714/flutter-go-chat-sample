import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:helloworld/notifier/chat_message_notifier.dart';
import 'package:helloworld/notifier/user_notifier.dart';
import 'package:helloworld/view/parts/chat_list.dart';

class ChatPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatNotifier = ref.read(chatMessagesProvider.notifier);
    final user = ref.watch(userProvider);

    final TextEditingController chatMessageController = TextEditingController();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("チャットサンプル"),
        ),
        body: user.isEmpty
            ? UserNamePopUp()
            : Column(
                children: [
                  Expanded(
                    child: ChatList(),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: TextField(
                      controller: chatMessageController,
                      onSubmitted: (message) {
                        chatNotifier.send(message);
                        chatMessageController.text = "";
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class UserNamePopUp extends ConsumerWidget {
  static const _popupWidth = 360.0;
  static const _popupHeight = 120.0;
  static const _nameFormWidth = 240.0;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userNotifier = ref.watch(userProvider.notifier);

    final TextEditingController userNameController = TextEditingController();

    return Center(
      child: Container(
        width: _popupWidth,
        height: _popupHeight,
        padding: EdgeInsets.all(8.0),
        child: Card(
          child: Expanded(
            child: Column(
              children: [
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  "ユーザ名を入力してください。",
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                Container(
                  width: _nameFormWidth,
                  child: TextField(
                    controller: userNameController,
                    onSubmitted: (name) {
                      userNotifier.setName(name);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
