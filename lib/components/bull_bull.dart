import 'package:flutter/material.dart';


class BullBull extends StatelessWidget {
  const BullBull({super.key, required this.height, required this.width});
  final int height;
  final int width;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.parse(height.toString()),
      width: double.parse(width.toString()),
      decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(colors: [Colors.orange, Colors.purple])),
    );;
  }
}