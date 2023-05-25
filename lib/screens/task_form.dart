import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../components/app_bar.dart';
import '../components/notif.dart';
import '../components/style.dart';

class TaskForm extends StatefulWidget {
  const TaskForm({super.key});

  @override
  State<TaskForm> createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  dynamic arguments;
  final taskFormKey = GlobalKey<FormState>();
  AutovalidateMode validateMode = AutovalidateMode.disabled;
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  int sateCount = 0;
  IconData? icon;

  @override
  initState() {
    super.initState();
  }

  void addTask() {
    arguments['tasks'].add({
      'name': nameController.text,
      'description': descriptionController.text,
      'date': dateController.text,
      'userKey': arguments['userKey'],
    });
  }

  void editTask() {
    arguments['tasks'].put(arguments['key'], {
      'name': nameController.text,
      'description': descriptionController.text,
      'date': dateController.text,
      'userKey': arguments['userKey'],
    });
  }

  @override
  Widget build(BuildContext context) {
    arguments = ModalRoute.of(context)?.settings.arguments;
    arguments['operation'] == "Add Task" ? icon = Icons.add : icon = Icons.edit;

    if (arguments['operation'] == "Edit Task" && sateCount == 0) {
      nameController.text = arguments['name'];
      descriptionController.text = arguments['description'];
      dateController.text = arguments['date'];
      sateCount++;
    }

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
              Form(
                key: taskFormKey,
                autovalidateMode: validateMode,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  padding: const EdgeInsets.fromLTRB(20, 25, 20, 25),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          labelStyle: TextStyle(
                            color: Style.violet,
                          ),
                          labelText: 'Name',
                          prefixIcon: Icon(Icons.task),
                          prefixIconColor: Style.violet,
                          border: Style.normal,
                          enabledBorder: Style.normal,
                          focusedBorder: Style.focused,
                          focusedErrorBorder: Style.errorFocused,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a task';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: descriptionController,
                        decoration: const InputDecoration(
                          labelStyle: TextStyle(
                            color: Style.violet,
                          ),
                          labelText: 'Description',
                          prefixIcon: Icon(Icons.description),
                          prefixIconColor: Style.violet,
                          border: Style.normal,
                          enabledBorder: Style.normal,
                          focusedBorder: Style.focused,
                          focusedErrorBorder: Style.errorFocused,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a description';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: dateController,
                        decoration: const InputDecoration(
                          labelStyle: TextStyle(
                            color: Style.violet,
                          ),
                          labelText: 'Date',
                          prefixIcon: Icon(Icons.calendar_month_outlined),
                          prefixIconColor: Style.violet,
                          border: Style.normal,
                          enabledBorder: Style.normal,
                          focusedBorder: Style.focused,
                          focusedErrorBorder: Style.errorFocused,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a date';
                          } else {
                            return null;
                          }
                        },
                        readOnly: true,
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(
                              const Duration(days: 10000),
                            ),
                            builder: (context, child) => Theme(
                                data: ThemeData().copyWith(
                                    colorScheme: const ColorScheme.dark(
                                      primary: Colors.white,
                                      onPrimary: Style.violet,
                                      surface: Style.violet,
                                      onSurface: Colors.white,
                                    ),
                                    dialogBackgroundColor: Style.violet),
                                child: child!),
                          );
                          if (pickedDate != null) {
                            setState(
                              () {
                                dateController.text =
                                    DateFormat('dd-MMM-yyyy').format(
                                  DateTime.parse(
                                    pickedDate.toString(),
                                  ),
                                );
                              },
                            );
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                  Colors.red,
                                ),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(12),
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(fontSize: 17),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                if (taskFormKey.currentState!.validate()) {
                                  String message;
                                  if (arguments['operation'] == "Add Task") {
                                    addTask();
                                    message = 'New task added';
                                  } else {
                                    editTask();
                                    message =
                                        'Task ${arguments['name']} updated';
                                  }
                                  Notif.showMessage(
                                    message,
                                    Colors.green[600],
                                    context,
                                  );
                                  Navigator.pop(context);
                                } else {
                                  setState(() {
                                    validateMode = AutovalidateMode.always;
                                  });
                                }
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                  Style.violet,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: arguments['operation'] == 'Add Task'
                                    ? const Text(
                                        "Add",
                                        style: TextStyle(fontSize: 17),
                                      )
                                    : const Text(
                                        "Save",
                                        style: TextStyle(fontSize: 17),
                                      ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
