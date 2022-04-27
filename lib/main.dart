import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_pre/controller/home_page_notifier.dart';

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
    final pageState = ref.watch(homePageNotifierProvider);
    final pageNotifier = ref.watch(homePageNotifierProvider.notifier);

    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: pageNotifier.resetAllCount,
            child: Icon(Icons.exposure_zero),
          ),
          body: ListView(
            children: [
              ListTile(
                title: Text('Main Count ${pageState.mainCount}'),
                onTap: pageNotifier.increaseMainCount,
              ),
              ListTile(
                title: Text('Sub Count ${pageState.subCount}'),
                onTap: pageNotifier.increaseSubCount,
              ),
            ],
          ),
        ));
  }
}
