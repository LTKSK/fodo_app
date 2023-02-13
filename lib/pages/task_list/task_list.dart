import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'task_form.dart';
import '../../models/task.dart';

const _disclamer = '''免責事項
本アプリケーションを使用したことによって生じた
いかなる損害についても、開発者は一切の責任を負いません。
''';

class TaskList extends StatefulWidget {
  const TaskList({super.key});

  @override
  TaskListState createState() => TaskListState();
}

class TaskListState extends State<TaskList> {
  List<Task> tasks = [];

  List<Widget> _makeTaskWidgets() {
    return tasks.map((task) {
      return ListTile(
          trailing: IconButton(
              onPressed: () => {},
              icon: const Icon(Icons.edit),
              color: Colors.blue),
          leading: const Icon(Icons.event),
          title: Text(task.title));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todos"),
        actions: [
          IconButton(
              onPressed: () async {
                final info = await PackageInfo.fromPlatform();
                if (context.mounted) {
                  showLicensePage(
                    context: context,
                    applicationName: info.appName,
                    applicationVersion: info.version,
                    applicationLegalese: _disclamer,
                  );
                }
              },
              icon: const Icon(Icons.info))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(child: ListView(children: _makeTaskWidgets())),
            TaskForm(
              handleSubmit: (value) {
                // tasks.add(
                //     Task(title: value, information: "", state: TaskState.todo));
                setState(() {
                  // tasks = tasks;
                  tasks = [
                    ...tasks,
                    Task(title: value, information: "", state: TaskState.todo)
                  ];
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
