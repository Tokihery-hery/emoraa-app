import 'dart:typed_data';

import 'package:emoraa/services/server_chat.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatterServerController extends GetxController {
  final TextEditingController messageController = TextEditingController();
  Server? server;
  List<String> serversLogs = [];
  Future<void> startorStopServer() async {
    if (server!.running) {
      await server!.close();
      serversLogs.clear();
    } else {
      await server!.start();
    }
    update();
  }

  @override
  void onInit() {
    server = Server(onData, onError);
    startorStopServer();
    super.onInit();
  }

  void onData(Uint8List data) {
    final receivedData = String.fromCharCodes(data);
    serversLogs.add(receivedData);
    update();
  }

  void onError(dynamic error) {
    printError(info: "Error $error");
  }

  void handlMessage() {
    server?.broadcast(messageController.text);
    serversLogs.add(messageController.text);
    messageController.clear();
    update();
  }
}
