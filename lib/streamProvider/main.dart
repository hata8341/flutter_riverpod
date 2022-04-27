import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final itemsStreamProvider = StreamProvider<List<Item>>((ref) {
  final collection = FirebaseFirestore.instance.collection('items');
  final stream = collection.snapshots().map(
        (e) => e.docs.map((e) => Item.fromJson(e.data())).toList(),
      );

  return stream;
});

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(itemsStreamProvider);
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          body: items.when(
              loading: () => const CircularProgressIndicator(),
              error: (error, stack) => Text('Error: $error'),
              data: (items) {
                final item = items[index];
                return ListTile(
                  title: Text(item.name),
                );
              }),
        ));
  }
}
