import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grpc/grpc.dart';
import 'package:helloworld/entity/chat.dart';
import 'package:helloworld/notifier/user_notifier.dart';
import 'package:helloworld/protos/chat/chat.pb.dart';
import 'package:helloworld/repository/chat_client.dart';

final chatMessagesProvider =
    StateNotifierProvider<ChatMessagesNotifier, List<ChatMessage>>(
        (ref) => ChatMessagesNotifier(ref));

class ChatMessagesNotifier extends StateNotifier<List<ChatMessage>> {
  ChatMessagesNotifier(this.ref) : super([]) {
    listenMessage();
  }

  final _chatReposiory = ChatGrpcClient();
  StateNotifierProviderRef ref;

  Future listenMessage() async {
    try {
      await for (ChatMessage msg in _chatReposiory.getMessage()) {
        print("get message ::" + msg.message);
        addMessage(msg);
        }
    } on GrpcError catch(e) {
      listenMessage();
    }
  }

  void addMessage(ChatMessage msg) {
    state = [...state, msg];
  }

  Future send(String text) async {
    final userName = ref.read(userProvider);
    await _chatReposiory.send(msg: text, name: userName);
  }
}

final chatMessageFaimily =
    StateNotifierProviderFamily<ChatMessageNotifier, ChatMessage, ChatMessage>(
  (ref, msg) => ChatMessageNotifier(msg),
);

final chatMessageProvider = Provider<ChatMessageNotifier>((ref) => ChatMessageNotifier(ChatMessage()));

class ChatMessageNotifier extends StateNotifier<ChatMessage> {
  ChatMessageNotifier(ChatMessage msg) : super(msg);
}
