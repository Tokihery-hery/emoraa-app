import 'package:emoraa/models/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class DeleteItemDialog extends StatefulWidget {
  const DeleteItemDialog({Key? key, required this.itemId}) : super(key: key);
  final int itemId;
  @override
  State<DeleteItemDialog> createState() => _DeleteItemDialogState();
}

class _DeleteItemDialogState extends State<DeleteItemDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Delete Item?"),
      content: const Text("Are you sure you want to delete this item?"),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            final provider =
                      Provider.of<SQLHelper>(context, listen: false);
                  provider.deleteCh(widget.itemId).then((value) {
                    Fluttertoast.showToast(
                      msg: "Deleted successfull",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.TOP_RIGHT,
                      textColor: const Color.fromARGB(255, 97, 207, 19),
                      backgroundColor: const Color.fromARGB(255, 131, 220, 91),
                    );
                    Navigator.pop(context);
                  }).catchError((error) {
                    Fluttertoast.showToast(
                      msg: error,
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.TOP_RIGHT,
                      textColor: const Color.fromARGB(255, 207, 19, 19),
                      backgroundColor: const Color.fromARGB(255, 131, 220, 91),
                    );
                  });
            Navigator.pop(context);
          },
          child: const Text("Delete"),
        ),
      ],
    );
  }
}