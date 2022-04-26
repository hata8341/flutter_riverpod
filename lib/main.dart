import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Providerの定数をグローバルに宣言
final counterProvider = StateProvider<int>((ref) {
  return 0;
});

final doubleCounterProvider = Provider<int>((ref) {
  final count = ref.watch(counterProvider);

  return count * 2;
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
    final counter = ref.watch(counterProvider.notifier);
    final doubleCount = ref.watch(doubleCounterProvider);
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          appBar: AppBar(title: const Text('riverpod_example')),
          body: ListView(
            children: [
              Text('２倍の値:$doubleCount'),
              Text('Count: ${ref.watch(counterProvider)}'),
              ElevatedButton(
                onPressed: () => counter.update((state) => state + 1),
                child: Text('Count: ${ref.watch(counterProvider)}'),
              )
            ],
          ),
        ));
  }
}
