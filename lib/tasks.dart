import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todolist_app/services/firestore.dart';
import 'package:todolist_app/tasks_list.dart';
import 'package:todolist_app/widgets/new_task.dart';

class Tasks extends StatefulWidget {
  const Tasks({Key? key}) : super(key: key);

  @override
  State<Tasks> createState() {
    return _TasksState();
  }
}

class _TasksState extends State<Tasks> {
  void _logout() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ismail\'s ToDoList'),
        actions: [
          IconButton(
            onPressed: () {
              _openAddTaskOverlay(context);
            },
            icon: const Icon(Icons.add, color: Colors.black),
          ),
          IconButton(
            onPressed: _logout,
            icon: const Icon(Icons.logout, color: Colors.black),
          ),
        ],
      ),
      body: TasksList(),
    );
  }

  void _openAddTaskOverlay(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return NewTask(onTaskSaved: (task) async {
          final taskId = await FirestoreService().addTask(task);
          task.id = taskId;
          Navigator.of(context).pop();
        });
      },
    );
  }
}
