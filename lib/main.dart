import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_list/app/app.dart';

void main() {
  runApp(
    const ProviderScope(
      child: ShoppingListApp(),
    ),
  );
}
