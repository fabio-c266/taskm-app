import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tasksm_app/components/add_task_modal.dart';
import 'package:tasksm_app/components/no_tasks.dart';
import 'package:tasksm_app/components/task_item.dart';
import 'package:tasksm_app/models/task.dart';
import 'package:tasksm_app/repositories/task_repository.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TaskRepository taskRepository = TaskRepository();
  List<Task> _userTasks = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getAllTasks();
  }

  Future<void> _getAllTasks() async {
    if (!_isLoading) setState(() => _isLoading = true);
    _userTasks = await taskRepository.findAllTasks();
    setState(() => _isLoading = false);
  }

  _addTasksListView(Task task) {
    setState(() {
      _userTasks.add(task);
    });
  }

  _updateTasksDoneText() {
    setState(() {});
  }

  _deleteTaskInListView(Task task) {
    setState(() {
      _userTasks.remove(task);
    });
  }

  _findTaskByTitle(String title) {
    return (_userTasks.where((task) => task.title == title)).isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
          title: const Text("TasksM"),
          centerTitle: true,
          titleTextStyle: GoogleFonts.roboto(
            color: Colors.black,
            fontSize: 28,
            fontWeight: FontWeight.w900,
          ),
          shape: Border.all(
            color: Colors.black,
            width: 0.1,
          ),
        ),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator.adaptive())
            : (_userTasks.isEmpty
                ? const NoTasks()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 22, vertical: 22),
                          child: Text(
                            "Concluídas: ${_userTasks.where((task) => task.isDone).length}",
                            style: GoogleFonts.roboto(
                                fontSize: 16, fontWeight: FontWeight.w900),
                          )),
                      Expanded(
                          child: ListView.separated(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 10, bottom: 80),
                              itemCount: _userTasks.length,
                              itemBuilder: (context, index) {
                                return TaskItem(
                                  task: _userTasks[index],
                                  updateTasksDoneText: _updateTasksDoneText,
                                  deleteTaskInListView: _deleteTaskInListView,
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      const SizedBox(
                                        height: 18,
                                      )))
                    ],
                  )),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.lightBlueAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          child: const Icon(Icons.add, color: Colors.white, size: 40),
          onPressed: () {
            showModalBottomSheet(
                context: context,
                isDismissible: false,
                isScrollControlled: true,
                builder: (context) => AddTaskModal(
                      updateTasksListView: _addTasksListView,
                      findTaskByTitle: _findTaskByTitle,
                    ));
          },
        ),
      ),
    );
  }
}
