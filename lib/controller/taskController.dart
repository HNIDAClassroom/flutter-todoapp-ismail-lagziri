import 'dart:convert';
import 'package:file/file.dart';
import 'package:file/local.dart';
import 'package:todolist_app/models/task.dart';

class TaskController {
  final LocalFileSystem localFileSystem = LocalFileSystem();
  
  // Specify the target file path
  final String filePath = 'E:\\tasks.json';

  Future<List<Task>> loadTasks() async {
    File file = localFileSystem.file(filePath);

    if (!await file.exists()) {
      return [];
    }

    String jsonContent = await file.readAsString();
    List<dynamic> tasksData = json.decode(jsonContent);

    List<Task> tasks = tasksData.map((data) => Task.fromJson(data)).toList();

    return tasks;
  }

  Future<void> saveTasks(List<Task> tasks) async {
    File file = localFileSystem.file(filePath);
    List<Map<String, dynamic>> tasksData = tasks.map((task) => task.toJson()).toList();
    String jsonString = json.encode(tasksData);

    await file.writeAsString(jsonString);
  }
}
