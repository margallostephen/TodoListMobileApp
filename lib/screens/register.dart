import 'package:flutter/material.dart';
import '../components/app_bar.dart';
import '../components/notif.dart';
import '../components/style.dart';
import 'package:hive/hive.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final accounts = Hive.box('accounts');
  List<Map<String, dynamic>> emails = [];

  final registrationFormKey = GlobalKey<FormState>();
  AutovalidateMode validateMode = AutovalidateMode.disabled;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool passVisibility = true,
      confirmPassVisibility = true,
      showPassButton = false,
      showConfirmPassButton = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() {
    final data = accounts.keys.map((key) {
      final item = accounts.get(key);
      return {
        'email': item['email'],
      };
    }).toList();

    setState(() {
      emails = data.reversed.toList();
    });
  }

  bool validateEmail() {
    for (var i = 0; i < emails.length; i++) {
      if (emails[i]['email'] == emailController.text) {
        return false;
      }
    }
    return true;
  }

  void createAccount() {
    accounts.add({
      'name': nameController.text,
      'email': emailController.text,
      'address': addressController.text,
      'password': passwordController.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    IconData visibilityIcon =
        (passVisibility) ? Icons.visibility_off : Icons.visibility;
    IconData confirmVisibilityIcon =
        (confirmPassVisibility) ? Icons.visibility_off : Icons.visibility;

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
                    autovalidateMode: validateMode,
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
                              labelText: 'Please Enter Your Name',
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
                              } else if (value.length < 3) {
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
                              labelText: 'Enter Your Email',
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
                              }  else if (!validateEmail()) {
                                return 'Email already exists';
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
                          FocusScope(
                            child: Focus(
                              onFocusChange: (hasFocus) {
                                (hasFocus)
                                    ? setState(() {
                                        showPassButton = true;
                                      })
                                    : setState(() {
                                        showPassButton = false;
                                        passVisibility = true;
                                      });
                              },
                              child: TextFormField(
                                controller: passwordController,
                                obscureText: passVisibility,
                                decoration: InputDecoration(
                                  labelStyle: const TextStyle(
                                    color: Style.violet,
                                  ),
                                  labelText: 'Enter your password',
                                  prefixIcon: const Icon(Icons.lock),
                                  prefixIconColor: Style.violet,
                                  border: Style.normal,
                                  enabledBorder: Style.normal,
                                  focusedBorder: Style.focused,
                                  focusedErrorBorder: Style.errorFocused,
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        passVisibility = !passVisibility;
                                      });
                                    },
                                    child: Visibility(
                                      visible: showPassButton,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: Icon(
                                          visibilityIcon,
                                          color: Style.violet,
                                        ),
                                      ),
                                    ),
                                  ),
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
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          FocusScope(
                            child: Focus(
                              onFocusChange: (hasFocus) {
                                (hasFocus)
                                    ? setState(() {
                                        showConfirmPassButton = true;
                                      })
                                    : setState(() {
                                        showConfirmPassButton = false;
                                        confirmPassVisibility = true;
                                      });
                              },
                              child: TextFormField(
                                controller: confirmPasswordController,
                                obscureText: confirmPassVisibility,
                                decoration: InputDecoration(
                                  labelStyle: const TextStyle(
                                    color: Style.violet,
                                  ),
                                  labelText: 'Confirm Password',
                                  prefixIcon:
                                      const Icon(Icons.sync_lock_rounded),
                                  prefixIconColor: Style.violet,
                                  border: Style.normal,
                                  enabledBorder: Style.normal,
                                  focusedBorder: Style.focused,
                                  focusedErrorBorder: Style.errorFocused,
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        confirmPassVisibility =
                                            !confirmPassVisibility;
                                      });
                                    },
                                    child: Visibility(
                                      visible: showConfirmPassButton,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: Icon(
                                          confirmVisibilityIcon,
                                          color: Style.violet,
                                        ),
                                      ),
                                    ),
                                  ),
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
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                if (registrationFormKey.currentState!
                                    .validate()) {
                                  createAccount();
                                  Notif.showMessage(
                                      'Account Successfully Created',
                                      Colors.green[600],
                                      context);
                                  Navigator.pop(context);
                                } else {
                                  setState(() {
                                    validateMode = AutovalidateMode.always;
                                  });
                                }
                              },
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
                                onPressed: () {
                                  Navigator.pop(context);
                                },
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
                  const SizedBox(
                    height: 20,
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
