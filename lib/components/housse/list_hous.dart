import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  final String name;
  final String description;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const ListItem({
    Key? key,
    required this.name,
    required this.description,
    required this.onDelete,
    required this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name),
      subtitle: Text(description),
      selectedColor: Colors.white,
      trailing: SizedBox(
        width: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: onDelete,
            ),
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: onEdit,
            ),
          ],
        ),
      ),
    );
  }
}
