import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:device_info/device_info.dart';

typedef Unit8ListCallback = Function(Uint8List data);
typedef DynamicCallback = Function(dynamic data);

class Client {
  String hostname;
  int port;
  Unit8ListCallback? onData;
  DynamicCallback? onError;

  Client({
    required this.onData,
    required this.onError,
    required this.hostname,
    required this.port,
  });
  Socket? socket;
  final device = DeviceInfoPlugin();
  bool isConnected = false;
  Future<void> connect() async {
    // try {
    //   socket = await Socket.connect(hostname, port);
    //   socket?.listen(onData, onError: onError, onDone: () async {
    //     final info = await device.androidInfo;
    //     disconnect(info);
    //     isConnected = false;
    //   });
    //   isConnected = true;
    // } catch (e) {
    //   print(e.toString());
    // }
  }

  void write(String message) {
    // socket!.write(message);
  }

  void disconnect(AndroidDeviceInfo androidDeviceInfo) {
    final message =
        "${androidDeviceInfo.brand} ${androidDeviceInfo.device} get disconnnected";
    write(message);
    if (socket != null) {
      // socket?.destroy();
    }
  }
}
