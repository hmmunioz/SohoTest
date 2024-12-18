import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final VoidCallback onSelected;
  final IconData iconButton;
  final String text;

  const ActionButton({
    required this.onSelected,
    required this.iconButton,
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelected,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: Theme.of(context).secondaryHeaderColor.withOpacity(0.6),
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              iconButton,
              color: Theme.of(context).primaryColorLight,
              size: 20.0,
            ),
            const SizedBox(width: 8.0),
            Text(
              text,
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColorLight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
