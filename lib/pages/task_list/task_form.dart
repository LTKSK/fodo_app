import 'package:flutter/material.dart';

class TodoForm extends StatefulWidget {
  final void Function(String) handleChange;
  const TodoForm({super.key, required this.handleChange});

  @override
  _TaskFormState createState() => _TaskFormState();
}

class _TaskFormState extends State<TodoForm> {
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
      decoration: const InputDecoration(labelText: "作成するTaskの名前を入力してください"),
      onChanged: handleTitle,
      onSubmitted: widget.handleChange,
    );
  }
}
