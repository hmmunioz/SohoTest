import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sohotest/app/blocs/task/task_event.dart';
import 'package:sohotest/app/blocs/task/task_state.dart';
import 'package:sohotest/app/repository/task_repository.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository taskRepository;
  int nextPage = 0;
  bool isLastPage = false;

  TaskBloc(this.taskRepository) : super(TaskState.initial()) {
    on<LoadTasksEvent>(_onLoadTasks);
    on<AddTaskEvent>(_onAddTask);
    on<UpdateTaskEvent>(_onUpdateTask);
    on<DeleteTaskEvent>(_onDeleteTask);
    on<CompleteOrUncompleteTaskEvent>(_onCompleteOrUncompleteTask);
    on<ChangeFilterEvent>(_onChangeFilter);
    on<CurrentTaskEvent>(_onCurrentTaskEvent);
  }

  Future<void> _onLoadTasks(LoadTasksEvent event, Emitter<TaskState> emit) async {
    emit(state.copyWith(state: TaskStateEnum.loading));

    try {
      final tasks = await taskRepository.getTasks(page: event.page, limit: event.limit, filter: state.currentFilter);
      isLastPage = tasks.isEmpty;

      emit(state.copyWith(
        tasks: event.page == 1 ? tasks : [...state.tasks, ...tasks],
        state: TaskStateEnum.loaded,
      ));
      if (event.page == nextPage) nextPage++;
    } catch (e) {
      emit(state.copyWith(
        state: TaskStateEnum.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onAddTask(AddTaskEvent event, Emitter<TaskState> emit) async {
    emit(state.copyWith(state: TaskStateEnum.updating));

    try {
      await taskRepository.insertTask(event.task);
      nextPage = 1;
      isLastPage = false;
      final tasks = await taskRepository.getTasks(page: nextPage, limit: 20);
      isLastPage = tasks.isEmpty;
      emit(state.copyWith(
        tasks: tasks,
        state: TaskStateEnum.loaded,
      ));
      nextPage++;
    } catch (e) {
      emit(state.copyWith(
        state: TaskStateEnum.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onUpdateTask(UpdateTaskEvent event, Emitter<TaskState> emit) async {
    emit(state.copyWith(state: TaskStateEnum.updating));

    try {
      await taskRepository.updateTask(event.task);
      nextPage = 0;
      isLastPage = false;
      final tasks = await taskRepository.getTasks(page: nextPage, limit: 20);
      isLastPage = tasks.isEmpty;
      emit(state.copyWith(
        tasks: tasks,
        state: TaskStateEnum.loaded,
      ));
    } catch (e) {
      emit(state.copyWith(
        state: TaskStateEnum.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onChangeFilter(ChangeFilterEvent event, Emitter<TaskState> emit) async {
    emit(state.copyWith(
      currentFilter: event.filter,
      tasks: [],
    ));
  }

  Future<void> _onDeleteTask(DeleteTaskEvent event, Emitter<TaskState> emit) async {
    emit(state.copyWith(state: TaskStateEnum.updating));

    try {
      await taskRepository.deleteTask(event.taskId);
      final remainingTasks = state.tasks.where((task) => task.id != event.taskId).toList();

      emit(state.copyWith(
        tasks: remainingTasks,
        state: TaskStateEnum.loaded,
      ));
    } catch (e) {
      emit(state.copyWith(
        state: TaskStateEnum.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onCompleteOrUncompleteTask(CompleteOrUncompleteTaskEvent event, Emitter<TaskState> emit) async {
    emit(state.copyWith(state: TaskStateEnum.updating));

    try {
      await taskRepository.completeOrUncompleteTask(event.taskId);
      nextPage = 1;
      isLastPage = false;
      add(LoadTasksEvent(page: nextPage, limit: 20));
    } catch (e) {
      emit(state.copyWith(
        state: TaskStateEnum.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onCurrentTaskEvent(CurrentTaskEvent event, Emitter<TaskState> emit) async {
    try {
      emit(state.copyWith(currentTask: event.currentTask));
    } catch (e) {
      emit(state.copyWith(
        state: TaskStateEnum.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> fetchTaskStatistics() async {
    try {
      final total = await taskRepository.getTotalTaskCount();
      final completed = await taskRepository.getCompletedTaskCount();
      final pending = await taskRepository.getPendingTaskCount();

      emit(state.copyWith(
        totalTasks: total,
        completedTasks: completed,
        pendingTasks: pending,
      ));
    } catch (e) {
      emit(state.copyWith(
        state: TaskStateEnum.error,
        errorMessage: e.toString(),
      ));
    }
  }

  int getTotalTasks() {
    return state.tasks.length;
  }

  int getCompletedTasks() {
    return state.tasks.where((task) => task.isComplete).length;
  }

  int getPendingTasks() {
    return state.tasks.where((task) => !task.isComplete).length;
  }
}
