import 'package:shopping_list/models/grocery_item.dart';

abstract class DatabaseRepository {
  Future<void> addGroceryItem(GroceryItem item);
  Future<void> deleteGroceryItem(GroceryItem item);
  Future<List<GroceryItem>> fetchGroceryItems();
}
