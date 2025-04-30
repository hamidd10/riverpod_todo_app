import 'package:flutter_riverpod/flutter_riverpod.dart';

class Todo {
  final String id;
  final String text;
  bool isCompleted;

  Todo({
    required this.id,
    required this.text,
    this.isCompleted = false,
  });
}

final todoProvider = StateNotifierProvider<TodoNotifier, List<Todo>>((ref) {
  return TodoNotifier();
});


class TodoNotifier extends StateNotifier<List<Todo>> {
  TodoNotifier() : super([]);

  void addTodo(String text) {
    state = [
      ...state,
      Todo(
        id: DateTime.now().toString(),
        text: text,
      ),
    ];
  }


  void deleteTodo(String id) {
    state = state.where((todo) => todo.id != id).toList();
  }

  void updateTodo(String id, String newText) {
    state = state.map((todo) {
      if (todo.id == id) {
        return Todo(
          id: todo.id,
          text: newText,
          isCompleted: todo.isCompleted,
        );
      }
      return todo;
    }).toList();
  }

  void toggleTodo(String id) {
    state = state.map((todo) {
      if (todo.id == id) {
        return Todo(
          id: todo.id,
          text: todo.text,
          isCompleted: !todo.isCompleted,
        );
      }
      return todo;
    }).toList();
  }
}