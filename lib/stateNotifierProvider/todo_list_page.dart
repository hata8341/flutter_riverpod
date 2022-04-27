import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentTodoIndex = Provider<int>((watch) => throw UnimplementedError());

// final currentTodoIndexT = Provider<int?>(null);

class TodoList extends StatelessWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(itemBuilder: (context, index) {
        return ProviderScope(overrides: [
          currentTodoIndex.overrideWithValue(index),
        ], child: const TodoItemTile());
      }),
    );
  }
}

class TodoItemTile extends ConsumerWidget {
  const TodoItemTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(currentTodoIndex);

    return ListTile(
      title: Text('$index番目のTODO'),
    );
  }
}
