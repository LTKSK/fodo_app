enum TaskState {
  todo,
  doing,
  done,
}

TaskState taskStateFrom(String stateStr) {
  switch (stateStr) {
    case "todo":
      return TaskState.todo;
    case "doing":
      return TaskState.doing;
    case "done":
      return TaskState.done;
    default:
      // TODO: 独自定義に置き換え
      throw StateError('不明なstateです');
  }
}

String taskStateStringFrom(TaskState state) {
  switch (state) {
    case TaskState.todo:
      return "todo";
    case TaskState.doing:
      return "doing";
    case TaskState.done:
      return "done";
    default:
      // TODO: 独自定義に置き換え
      throw StateError('不明なstateです');
  }
}

class Task {
  final int? id;
  final String title;
  final String description;
  final TaskState state;

  const Task(
      {this.id,
      required this.title,
      required this.description,
      required this.state});
}
