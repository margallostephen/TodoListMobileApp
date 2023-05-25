import 'package:flutter/material.dart';
import '../components/app_bar.dart';
import 'package:hive/hive.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  dynamic arguments;
  String? userKey;
  List<Map<String, dynamic>> taskData = [];
  final tasks = Hive.box('tasks');

  @override
  initState() {
    super.initState();
    getData();
  }

  void getData() {
    final data = tasks.keys.map((key) {
      final item = tasks.get(key);
      return {
        'key': key,
        'name': item['name'],
        'description': item['description'],
        'date': item['date'],
        'userKey': item['userKey'],
      };
    }).toList();
    setState(() {
      taskData = data.reversed.toList();
    });
  }

  int countCurrentUserTask() {
    int count = 0;
    for (var i = 0; i < taskData.length; i++) {
      if (taskData[i]['userKey'] == userKey) {
        count++;
      }
    }
    return count;
  }

  @override
  Widget build(BuildContext context) {
    arguments = ModalRoute.of(context)!.settings.arguments;
    userKey = arguments['userKey'];
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 54, 23, 94),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            CustomAppBar(
              title: 'My Todo List',
              icon: Icons.edit_document,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Welcome ${arguments['name']}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Task Count: ${countCurrentUserTask()}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
