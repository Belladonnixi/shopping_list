import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_list/features/groceries/providers/groceries_provider.dart';
import 'package:shopping_list/features/groceries/presentation/widgets/grocery_list_tile.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// A widget that displays a list of grocery items.
class GroceryList extends ConsumerWidget {
  const GroceryList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groceryItems = ref.watch(groceriesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.groceryListTitle),
      ),
      // Use the groceryItems provider to display the grocery items.
      body: groceryItems.when(
        // Display the grocery items as a list of tiles.
        data: (groceryItems) => ListView.builder(
          itemCount: groceryItems.length,
          // Use the GroceryListTile widget to display each grocery item.
          itemBuilder: (context, index) => GroceryListTile(
            title: groceryItems[index].name,
            color: groceryItems[index].category.color,
            quantity: groceryItems[index].quantity,
          ),
        ),
        // Display a loading indicator while the grocery items are being fetched.
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('${AppLocalizations.of(context)!.error}: $error'),
        ),
      ),
    );
  }
}
