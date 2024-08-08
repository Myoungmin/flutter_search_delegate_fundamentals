import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedIndexProvider = StateProvider<int>((ref) {
  return 0;
});

class CustomSearchDelegate extends SearchDelegate<String> {
  final List<String> searchList = [
    "Apple",
    "Banana",
    "Cherry",
    "Date",
    "Fig",
    "Grapes",
    "Kiwi",
    "Lemon",
    "Mango",
    "Orange",
    "Papaya",
    "Raspberry",
    "Strawberry",
    "Tomato",
    "Watermelon",
  ];

  final FocusNode focusNode = FocusNode();
  final WidgetRef ref;

  CustomSearchDelegate({required this.ref});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => Navigator.of(context).pop(),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<String> searchResults = searchList
        .where((item) => item.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return _buildList(context, searchResults);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<String> suggestionList = query.isEmpty
        ? []
        : searchList
            .where((item) => item.toLowerCase().contains(query.toLowerCase()))
            .toList();

    return _buildList(context, suggestionList);
  }

  Widget _buildList(BuildContext context, List<String> items) {
    int selectedIndex = ref.watch(selectedIndexProvider);

    return KeyboardListener(
      focusNode: focusNode,
      onKeyEvent: (event) {
        if (event.physicalKey == PhysicalKeyboardKey.arrowDown) {
          if (selectedIndex < items.length - 1) {
            ref.read(selectedIndexProvider.notifier).state++;
          }
        } else if (event.physicalKey == PhysicalKeyboardKey.arrowUp) {
          if (selectedIndex > 0) {
            ref.read(selectedIndexProvider.notifier).state--;
          }
        }
      },
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              items[index],
              style: TextStyle(
                color: selectedIndex == index ? Colors.blue : null,
              ),
            ),
            onTap: () {
              close(context, items[index]);
            },
          );
        },
      ),
    );
  }
}
