import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

typedef Unit8ListCallback = Function(Uint8List data);
typedef DynamicCallback = Function(dynamic data);

class Server {
  Unit8ListCallback? onData;
  DynamicCallback? onError;
  Server(this.onData, this.onError);
  ServerSocket? server;
  bool running = false;
  List<Socket> sockets = [];
  Future<void> start() async {
    runZoned(() async {
      server = await ServerSocket.bind('127.0.0.1', 4041);
      running = true;
      server?.listen(onRequest);
      const message = "Server is listening n port 4041";
      onData!(Uint8List.fromList(message.codeUnits));
      // ignore: deprecated_member_use
    }, onError: onError);
  }

  void onRequest(Socket socket) {
    if (!sockets.contains(socket)) {
      sockets.add(socket);
    }
    socket.listen((event) {
      onData!(event);
    });
  }

  Future<void> close() async {
    await server!.close();
    server = null;
    running = false;
  }

  void broadcast(String data) {
    onData!(Uint8List.fromList("Broad cast message:  $data".codeUnits));
    for (var socket in sockets) {
      socket.write(data);
    }
  }
}
