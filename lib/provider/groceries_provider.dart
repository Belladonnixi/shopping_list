import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_list/data/mock_database_repository.dart';
import 'package:shopping_list/models/grocery_item.dart';

// This provider is responsible for fetching the grocery items from the database.
final groceriesProvider = FutureProvider<List<GroceryItem>>(
  (ref) async {
    final items = MockDatabaseRepository();
    return await items.fetchGroceryItems();
  },
);
