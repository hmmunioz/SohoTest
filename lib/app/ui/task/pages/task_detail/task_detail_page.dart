import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sohotest/app/blocs/task/task_bloc.dart';
import 'package:sohotest/app/blocs/task/task_event.dart';
import 'package:sohotest/app/blocs/task/task_state.dart';
import 'package:sohotest/app/entity_models/task/task_entity.dart';

import 'task_detail_interactor.dart';
import 'task_detail_ui.dart';

class TaskDetailPage extends StatelessWidget implements TaskDetailInteractor {
  const TaskDetailPage({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskBloc, TaskState>(
      listener: (context, state) {
        if (state.state == TaskStateEnum.loading) {}
      },
      builder: (context, state) {
        return TaskDetailUI(this, state);
      },
    );
  }

  @override
  void updateTask(BuildContext context, TaskEntity task) {
    final taskBloc = BlocProvider.of<TaskBloc>(context, listen: false);
    taskBloc.add(UpdateTaskEvent(task));
  }
}
