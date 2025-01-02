import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_list/data/mock_database_repository.dart';
import 'package:shopping_list/models/grocery_item.dart';

final groceriesProvider = FutureProvider<List<GroceryItem>>(
  (ref) async {
    final items = MockDatabaseRepository();
    return await items.fetchGroceryItems();
  },
);
