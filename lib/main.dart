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
// final counterProvider = ChangeNotifierProvider((ref) => Counter());
final counterProvider = StateProvider((ref) => 0);
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
    final isAbove10 =
        ref.watch(counterProvider.select((value) => value.state > 10));
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

class Dialog extends ConsumerWidget {
  const Dialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<int>(
      counterProvider,
      (previous, next) {
        if (next.isEven) {
          return;
        }
        showDialog(
            context: context,
            builder: (context) {
              return const AlertDialog(
                title: Text('Current number is 奇数！'),
              );
            });
      },
      onError: (error, stackTrace) => debugPrint('$error'),
    );

    return Container();
  }
}
