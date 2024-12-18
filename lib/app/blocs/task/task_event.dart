import 'package:sohotest/app/entity_models/task/task_entity.dart';
import 'package:sohotest/app/enums/filter_enum.dart';

abstract class TaskEvent {}

class LoadTasksEvent extends TaskEvent {
  final int page;
  final int limit;
  LoadTasksEvent({
    required this.page,
    this.limit = 20,
  });
}

class AddTaskEvent extends TaskEvent {
  final TaskEntity task;

  AddTaskEvent(this.task);
}

class UpdateTaskEvent extends TaskEvent {
  final TaskEntity task;

  UpdateTaskEvent(this.task);
}

class DeleteTaskEvent extends TaskEvent {
  final int taskId;

  DeleteTaskEvent(this.taskId);
}

class CompleteOrUncompleteTaskEvent extends TaskEvent {
  final int taskId;

  CompleteOrUncompleteTaskEvent(this.taskId);
}

class ChangeFilterEvent extends TaskEvent {
  final FilterEnum filter;

  ChangeFilterEvent(this.filter);
}

class CurrentTaskEvent extends TaskEvent {
  final TaskEntity currentTask;

  CurrentTaskEvent(this.currentTask);
}
