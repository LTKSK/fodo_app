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

  List<Task> _selectTasksOrderByCreatedAtDesc() {
    final sorted = [...tasks]
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return sorted;
  }

  List<Widget> _makeTaskWidgets() {
    return _selectTasksOrderByCreatedAtDesc().map((task) {
      return TaskItem(
        task: task,
        onStateChange: () => {_changeTaskStateToNext(task)},
        onTitleChange: (newTitle) => _updateTaskTitle(task, newTitle),
        onDelete: () => _deleteTask(task.id),
      );
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
  void _createTask(String title) async {
    final task = await TaskRepository.createTask(
      title: title,
      descrption: "",
    );
    setState(() {
      tasks = [...tasks, task];
    });
  }

  TaskState _nextTaskState(TaskState current) {
    switch (current) {
      case TaskState.todo:
        return TaskState.doing;
      case TaskState.doing:
        return TaskState.done;
      case TaskState.done:
        return TaskState.todo;
    }
  }

  /// stateをtodo -> doing -> done -> todo... の順で遷移させる
  Future<void> _changeTaskStateToNext(Task task) async {
    final nextState = _nextTaskState(task.state);
    await TaskRepository.update(
      id: task.id,
      title: task.title,
      state: nextState,
    );
    final updatedTask = Task(
        id: task.id,
        title: task.title,
        state: nextState,
        description: task.description,
        createdAt: task.createdAt);
    setState(() {
      tasks = tasks.map((task) {
        if (task.id == updatedTask.id) return updatedTask;
        return task;
      }).toList();
    });
  }

  /// stateをtodo -> doing -> done -> todo... の順で遷移させる
  void _updateTaskTitle(Task task, String newTitle) {
    if (newTitle == "") {
      // TODO: 何故かこの分岐のときは表示がされない
      _showEmptyTaskTitleDialog();
      return;
    }

    TaskRepository.update(
      id: task.id,
      title: newTitle,
      state: task.state,
    ).then((_) {
      final updatedTask = Task(
          id: task.id,
          title: newTitle,
          state: task.state,
          description: task.description,
          createdAt: task.createdAt);
      setState(() {
        tasks = tasks.map((task) {
          if (task.id == updatedTask.id) return updatedTask;
          return task;
        }).toList();
      });
    });
  }

  void _deleteTask(int id) async {
    await TaskRepository.delete(id);
    setState(() {
      tasks = tasks.where((task) => task.id != id).toList();
    });
  }

  void _showEmptyTaskTitleDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("ちょっと待って！"),
          content: const Text("タスクの名前は空にできません"),
          actions: [
            TextButton(
              child: const Text("あいよ!"),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

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
            TaskForm(handleSubmit: (title) {
              if (title == "") {
                _showEmptyTaskTitleDialog();
              } else {
                _createTask(title);
              }
            })
          ],
        ),
      ),
    );
  }
}
