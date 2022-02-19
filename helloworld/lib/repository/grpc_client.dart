import 'dart:io';

import 'package:flutter/material.dart';
import 'package:grpc/grpc.dart';

abstract class GrpcClient {
  ClientChannel channel;
  @protected
  bool isShatdown = false;

  GrpcClient() {
    connectChannel();
  }

  @protected
  void connectChannel() {
    channel = ClientChannel(
      Platform.isAndroid ? "10.0.2.2" : '127.0.0.1',
      port: 50051,
      options: const ChannelOptions(
        idleTimeout: Duration(seconds: 10),
        credentials: ChannelCredentials.insecure(),
      ),
    );
  }

  Future shatdown() async {
    isShatdown = true;
    await channel.shutdown();
  }
}
