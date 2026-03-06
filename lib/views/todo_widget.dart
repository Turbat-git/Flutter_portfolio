import 'package:flutter/material.dart';
import '../models/todo.dart' show Todo;

class TodoWidget extends StatefulWidget {
  final Todo todo;
  const TodoWidget({super.key, required this.todo});

  @override
  State<TodoWidget> createState() => _TodoWidgetState();
}

class _TodoWidgetState extends State<TodoWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: widget.todo.complete ? Colors.green : Colors.orange,
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(widget.todo.name),
                  Text(widget.todo.description),
                ],
              ),
            ),
            Checkbox(value: widget.todo.complete, onChanged: (value) {}),
          ],
        ),
      ),
    );
  }
}
