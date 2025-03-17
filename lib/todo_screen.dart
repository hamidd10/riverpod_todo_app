import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_todo_app/todo_provider.dart';

class TodoScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todoProvider);
    final textController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Simple riverpod to do app'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: textController,
              decoration: InputDecoration(
                labelText: 'Add your new task',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    if (textController.text.isNotEmpty) {
                      ref.read(todoProvider.notifier).state = [
                        ...todos,
                        textController.text,
                      ];
                      textController.clear();
                    }
                  },
                ),
              ),
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  ref.read(todoProvider.notifier).state = [
                    ...todos,
                    value,
                  ];
                  textController.clear();
                }
              },
            ),
          ),
          // List of todos
          Expanded(
            child: ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(todos[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}