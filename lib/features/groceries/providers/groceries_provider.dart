import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shopping_list/data/repositories/mock_database_repository.dart';
import 'package:shopping_list/data/models/grocery_item.dart';

part 'groceries_provider.g.dart';

@riverpod
Future<MockDatabaseRepository> mockDatabaseRepository(Ref ref) async {
  return await MockDatabaseRepository.create();
}

@riverpod
Future<List<GroceryItem>> fetchGroceries(Ref ref) async {
  final repository = await ref.watch(mockDatabaseRepositoryProvider.future);
  return await repository.fetchGroceryItems();
}
