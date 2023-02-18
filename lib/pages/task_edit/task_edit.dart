import 'package:flutter/material.dart';
import '../../models/task.dart';

class TaskEdit extends StatelessWidget {
  final Task task;
  const TaskEdit({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    // TODO, 戻るボタン
    // TODO, description修正
    // TODO, state更新
    return Scaffold(
      appBar: AppBar(
        title: Text('${task.title}を編集'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            maxLength: 32,
            maxLines: 1,
            decoration: InputDecoration(
                labelText: "taskの名前を更新する",
                suffixIcon: IconButton(
                  onPressed: () => {},
                  icon: const Icon(Icons.save),
                  color: Colors.blue,
                )),
            onChanged: (value) => {},
          )
        ],
      ),
    );
  }
}
