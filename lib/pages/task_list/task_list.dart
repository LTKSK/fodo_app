import 'package:flutter/material.dart';
import 'task_form.dart';
import '../../models/task.dart';

class TaskList extends StatefulWidget {
  const TaskList({super.key});

  @override
  TaskListState createState() => TaskListState();
}

class TaskListState extends State<TaskList> {
  List<Task> tasks = [
    const Task(title: "task1", information: "", state: TaskState.todo),
    const Task(title: "task2", information: "", state: TaskState.todo),
  ];

  List<Widget> _makeTaskWidgets() {
    return tasks.map((task) {
      return ListTile(
          trailing: ElevatedButton(
              onPressed: () => {}, child: const Icon(Icons.edit)),
          leading: const Icon(Icons.map),
          title: Text(task.title));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todos"),
        actions: [
          IconButton(onPressed: () => {}, icon: const Icon(Icons.save))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(child: ListView(children: _makeTaskWidgets())),
            TodoForm(
              handleChange: (value) => print(value),
            )
          ],
        ),
      ),
    );
  }
}
