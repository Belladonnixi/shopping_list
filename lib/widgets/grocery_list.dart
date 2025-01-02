import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_list/provider/groceries_provider.dart';
import 'package:shopping_list/widgets/grocery_list_tile.dart';

class GroceryList extends ConsumerWidget {
  const GroceryList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groceryItems = ref.watch(groceriesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Grocery List'),
      ),
      body: groceryItems.when(
        data: (groceryItems) => ListView.builder(
          itemCount: groceryItems.length,
          itemBuilder: (context, index) => GroceryListTile(
            title: groceryItems[index].name,
            color: groceryItems[index].category.color,
            quantity: groceryItems[index].quantity,
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
