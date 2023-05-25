import 'package:flutter/material.dart';
import '../components/app_bar.dart';

class TaskForm extends StatefulWidget {
  const TaskForm({super.key});

  @override
  State<TaskForm> createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  dynamic arguments;

  final taskFormKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  IconData? icon;

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    arguments = ModalRoute.of(context)?.settings.arguments;
    arguments['operation'] == "Add Task" ? icon = Icons.add : icon = Icons.edit;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 54, 23, 94),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: 20,
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              CustomAppBar(
                title: arguments['operation'],
                icon: icon,
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
