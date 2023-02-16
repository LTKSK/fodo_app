enum TaskState {
  todo,
  doing,
  done,
}

TaskState taskStateFromNum(int number) {
  switch (number) {
    case 0:
      return TaskState.todo;
    case 1:
      return TaskState.doing;
    case 2:
      return TaskState.done;
    default:
      // TODO: 独自定義に置き換え
      throw StateError('不明なstateです');
  }
}

int taskStateNumFrom(TaskState state) {
  switch (state) {
    case TaskState.todo:
      return 0;
    case TaskState.doing:
      return 1;
    case TaskState.done:
      return 2;
    default:
      // TODO: 独自定義に置き換え
      throw StateError('不明なstateです');
  }
}

class Task {
  final int id;
  final String title;
  final String description;
  final TaskState state;
  final String createdAt;

  const Task(
      {required this.id,
      required this.title,
      required this.description,
      required this.state,
      required this.createdAt});
}
