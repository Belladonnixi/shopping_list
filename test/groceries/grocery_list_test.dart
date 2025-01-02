import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_list/features/groceries/providers/groceries_provider.dart';
import 'package:shopping_list/features/groceries/presentation/screens/grocery_list.dart';
import 'package:shopping_list/data/models/grocery_item.dart';
import 'package:shopping_list/data/models/category.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  // Test case: Verifies that a loading indicator is displayed while the data is being fetched.
  testWidgets('GroceryList displays loading indicator while fetching data',
      (WidgetTester tester) async {
    // Pump the widget tree with the GroceryList wrapped in a ProviderScope.
    // The ProviderScope provides the necessary Riverpod providers to the widget tree.
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          // Localization delegates for handling localized strings.
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home:
              GroceryList(), // The GroceryList widget is the screen being tested.
        ),
      ),
    );

    // Verify that a CircularProgressIndicator is displayed, indicating a loading state.
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  // Test case: Verifies that an error message is displayed when fetching data fails.
  testWidgets('GroceryList displays error message when data fetch fails',
      (WidgetTester tester) async {
    // Pump the widget tree, overriding the groceriesProvider to simulate a failed data fetch.
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          // Override the groceriesProvider to simulate a Future that throws an exception.
          groceriesProvider.overrideWith(
            // Return a Future that throws an exception when fetching grocery items.
            (ref) => Future.error(Exception('Failed to fetch grocery items')),
          ),
        ],
        // The GroceryList widget is the screen being tested.
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: GroceryList(),
        ),
      ),
    );

    // Trigger a rebuild of the widget tree to process the Future's error state.
    await tester.pump();

    // Verify that the error message is displayed with the expected exception text.
    expect(find.text('Error: Exception: Failed to fetch grocery items'),
        findsOneWidget);
  });

  // Test case: Verifies that grocery items are displayed when data is successfully fetched.
  testWidgets('GroceryList displays grocery items when data is available',
      (WidgetTester tester) async {
    // Define a list of mock grocery items to simulate successful data fetch.
    final groceryItems = [
      const GroceryItem(
        id: '1',
        name: 'Apples',
        category: Category(name: 'fruit', color: Colors.red),
        quantity: 5,
      ),
      const GroceryItem(
        id: '2',
        name: 'Milk',
        category: Category(name: 'dairy', color: Colors.blue),
        quantity: 2,
      ),
    ];

    // Pump the widget tree, overriding the groceriesProvider to return the mock grocery items.
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          // Override the groceriesProvider to simulate a successful data fetch.
          groceriesProvider.overrideWith(
            (ref) => Future.value(groceryItems),
          ),
        ],
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: GroceryList(),
        ),
      ),
    );

    // Trigger a rebuild of the widget tree to process the Future's completion with data.
    await tester.pump();

    // Verify that the grocery items are displayed in the widget tree.
    expect(find.text('Apples'),
        findsOneWidget); // Check for the first grocery item.
    expect(find.text('Milk'),
        findsOneWidget); // Check for the second grocery item.
  });
}
