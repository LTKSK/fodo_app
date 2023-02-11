import 'package:flutter/material.dart';
import 'todo_form.dart';

class TodoList extends StatelessWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Todos"),
          actions: [
            IconButton(
              onPressed: () => {},
              icon: const Icon(Icons.play_arrow),
            ),
            IconButton(onPressed: () => {}, icon: const Icon(Icons.save))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: ListView(
            children: [
              TodoForm(),
              const ListTile(
                leading: Icon(Icons.map),
                title: Text('Map'),
              ),
              const ListTile(
                leading: Icon(Icons.photo_album),
                title: Text('Album'),
              ),
              ListTile(
                trailing: ElevatedButton(
                    onPressed: () => {}, child: const Icon(Icons.edit)),
                title: const Text('Phone'),
                subtitle: const Text('subPhone'),
              ),
            ],
          ),
        ));
  }
}
