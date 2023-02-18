import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../task_edit/task_edit.dart';
import '../../models/task.dart';

class TaskItem extends StatelessWidget {
  final Task task;
  final void Function() onStateChange;
  final void Function() onDelete;
  const TaskItem(
      {super.key,
      required this.task,
      required this.onStateChange,
      required this.onDelete});

  Color _iconColorFromState(TaskState state) {
    switch (state) {
      case TaskState.todo:
        return Colors.blueGrey;
      case TaskState.doing:
        return Colors.orange;
      case TaskState.done:
        return Colors.green;
    }
  }

  Icon _iconFromState(TaskState state) {
    switch (state) {
      case TaskState.todo:
        return const Icon(Icons.calendar_today);
      case TaskState.doing:
        return const Icon(Icons.sports_martial_arts);
      case TaskState.done:
        return const Icon(Icons.done_outline);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      // key: const ValueKey(0),
      // The end action pane is the one at the right or the bottom side.
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (ctx) => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TaskEdit(task: task)),
              )
            },
            backgroundColor: const Color.fromARGB(255, 167, 167, 167),
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: '編集',
          ),
          SlidableAction(
            onPressed: (_) => onDelete(),
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: '削除',
          ),
        ],
      ),
      child: Padding(
          padding: const EdgeInsets.all(4),
          child: ListTile(
            iconColor: _iconColorFromState(task.state),
            leading: IconButton(
                icon: _iconFromState(task.state),
                onPressed: () => {onStateChange()}),
            title: Text(task.title),
            subtitle: Text(task.createdAt),
            tileColor: const Color.fromARGB(26, 132, 132, 132),
          )),
    );
  }
}
