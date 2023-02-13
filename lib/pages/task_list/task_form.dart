import 'package:flutter/material.dart';

class TaskForm extends StatefulWidget {
  final void Function(String) handleSubmit;
  const TaskForm({super.key, required this.handleSubmit});

  @override
  _TaskFormState createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  String _title = "";

  void handleTitle(String title) {
    setState(() {
      _title = title;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLength: 32,
      maxLines: 1,
      decoration: InputDecoration(
          labelText: "作成するTaskの名前を入力してください",
          suffixIcon: IconButton(
            onPressed: () {
              widget.handleSubmit(_title);
              setState(() {
                _title = "";
              });
            },
            icon: const Icon(Icons.add),
            color: Colors.blue,
          )),
      onChanged: handleTitle,
    );
  }
}
