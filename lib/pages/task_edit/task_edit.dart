import 'package:flutter/material.dart';
import '../../models/task.dart';

class TaskEdit extends StatefulWidget {
  final Task task;
  final void Function(String title) onTitleChange;

  const TaskEdit({
    super.key,
    required this.task,
    required this.onTitleChange,
  });

  @override
  State<TaskEdit> createState() => TaskEditState();
}

class TaskEditState extends State<TaskEdit> {
  String _title = "";

  @override
  void initState() {
    super.initState();
    setState(() {
      _title = widget.task.title;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.task.title}を編集'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            initialValue: _title,
            onChanged: (value) => setState(() {
              _title = value;
            }),
            maxLength: 32,
            maxLines: 1,
            decoration: InputDecoration(
                labelText: "taskの名前を更新する",
                suffixIcon: IconButton(
                  onPressed: () {
                    widget.onTitleChange(_title);
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.save),
                  color: Colors.blue,
                )),
          )
        ],
      ),
    );
  }
}
