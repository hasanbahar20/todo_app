import 'package:flutter/material.dart';
import 'package:todo/database/local_storage.dart';
import 'package:todo/main.dart';
import 'package:todo/models/task_model.dart';
import 'package:intl/intl.dart';

class TaskItem extends StatefulWidget {
  final Task task;
  const TaskItem({Key? key, required this.task}) : super(key: key);

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  final TextEditingController _taskNameController = TextEditingController();
  late LocalStorage  _localStorage;
  @override
  void initState() {
    super.initState();
    _localStorage = locator<LocalStorage>();

  }

  @override
  Widget build(BuildContext context) {
    _taskNameController.text = widget.task.name;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
          ),
        ],
      ),
      child: ListTile(
        trailing: GestureDetector(
          onTap: () {
            widget.task.isCompleted = !widget.task.isCompleted;
            _localStorage.updateTask(task: widget.task);
            setState(() {});
          },
          child: Container(
            child: const Icon(
              Icons.check_circle,
              color: Colors.white,
            ),
            decoration: BoxDecoration(
              color: widget.task.isCompleted ? Colors.green : Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black, width: 1),
            ),
          ),
        ),
        title: widget.task.isCompleted
            ? Text(
                widget.task.name,
                style: const TextStyle(
                    decoration: TextDecoration.lineThrough,
                    color: Colors.blueGrey),
              )
            : TextField(
                controller: _taskNameController,
                minLines: 1,
                maxLines: 2,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(border: InputBorder.none),
                onSubmitted: (value) {
                  widget.task.name = value;
                  _localStorage.updateTask(task: widget.task);
                },
              ),
        leading: Text(
          DateFormat('hh:mm a').format(widget.task.createdTask),
          style: const TextStyle(fontSize: 10, color: Colors.blueGrey),
        ),
      ),
    );
  }
}
