import 'dart:typed_data';

import 'package:emoraa/services/client_chat.dart';
import 'package:get/get.dart';
import 'package:ping_discover_network/ping_discover_network.dart';

class ClientController extends GetxController {
  Client? client;
  List<String> logs = [];
  int port = 4041;
  Stream<NetworkAddress>? stream;
  NetworkAddress? address;
  @override
  void onInit() {
    // getIpAdress();
    super.onInit();
  }

  // getIpAdress() {
  //   stream = NetworkAnalyzer.discover2("127.0.0", port);
  //   stream?.listen((NetworkAddress networkAddress) {
  //     if (networkAddress.exists) {
  //       address = networkAddress;
  //       client = Client(
  //         onData: onData,
  //         onError: onError,
  //         hostname: networkAddress.ip,
  //         port: port,
  //       );
  //     }
  //   });
  //   update();
  // }

  void sendMessage(String message) {
    // client!.write(message);
  }

  onData(Uint8List data) async {
    final message = String.fromCharCodes(data);
    logs.add(message);
    update();
  }

  onError(dynamic data) {
    print(data);
  }
}
