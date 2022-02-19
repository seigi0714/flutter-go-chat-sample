///
//  Generated code. Do not modify.
//  source: chat.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'google/protobuf/empty.pb.dart' as $0;
import 'chat.pb.dart' as $1;
export 'chat.pb.dart';

class ChatClient extends $grpc.Client {
  static final _$getMessages = $grpc.ClientMethod<$0.Empty, $1.Message>(
      '/chat.Chat/GetMessages',
      ($0.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.Message.fromBuffer(value));
  static final _$postMessage = $grpc.ClientMethod<$1.Message, $1.Result>(
      '/chat.Chat/PostMessage',
      ($1.Message value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.Result.fromBuffer(value));

  ChatClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseStream<$1.Message> getMessages($0.Empty request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(
        _$getMessages, $async.Stream.fromIterable([request]),
        options: options);
  }

  $grpc.ResponseFuture<$1.Result> postMessage($1.Message request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$postMessage, request, options: options);
  }
}

abstract class ChatServiceBase extends $grpc.Service {
  $core.String get $name => 'chat.Chat';

  ChatServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.Empty, $1.Message>(
        'GetMessages',
        getMessages_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
        ($1.Message value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.Message, $1.Result>(
        'PostMessage',
        postMessage_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.Message.fromBuffer(value),
        ($1.Result value) => value.writeToBuffer()));
  }

  $async.Stream<$1.Message> getMessages_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Empty> request) async* {
    yield* getMessages(call, await request);
  }

  $async.Future<$1.Result> postMessage_Pre(
      $grpc.ServiceCall call, $async.Future<$1.Message> request) async {
    return postMessage(call, await request);
  }

  $async.Stream<$1.Message> getMessages(
      $grpc.ServiceCall call, $0.Empty request);
  $async.Future<$1.Result> postMessage(
      $grpc.ServiceCall call, $1.Message request);
}
