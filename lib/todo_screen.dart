import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_todo_app/todo_provider.dart';

class TodoScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todoProvider);
    final textController = TextEditingController();
    final editTextController = TextEditingController();


    void _showEditDialog(Todo todo) {
      editTextController.text = todo.text;
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("update"),
            content: TextField(
              controller: editTextController,
              decoration: InputDecoration(
                hintText: "insert your text",
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("cancel"),
              ),
              TextButton(
                onPressed: () {
                  ref.read(todoProvider.notifier).updateTodo(
                    todo.id,
                    editTextController.text,
                  );
                  Navigator.pop(context);
                },
                child: Text("save"),
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("riverpod TODO app"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: textController,
              decoration: InputDecoration(
                labelText: "new work",
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    if (textController.text.isNotEmpty) {
                      ref.read(todoProvider.notifier).addTodo(textController.text);
                      textController.clear();
                    }
                  },
                ),
              ),
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  ref.read(todoProvider.notifier).addTodo(value);
                  textController.clear();
                }
              },
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final todo = todos[index];
                return ListTile(
                  leading: Checkbox(
                    value: todo.isCompleted,
                    onChanged: (value) {
                      ref.read(todoProvider.notifier).toggleTodo(todo.id);
                    },
                  ),
                  title: Text(
                    todo.text,
                    style: TextStyle(
                      decoration: todo.isCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                    // edit button
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          _showEditDialog(todo);
                        },
                      ),
                      //delete button
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          ref.read(todoProvider.notifier).deleteTodo(todo.id);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}