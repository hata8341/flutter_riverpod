import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_pre/stateNotifier/entities/todo.dart';

class TodoListNotifier extends StateNotifier<List<Todo>> {
  TodoListNotifier()
      : super(const [
          Todo(id: '1', title: 'Buy a coffee'),
          Todo(id: '2', title: 'Buy a milk'),
          Todo(id: '3', title: 'Eat sushi'),
          Todo(id: '4', title: 'Build an sushi'),
          Todo(id: '5', title: 'Build my app'),
        ]);

  void add(Todo todo) {
    state = [...state, todo];
  }

  void remove(String todoId) {
    state = [
      for (final todo in state)
        if (todo.id != todoId) todo,
    ];
  }

  void toggle(String todoId) {
    print('todo.completedの切り替え');
    state = [
      for (final todo in state)
        if (todo.id == todoId)
          // todo.copyWith(completed: !todo.completed)
          // else
          todo,
    ];
  }
}

final todoListNotifierProvider =
    StateNotifierProvider<TodoListNotifier, List<Todo>>((ref) {
  return TodoListNotifier();
});

class StateNotifierProviderPage extends ConsumerWidget {
  const StateNotifierProviderPage({Key? key}) : super(key: key);

  static const String title = 'StateNotifierProvider';
  static const String routeName = 'state-notifir-provider';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoList = ref.watch(todoListNotifierProvider);
    final notifier = ref.watch(todoListNotifierProvider.notifier);

    return Scaffold(
      body: ListView(
        children: [
          for (final todo in todoList)
            ListTile(
              title: Text(todo.title),
              onTap: () => notifier.toggle(todo.id),
            )
        ],
      ),
    );
  }
}
