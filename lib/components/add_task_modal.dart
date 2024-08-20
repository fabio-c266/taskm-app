import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tasksm_app/components/button.dart';
import 'package:tasksm_app/models/task.dart';
import 'package:tasksm_app/repositories/task_repository.dart';

class AddTaskModal extends StatefulWidget {
  final Function(Task task) _updateTasksListView;
  final Function(String title) _findTaskByTitle;

  const AddTaskModal(
      {super.key,
      required Function(Task task) updateTasksListView,
      required Function(String title) findTaskByTitle})
      : _updateTasksListView = updateTasksListView,
        _findTaskByTitle = findTaskByTitle;

  @override
  State<AddTaskModal> createState() => _AddTaskModalState();
}

class _AddTaskModalState extends State<AddTaskModal> {
  final _formKey = GlobalKey<FormState>();
  String _textForm = "";
  TaskRepository taskRepository = TaskRepository();

  _createTask() async {
    Task task = await taskRepository.create(_textForm);
    widget._updateTasksListView(task);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.48,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        child: Form(
          key: _formKey,
          child: Column(children: [
            Text("Adicionar Tarefa",
                style: GoogleFonts.roboto(
                    fontSize: 24, fontWeight: FontWeight.w900)),
            const SizedBox(height: 80),
            TextFormField(
              autocorrect: false,
              decoration: InputDecoration(
                hintText: "Título da tarefa",
                filled: true,
                fillColor: Colors.white,
                hintStyle: GoogleFonts.roboto(fontWeight: FontWeight.w300),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Preencha o campo';
                }

                if (value.length < 3) {
                  return 'É necesário por o menos 3 letras';
                }

                if (value.length > 50) {
                  return 'A tarefa não pode ser maior que 50 letras';
                }

                if (widget._findTaskByTitle(value)) {
                  return 'Já possui uma tarefa com esse título';
                }

                return null;
              },
              onChanged: (text) {
                _textForm = text;
              },
            ),
            const SizedBox(height: 80),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Button(
                    text: "Cancelar",
                    type: ButtonType.danger,
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                Button(
                    text: "Adicionar",
                    type: ButtonType.primary,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _createTask();
                        Navigator.pop(context);
                      }
                    }),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
