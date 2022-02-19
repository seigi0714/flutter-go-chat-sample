import 'package:helloworld/protos/chat/chat.pb.dart';
import 'package:helloworld/protos/chat/google/protobuf/timestamp.pb.dart';

class ChatMessage {
  String message;
  String userName;
  Timestamp createAt;

  ChatMessage({String message,String userName,Timestamp createAt}) {
    this.message = message;
    this.userName = userName;
    this.createAt = createAt;
  }
}

class ChatMessageFactory {
  static ChatMessage fromProto(Message msg) {
    return ChatMessage(
      message: msg.message,
      userName: msg.name,
      createAt: msg.createdAt
    );
  }
}