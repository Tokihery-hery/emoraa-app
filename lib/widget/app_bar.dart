import 'package:emoraa/components/delete_dialog.dart';
import 'package:emoraa/models/house_model.dart';
import 'package:flutter/material.dart';

class EAppBar extends StatefulWidget {
  const EAppBar({super.key});

  @override
  State<EAppBar> createState() => _EAppBarState();
}

class _EAppBarState extends State<EAppBar> {

  @override
  Widget build(BuildContext context) {
      final Housse argument =
        ModalRoute.of(context)?.settings.arguments as Housse;
    return AppBar(
          elevation: 0,
          flexibleSpace: const FlexibleSpaceBar(
              background: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 40, 125, 237),
                  Color.fromARGB(255, 242, 75, 33),
                ],
                begin: Alignment.topLeft,
                end: Alignment.topRight,
              ),
            ),
          )),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/housse_form',
                      arguments: {'id': argument.id, 'data': argument});
                },
                icon: const Icon(
                  Icons.edit,
                  color: Colors.greenAccent,
                )),
            IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return DeleteItemDialog(itemId: argument.id!);
                    },
                  );
                },
                icon: const Icon(
                  Icons.delete_forever,
                  color: Colors.blue,
                ))
          ],
        );
  }
}