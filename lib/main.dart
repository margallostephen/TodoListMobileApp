import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'screens/register.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('accounts');
  await Hive.openBox('tasks');
  runApp(const TodoList());
}

class TodoList extends StatelessWidget {
  const TodoList({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/register',
        routes: {
          '/register': (context) => Register(),
        },
      ),
    );
  }
}
