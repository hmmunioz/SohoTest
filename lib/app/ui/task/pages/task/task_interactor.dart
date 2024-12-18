import 'package:flutter/material.dart';
import 'package:sohotest/app/entity_models/task/task_entity.dart';
import 'package:sohotest/app/enums/filter_enum.dart';

abstract class TaskInteractor {
  Future<void> loadMoreTasks(
    BuildContext context,
  );
  void addTask(BuildContext context, String taskName, String descriptionName);
  void updateTask(BuildContext context, String taskName, String descriptionName);
  void completeOrUncompleteTask(BuildContext context, int taskId);
  void deleteTask(BuildContext context, int taskId);
  void selectTask(BuildContext context, TaskEntity task);
  Future<int> getTotalTasks(
    BuildContext context,
  );
  Future<int> getCompletedTasks(
    BuildContext context,
  );
  void changeFilter(BuildContext context, FilterEnum filter);
  bool isLastPage(BuildContext context);
}
