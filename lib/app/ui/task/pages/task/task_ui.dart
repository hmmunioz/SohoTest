import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:go_router/go_router.dart';
import 'package:sohotest/app/blocs/task/task_state.dart';
import 'package:sohotest/app/common_widgets/show_custom_modal.dart';
import 'package:sohotest/app/enums/filter_enum.dart';
import 'package:sohotest/app/ui/task/widgets/add_button.dart';
import 'package:sohotest/app/ui/task/widgets/add_dialog.dart';
import 'package:sohotest/app/ui/task/widgets/confirm_dialog.dart';
import 'package:sohotest/app/ui/task/widgets/filter_list.dart';
import 'package:sohotest/app/ui/task/widgets/task_card.dart';
import 'package:sohotest/app/ui/task/widgets/task_list.dart';
import 'package:sohotest/app/ui/task/widgets/user_header.dart';

import 'task_interactor.dart';

class TaskUI extends StatefulWidget {
  final TaskInteractor taskInteractor;
  final TaskState state;

  const TaskUI(this.taskInteractor, this.state, {super.key});

  @override
  _TaskUIState createState() => _TaskUIState();
}

class _TaskUIState extends State<TaskUI> {
  int totalTasks = 0;
  int completedTasks = 0;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    if (mounted) {
      widget.taskInteractor.changeFilter(context, FilterEnum.all);
      _loadTaskStatistics();
    }
  }

  Future<void> _loadTaskStatistics() async {
    final total = await widget.taskInteractor.getTotalTasks(context);
    final completed = await widget.taskInteractor.getCompletedTasks(context);

    if (mounted) {
      setState(() {
        totalTasks = total;
        completedTasks = completed;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFF5F5DC),
                  Color(0xFFE0D7B5),
                  Color(0xFFF5F5DC),
                  Color(0xFFE0D7B5),
                ],
              ),
            ),
          ),
          Column(
            children: [
              UserHeader(
                totalTasks: totalTasks,
                completedTasks: completedTasks,
              ),
              ActionButton(
                onSelected: () => showCustomModal(
                  context,
                  child: AddDialog(
                    onTaskAdded: (String taskName, String taskDescription) async {
                      widget.taskInteractor.addTask(context, taskName, taskDescription);
                      context.pop();
                      await _loadTaskStatistics();
                    },
                  ),
                ),
                iconButton: Icons.add,
                text: translate('add'),
              ),
              FilterList(
                taskInteractor: widget.taskInteractor,
                taskState: widget.state,
              ),
              Expanded(
                child: TaskList(
                  tasks: widget.state.tasks,
                  isLastPage: widget.taskInteractor.isLastPage(context),
                  onLoadingMore: () async {
                    await widget.taskInteractor.loadMoreTasks(context);
                    await _loadTaskStatistics();
                  },
                  taskBuilder: (task) => TaskCard(
                      title: task.title,
                      subtitle: task.date.toString(),
                      isComplete: task.isComplete,
                      onDelete: () {
                        showCustomModal(
                          context,
                          child: ConfirmDialog(
                            title: translate('are_you_sure'),
                            onConfirm: () async {
                              widget.taskInteractor.deleteTask(context, task.id!);
                              await _loadTaskStatistics();
                            },
                          ),
                        );
                      },
                      onEdit: () async {
                        widget.taskInteractor.selectTask(context, task);
                        context.goNamed('task_detail_page');
                      },
                      onComplete: () {
                        widget.taskInteractor.completeOrUncompleteTask(context, task.id!);
                      }),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
