import 'package:grpc/grpc.dart';
import 'package:helloworld/entity/chat.dart';
import 'package:helloworld/protos/chat/chat.pbgrpc.dart';
import 'package:helloworld/protos/chat/google/protobuf/empty.pb.dart';
import 'package:helloworld/protos/chat/google/protobuf/timestamp.pb.dart';
import 'package:helloworld/repository/grpc_client.dart';

class ChatGrpcClient extends GrpcClient {
  Future send({String msg, String name}) async {
    try {
      if (isShatdown) {
        connectChannel();
      }
      final chatClient = ChatClient(
        channel,
        options: CallOptions(
          timeout: Duration(seconds: 10),
        ),
      );

      final request = Message(
        name: name,
        message: msg,
        createdAt: Timestamp.fromDateTime(DateTime.now()),
      );
      final res = await chatClient.postMessage(request);
      print(res);
    } catch (e) {
      print("send error" + e.toString());
    }
  }

  Stream<ChatMessage> getMessage() async* {
    print("get");
    if (isShatdown) {
      print("reconnect");
      connectChannel();
    }
    final chatClient = ChatClient(
      channel,
      options: CallOptions(
        timeout: Duration(seconds: 10),
      ),
    );

    final messageStream = chatClient.getMessages(Empty.create());
    try{
      await for (var msg in messageStream) {
        yield ChatMessageFactory.fromProto(msg);
      }
    } on GrpcError catch (e) {
      if (e.codeName == "DEADLINE_EXCEEDED") {
            print("DEADLINE_EXCEEDED");
            throw e;
      }
    } catch (e) {
      shatdown();
      throw Exception("インターネット接続が切れました。");
    }
  }
}
