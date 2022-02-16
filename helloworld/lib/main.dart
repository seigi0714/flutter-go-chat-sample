import 'package:flutter/material.dart';
import 'package:grpc/grpc.dart';
import 'package:helloworld/protos/helloworld.pb.dart';

import 'protos/helloworld.pbgrpc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          createHoge("seigi");
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<void> createHoge(String name) async {
    final channel = ClientChannel('localhost',
        port: 50051,
        options:
            const ChannelOptions(credentials: ChannelCredentials.insecure()));
    final grpcClient = GreeterClient(channel,
        options: CallOptions(timeout: Duration(seconds: 10)));
    try {
      final request = HelloRequest();
      request.name = name;
      final replay = await grpcClient.sayHello(request);
      print(replay);
      await channel.shutdown();
    } catch (error) {
      print('Caught error: $error');
      await channel.shutdown();
      return Future.error(error);
    }
  }
}
