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
    return Text(task.title);
  }
}
