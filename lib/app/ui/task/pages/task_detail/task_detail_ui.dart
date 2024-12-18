import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:go_router/go_router.dart';
import 'package:sohotest/app/blocs/task/task_state.dart';
import 'package:sohotest/app/entity_models/task/task_entity.dart';
import 'package:sohotest/app/ui/task/widgets/add_button.dart';

import 'task_detail_interactor.dart';

class TaskDetailUI extends StatefulWidget {
  final TaskDetailInteractor taskDetailInteractor;
  final TaskState state;

  const TaskDetailUI(this.taskDetailInteractor, this.state, {super.key});

  @override
  _TaskDetailUIState createState() => _TaskDetailUIState();
}

class _TaskDetailUIState extends State<TaskDetailUI> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(
      text: widget.state.currentTask?.title ?? "",
    );
    _descriptionController = TextEditingController(
      text: widget.state.currentTask?.description ?? "",
    );
  }

  void _saveTask() {
    final updatedTitle = _titleController.text.trim();
    final updatedDescription = _descriptionController.text.trim();

    if (updatedTitle.isEmpty || updatedDescription.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(translate('empty_data'))),
      );
      return;
    }
    final taskUpdated = TaskEntity(
      id: widget.state.currentTask?.id,
      title: updatedTitle,
      description: updatedDescription,
      date: DateTime.now(),
      isComplete: false,
    );

    widget.taskDetailInteractor.updateTask(context, taskUpdated);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(translate('Task updated successfully.'))),
    );

    context.goNamed('task_page');
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
              const SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      translate('edit_task'),
                      style: const TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        labelText: translate('title'),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextField(
                      controller: _descriptionController,
                      maxLines: 4,
                      decoration: InputDecoration(
                        labelText: translate('description'),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ActionButton(
                        onSelected: _saveTask,
                        iconButton: Icons.add,
                        text: translate('save'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
