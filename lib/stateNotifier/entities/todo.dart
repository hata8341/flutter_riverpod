class Todo {
  const Todo({
    required this.title,
    required this.id,
    this.completed = false,
  });

  final String title;
  final String id;
  final bool completed;

  @override
  String toString() {
    return 'Todo(title: $title, completed: $completed)';
  }
}
