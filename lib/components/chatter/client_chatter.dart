import 'package:emoraa/controllers/client_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClientChatter extends StatefulWidget {
  const ClientChatter({super.key});

  @override
  State<ClientChatter> createState() => _ClientChatterState();
}
final TextEditingController _messageController = TextEditingController();
class _ClientChatterState extends State<ClientChatter> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ClientController>(
      builder: (controller) {
        return Scaffold(
        appBar: AppBar(
          title: const Text('Chat App'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // Expanded(
              //   child: ListView.builder(
              //     reverse: true,
              //     itemCount: controller.logs.length,
              //     itemBuilder: (context, index) {
              //       final message = controller.logs[index];
    
              //       return Padding(
              //         padding: const EdgeInsets.symmetric(vertical: 8.0),
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             Container(
              //               decoration: BoxDecoration(
              //                 color:  Colors.grey,
              //                 borderRadius: BorderRadius.circular(12.0),
              //               ),
              //               padding: const EdgeInsets.all(16.0),
              //               child: Text(
              //                 message,
              //                 style: const TextStyle(color: Colors.white),
              //               ),
              //             ),
              //             Text(
              //               message,
              //               style: const TextStyle(color: Colors.grey),
              //             ),
              //           ],
              //         ),
              //       );
              //     },
              //   ),
              // ),
              TextField(
                controller: _messageController,
                decoration: const InputDecoration(
                  hintText: 'Type your message...',
                ),
              ),
              ElevatedButton(
                onPressed: _sendMessage,
                child: const Text('Send'),
              ),
            ],
          ),
        ),
      );
      },
     
    );
  }

  void _sendMessage() {
  }
}