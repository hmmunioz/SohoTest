import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:go_router/go_router.dart';
import 'package:sohotest/app/ui/task/widgets/add_button.dart';

class AddDialog extends StatefulWidget {
  final Function(String name, String description) onTaskAdded;

  const AddDialog({
    super.key,
    required this.onTaskAdded,
  });

  @override
  _AddDialogState createState() => _AddDialogState();
}

class _AddDialogState extends State<AddDialog> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  void _submitTask() {
    final taskName = _nameController.text.trim();
    final taskDescription = _descriptionController.text.trim();

    if (taskName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(translate('task_name_required'))),
      );
      return;
    }

    widget.onTaskAdded(taskName, taskDescription);
    _nameController.clear();
    _descriptionController.clear();
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                translate('enter_task_name'),
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColorDark,
                ),
              ),
              const SizedBox(height: 8.0),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: translate('task_name_placeholder'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 8.0,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                translate('enter_task_description'),
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).primaryColorDark,
                ),
              ),
              const SizedBox(height: 8.0),
              TextField(
                controller: _descriptionController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: translate('task_description_placeholder'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 12.0,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Align(
                alignment: Alignment.centerRight,
                child: ActionButton(
                  onSelected: _submitTask,
                  iconButton: Icons.add,
                  text: translate('add'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
