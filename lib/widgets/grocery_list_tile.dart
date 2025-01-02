import 'package:flutter/material.dart';

class GroceryListTile extends StatelessWidget {
  const GroceryListTile(
      {super.key,
      required this.title,
      required this.color,
      required this.quantity});

  final String title;
  final Color color;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
      trailing: Text(quantity.toString()),
    );
  }
}
