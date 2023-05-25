import 'package:flutter/material.dart';
import '../components/app_bar.dart';
import 'package:hive/hive.dart';
import '../components/style.dart';

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
            Expanded(
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 10, bottom: 15),
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: countCurrentUserTask() == 0
                    ? const Center(
                        child: Text(
                          'No Task Added Yet',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: taskData.length,
                        itemBuilder: (context, index) {
                          final task = taskData[index];
                          if (task['userKey'] == userKey) {
                            return Dismissible(
                              direction: DismissDirection.startToEnd,
                              key: Key(task['key'].toString()),
                              onDismissed: (_) {
                                // TODO: Delete Task
                              },
                              background: Container(
                                margin: const EdgeInsets.fromLTRB(
                                  5,
                                  5,
                                  5,
                                  10,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.red,
                                ),
                                alignment: Alignment.centerLeft,
                                child: const Padding(
                                  padding: EdgeInsets.only(left: 20),
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              child: Card(
                                margin: const EdgeInsets.fromLTRB(
                                  5,
                                  5,
                                  5,
                                  10,
                                ),
                                elevation: 10,
                                shadowColor: Colors.black,
                                child: ListTile(
                                  leading: Container(
                                    width: 70,
                                    height: 100,
                                    decoration: const BoxDecoration(
                                      color: Style.violet,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(5),
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          task['date'].substring(0, 2),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          task['date']
                                              .replaceAll('-', ' ')
                                              .substring(
                                                3,
                                                task['date'].toString().length,
                                              ),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  title: Padding(
                                    padding: const EdgeInsets.only(
                                      top: 10,
                                      bottom: 5,
                                    ),
                                    child: Text(
                                      task['name'],
                                      style: const TextStyle(
                                        color: Style.violet,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 10,
                                    ),
                                    child: Text(
                                      task['description'],
                                      style: const TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  trailing: GestureDetector(
                                    onTap: () {
                                      // TODO: Edit Task
                                    },
                                    child: const Icon(
                                      Icons.edit,
                                      color: Style.violet,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
