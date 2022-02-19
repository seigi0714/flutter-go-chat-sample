import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:helloworld/notifier/chat_message_notifier.dart';
import 'package:helloworld/view/parts/chat_item.dart';

class ChatList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatMessages = ref.watch(chatMessagesProvider);

    if (chatMessages.isEmpty) {
      return Center(
        child: Text("メッセージが有りません。"),
      );
    }

    return ListView.builder(
      itemCount: chatMessages.length,
      itemBuilder: (BuildContext context, int index) {
        final message = chatMessages[index];
        return ChatItem(message: message);
      },
    );
  }
}