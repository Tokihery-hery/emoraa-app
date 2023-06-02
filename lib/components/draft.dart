import 'package:flutter/material.dart';

class DraftPage extends StatelessWidget {
  const DraftPage({super.key});

  @override
  Widget build(BuildContext context) {
    var chcountController;
    var priceController;
    return Container(
      margin: EdgeInsets.zero,
      child: Column(
        children: [
          Row(
              children: [
                Container(
                  margin: EdgeInsets.zero,
                  height: 50,
                  width: 150,
                  child: TextField(
                    controller: chcountController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        hintText: "Nombre",
                        labelText: "Nombre",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20.0),
                          ),
                        ),
                        isDense: true),
                  ),
                ),
                Container(
                  margin: EdgeInsets.zero,
                  height: 50,
                  width: 150,
                  child: TextField(
                    controller: priceController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: "Combien?",
                      labelText: "Combien",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20.0),
                        ),
                      ),
                      isDense: true,
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
