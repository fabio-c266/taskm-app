import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tasksm_app/components/button.dart';
import 'package:tasksm_app/models/task.dart';
import 'package:tasksm_app/repositories/task_repository.dart';
import 'package:tasksm_app/utils/custom_colors.dart';

class TaskItem extends StatefulWidget {
  final Task _task;
  final Function _updateTasksDoneText;
  final Function(Task task) _deleteTaskInListView;

  const TaskItem(
      {super.key,
      required Task task,
      required Function updateTasksDoneText,
      required Function(Task task) deleteTaskInListView})
      : _task = task,
        _updateTasksDoneText = updateTasksDoneText,
        _deleteTaskInListView = deleteTaskInListView;

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  TaskRepository taskRepository = TaskRepository();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: CustomColors.whiteBackground,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
          key: Key(widget._task.id.toString()),
          tileColor: CustomColors.whiteBackground,
          leading: Transform.scale(
            scale: 2.0,
            child: Checkbox(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                activeColor: Colors.green,
                value: widget._task.isDone,
                onChanged: (value) async {
                  await taskRepository.toggleIsDone(widget._task);

                  setState(() {
                    widget._task.toggleIsDone();
                  });

                  widget._updateTasksDoneText();
                }),
          ),
          title: Text(
            widget._task.title,
            style: GoogleFonts.roboto(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.normal),
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          trailing: IconButton(
            icon: const Icon(
              Icons.delete_outline,
              color: Colors.black,
              size: 32,
            ),
            onPressed: () async {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                        content: Text(
                          'Você realmente deseja deletar essa tarefa?',
                          style: GoogleFonts.roboto(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        insetPadding: const EdgeInsets.all(20),
                        actions: [
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  child: Button(
                                      text: 'Sim',
                                      type: ButtonType.danger,
                                      onPressed: () async {
                                        await taskRepository
                                            .delete(widget._task);
                                        widget._deleteTaskInListView(
                                            widget._task);

                                        Navigator.pop(context);
                                      })),
                              const SizedBox(width: 20),
                              Expanded(
                                  child: Button(
                                      text: 'Não',
                                      type: ButtonType.primary,
                                      onPressed: () {
                                        Navigator.pop(context);
                                      }))
                            ],
                          )
                        ],
                      ));
            },
          )),
    );
  }
}
