import 'package:shopping_list/data/repositories/database_repository.dart';
import 'package:shopping_list/data/models/category.dart';
import 'package:shopping_list/data/models/grocery_item.dart';
import 'package:shopping_list/data/data_source/categories.dart';

class MockDatabaseRepository implements DatabaseRepository {
  MockDatabaseRepository._internal();

  static final MockDatabaseRepository _instance =
      MockDatabaseRepository._internal();

  factory MockDatabaseRepository() {
    return _instance;
  }

  final List<GroceryItem> groceryItems = [
    GroceryItem(
        id: 'a',
        name: 'Milk',
        quantity: 1,
        category: categories[Categories.dairy]!),
    GroceryItem(
        id: 'b',
        name: 'Bananas',
        quantity: 5,
        category: categories[Categories.fruit]!),
    GroceryItem(
        id: 'c',
        name: 'Beef Steak',
        quantity: 1,
        category: categories[Categories.meat]!),
  ];

  @override
  Future<void> addGroceryItem(GroceryItem item) async {
    groceryItems.add(item);
  }

  @override
  Future<void> deleteGroceryItem(GroceryItem item) async {
    groceryItems.removeWhere((item) => item.id == item.id);
  }

  @override
  Future<List<GroceryItem>> fetchGroceryItems() async {
    return groceryItems;
  }
}
