import 'package:flutter/material.dart';
import '../components/app_bar.dart';
import '../components/style.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final registrationFormKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(
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
              Column(
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  const Text(
                    'Create new account',
                    style: TextStyle(
                      fontSize: 28,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Please fill in the form to continue',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Form(
                    key: registrationFormKey,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      padding: const EdgeInsets.fromLTRB(
                        20,
                        25,
                        20,
                        40,
                      ),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: nameController,
                            decoration: const InputDecoration(
                              labelStyle: TextStyle(
                                color: Style.violet,
                              ),
                              labelText: 'Name',
                              prefixIcon: Icon(Icons.person),
                              prefixIconColor: Style.violet,
                              border: Style.normal,
                              enabledBorder: Style.normal,
                              focusedBorder: Style.focused,
                              focusedErrorBorder: Style.errorFocused,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your name';
                              } else if (value.length < 2) {
                                return 'Name must be at least 3 characters long';
                              } else if (RegExp(r'^[a-zA-Z ]+$')
                                      .hasMatch(value) ==
                                  false) {
                                return 'Name must contain only letters';
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: emailController,
                            decoration: const InputDecoration(
                              labelStyle: TextStyle(
                                color: Style.violet,
                              ),
                              labelText: 'Email',
                              prefixIcon: Icon(Icons.email),
                              prefixIconColor: Style.violet,
                              border: Style.normal,
                              enabledBorder: Style.normal,
                              focusedBorder: Style.focused,
                              focusedErrorBorder: Style.errorFocused,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              } else if (RegExp(
                                          r'^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]+$')
                                      .hasMatch(value) ==
                                  false) {
                                return 'Please enter a valid email';
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: addressController,
                            decoration: const InputDecoration(
                              labelStyle: TextStyle(
                                color: Style.violet,
                              ),
                              labelText: 'Address',
                              prefixIcon: Icon(Icons.home),
                              prefixIconColor: Style.violet,
                              border: Style.normal,
                              enabledBorder: Style.normal,
                              focusedBorder: Style.focused,
                              focusedErrorBorder: Style.errorFocused,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your address';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                              labelStyle: TextStyle(
                                color: Style.violet,
                              ),
                              labelText: 'Password',
                              prefixIcon: Icon(Icons.lock),
                              prefixIconColor: Style.violet,
                              border: Style.normal,
                              enabledBorder: Style.normal,
                              focusedBorder: Style.focused,
                              focusedErrorBorder: Style.errorFocused,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              } else if (value.length < 8) {
                                return 'Password must be at least 8 characters long';
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: confirmPasswordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                              labelStyle: TextStyle(
                                color: Style.violet,
                              ),
                              labelText: 'Confirm Password',
                              prefixIcon: Icon(Icons.sync_lock_rounded),
                              prefixIconColor: Style.violet,
                              border: Style.normal,
                              enabledBorder: Style.normal,
                              focusedBorder: Style.focused,
                              focusedErrorBorder: Style.errorFocused,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password again';
                              } else if (value != passwordController.text) {
                                return 'Passwords do not match';
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Style.violet,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: const Text(
                                'Register',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Wrap(
                            alignment: WrapAlignment.center,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              const Text(
                                'Already have an account?',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: const Text(
                                  'Login',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Style.violet,
                                    fontWeight: FontWeight.bold,
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
