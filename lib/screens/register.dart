import 'package:flutter/material.dart';
import '../components/app_bar.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(
        255,
        54,
        23,
        94,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              CustomAppBar(
                title: 'Register',
                icon: Icons.person_add_alt_1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
