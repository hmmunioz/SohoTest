import 'package:equatable/equatable.dart';
import 'package:sohotest/app/entity_models/task/task_entity.dart';
import 'package:sohotest/app/enums/filter_enum.dart';

enum TaskStateEnum { initial, loading, loaded, updating, completed, error }

class TaskState extends Equatable {
  final List<TaskEntity> tasks;
  final int totalTasks;
  final int completedTasks;
  final int pendingTasks;
  final FilterEnum currentFilter;
  final TaskStateEnum state;
  final String? errorMessage;
  final bool isLastPage;
  final TaskEntity? currentTask;

  const TaskState({
    required this.tasks,
    this.totalTasks = 0,
    this.completedTasks = 0,
    this.pendingTasks = 0,
    required this.state,
    this.errorMessage,
    this.currentFilter = FilterEnum.all,
    this.isLastPage = false,
    this.currentTask,
  });

  factory TaskState.initial() {
    return const TaskState(
      tasks: [],
      state: TaskStateEnum.initial,
      currentFilter: FilterEnum.all,
      errorMessage: null,
      isLastPage: false,
      currentTask: null,
    );
  }

  TaskState copyWith({
    List<TaskEntity>? tasks,
    int? totalTasks,
    int? completedTasks,
    int? pendingTasks,
    TaskStateEnum? state,
    String? errorMessage,
    FilterEnum? currentFilter,
    bool? isLastPage,
    TaskEntity? currentTask,
  }) {
    return TaskState(
      tasks: tasks ?? this.tasks,
      totalTasks: totalTasks ?? this.totalTasks,
      completedTasks: completedTasks ?? this.completedTasks,
      pendingTasks: pendingTasks ?? this.pendingTasks,
      state: state ?? this.state,
      errorMessage: errorMessage ?? this.errorMessage,
      currentFilter: currentFilter ?? this.currentFilter,
      isLastPage: isLastPage ?? this.isLastPage,
      currentTask: currentTask ?? this.currentTask,
    );
  }

  @override
  List<Object?> get props => [
        tasks,
        totalTasks,
        completedTasks,
        pendingTasks,
        currentFilter,
        state,
        errorMessage,
        isLastPage,
        currentTask,
      ];
}
