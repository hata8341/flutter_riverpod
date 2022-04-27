import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Counter extends ChangeNotifier {
  int count = 0;

  void increase() {
    count++;
    notifyListeners();
  }

  void decrease() {
    count--;
    notifyListeners();
  }

  void reset() {
    count = 0;
    notifyListeners();
  }
}

// Providerの定数をグローバルに宣言
final counterProvider = ChangeNotifierProvider((ref) => Counter());
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
    final counter = ref.watch(counterProvider);
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          appBar: AppBar(title: const Text('riverpod_example')),
          body: ListView(
            children: [
              Text('Count: ${counter.count}'),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: counter.increase,
            child: const Icon(Icons.add),
          ),
        ));
  }
}
