import 'package:flutter/material.dart';
import 'package:sohotest/app/entity_models/task/task_entity.dart';

abstract class TaskDetailInteractor {
  void updateTask(BuildContext context, TaskEntity task);
}
