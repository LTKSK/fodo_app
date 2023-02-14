import 'package:flutter/material.dart';
import 'task_form.dart';
import 'task_item.dart';
import 'license_info_button.dart';
import 'package:fodo_app/models/task.dart';
import 'package:fodo_app/repositories/task_repository.dart';

class TaskList extends StatefulWidget {
  const TaskList({super.key});

  @override
  TaskListState createState() => TaskListState();
}

class TaskListState extends State<TaskList> {
  List<Task> tasks = [];

  List<Widget> _makeTaskWidgets() {
    return tasks.map((task) {
      return TaskItem(task: task);
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    TaskRepository.all().then((value) {
      setState(() {
        tasks = value;
      });
    });
  }

  /// repository経由でTaskを作って、作ったTaskをStateに設定する
  void createTask(String title) async {
    final task = await TaskRepository.createTask(
      title: title,
      descrption: "",
    );
    setState(() {
      tasks = [...tasks, task];
    });
  }

  void updateTask(String title, String description, TaskState state) async {}

  void deleteTask(int id) async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todos"),
        actions: const [LicenseInfoButton()],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(child: ListView(children: _makeTaskWidgets())),
            TaskForm(handleSubmit: createTask)
          ],
        ),
      ),
    );
  }
}
