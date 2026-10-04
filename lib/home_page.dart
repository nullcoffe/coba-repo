import 'package:flutter/material.dart';
import 'model.dart';
import 'add_task_page.dart';
import 'widgets/task_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Task> _tasks = [];

  Future<void> _openAddPage() async {
    final title = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (_) => const AddTaskPage()),
    );
    if (title != null && title.trim().isNotEmpty) {
      setState(() => _tasks.add(Task(title.trim())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('To-Do List')),
      body: _tasks.isEmpty
          ? const Center(child: Text('Belum ada tugas'))
          : ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, i) {
                final task = _tasks[i];
                return TaskTile(
                  task: task,
                  onToggle: () => setState(() => task.isDone = !task.isDone),
                  onDelete: () => setState(() => _tasks.removeAt(i)),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddPage,
        child: const Icon(Icons.add),
      ),
    );
  }
}