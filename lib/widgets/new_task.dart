import 'package:flutter/material.dart';
import 'package:todolist_app/models/task.dart';

class NewTask extends StatefulWidget {
  final Function(Task) onTaskSaved; // Add the onTaskSaved callback

  NewTask({Key? key, required this.onTaskSaved}) : super(key: key);

  @override
  State<NewTask> createState() {
    return _NewTaskState();
  }
}

class _NewTaskState extends State<NewTask> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  Category? selectedCategory; // Use Category? to represent a nullable selected category

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Task'),
      ),
      body: SingleChildScrollView(
        // Wrap the Column with a SingleChildScrollView
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                maxLength: 50,
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                ),
              ),
              SizedBox(height: 16),
              Text('Select a Category:'),
              Column(
                children: Category.values.map((category) {
                  return Row(
                    children: [
                      Checkbox(
                        value: selectedCategory == category,
                        onChanged: (value) {
                          setState(() {
                            if (value!) {
                              selectedCategory = category;
                            }
                          });
                        },
                      ),
                      Text(category.toString().split('.').last), // Display the category name
                    ],
                  );
                }).toList(),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  final Task newTask = Task(
                    title: titleController.text,
                    description: descriptionController.text,
                    date: selectedDate,
                    category: selectedCategory ?? Category.other,
                  );

                  // You can add your logic here to save the new task, e.g., to a database.
                  print('You pressed Save');
                  print('New Task: ${newTask.title}, ${newTask.description}, ${newTask.date}, ${newTask.category}');
                },
                child: const Text('Save Task'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
