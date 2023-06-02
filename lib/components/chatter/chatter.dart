import 'package:emoraa/controllers/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Chatter extends StatefulWidget {
  const Chatter({super.key});

  @override
  State<Chatter> createState() => _ChatterState();
}

class _ChatterState extends State<Chatter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chatter"),
      ),
      body: GetBuilder<ChatterServerController>(
        init: ChatterServerController(),
        builder: (controller) {
          return Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Server"),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(50)),
                              color: controller.server!.running
                                  ? Colors.green
                                  : Colors.red,
                            ),
                            child:
                                Text(controller.server!.running ? "ON" : "OFF"),
                          )
                        ],
                      ),
                      TextButton(
                        onPressed: () async {
                          controller.startorStopServer();
                        },
                        child: Text(
                          controller.server!.running
                              ? "Stop server"
                              : "Start server",
                        ),
                      ),
                      const Divider(
                        height: 5,
                      ),
                      Expanded(
                        child: ListView(
                          children: controller.serversLogs
                              .map(
                                (e) => Text(e),
                              )
                              .toList(),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Form(
                      child: TextFormField(
                        controller: controller.messageController,
                        decoration:
                            const InputDecoration(labelText: 'Send a message'),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      controller.messageController.clear();
                    },
                    icon: const Icon(Icons.clear),
                  ),
                  IconButton(
                    onPressed: (){
                      controller.handlMessage();
                    },
                    icon: const Icon(Icons.send),
                  )
                ],
              ),
              const SizedBox(height: 24),
            ],
          );
        },
      ),
    );
  }
}
