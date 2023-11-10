import 'package:flutter/material.dart';
import 'package:todolist_app/model/task.dart';

class NewTask extends StatefulWidget {
  final Function(Task) onTaskSaved;

  const NewTask({Key? key, required this.onTaskSaved}) : super(key: key);

  @override
  State<NewTask> createState() {
    return _NewTaskState();
  }
}

class _NewTaskState extends State<NewTask> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  Category? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Task'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                maxLength: 50,
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                ),
              ),
              const SizedBox(height: 16),
              const Text('Select a Category:'),
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
                      Text(category.toString().split('.').last),
                    ],
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  final title = titleController.text;
                  final description = descriptionController.text;

                  if (title.isNotEmpty && description.isNotEmpty) {
                    final newTask = Task(
                      title: title,
                      description: description,
                      date: selectedDate,
                      category: selectedCategory ?? Category.other, id: '',
                    );

                    widget.onTaskSaved(newTask);
                  } else {
                    // Show an error message or handle the empty fields
                  }
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
