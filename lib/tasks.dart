import 'package:flutter/material.dart';
import 'package:todolist_app/models/task.dart';
import 'package:todolist_app/widgets/new_task.dart';
import 'package:todolist_app/controller/taskController.dart';

class Tasks extends StatefulWidget {
  const Tasks({Key? key}) : super(key: key);

  @override
  State<Tasks> createState() {
    return _TasksState();
  }
}

class _TasksState extends State<Tasks> {
  final TaskController _taskHelper = TaskController();
  List<Task> _registeredTasks = [];

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  void _loadTasks() async {
    final tasks = await _taskHelper.loadTasks();
    setState(() {
      _registeredTasks = tasks;
    });
  }

  void _saveTasks() async {
    await _taskHelper.saveTasks(_registeredTasks);
  }

  void _openAddTaskOverlay() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => NewTask(onTaskSaved: _addTask), // Pass the callback
    );
  }

  void _addTask(Task newTask) {
    setState(() {
      _registeredTasks.add(newTask);
    });
    print('Task added: ${newTask.title}, ${newTask.description}, ${newTask.date}, ${newTask.category}'); // Debugging output
    _saveTasks(); // Save the updated list to the JSON file
    print('Tasks saved.'); // Debugging output
    Navigator.of(context).pop(); // Close the "New Task" overlay
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter ToDoList'),
        actions: [
          IconButton(
            onPressed: _openAddTaskOverlay,
            icon: const Icon(Icons.add, color: Colors.black),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _registeredTasks.length,
        itemBuilder: (context, index) {
          Task task = _registeredTasks[index];
          return ListTile(
            title: Text(task.title),
            subtitle: Text(task.description),
          );
        },
      ),
    );
  }
}
