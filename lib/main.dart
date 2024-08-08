import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_search_delegate_fundamentals/custom_search_delegate.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter SearchDelegate Fundamentals'),
          actions: [
            Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.search),
                onPressed: () async {
                  showSearch(
                    context: context,
                    delegate: CustomSearchDelegate(ref: ref),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
