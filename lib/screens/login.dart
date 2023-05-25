import 'package:flutter/material.dart';
import '../components/app_bar.dart';
import '../components/notif.dart';
import '../components/style.dart';
import 'package:hive/hive.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final accounts = Hive.box('accounts');
  List<Map<String, dynamic>> accountData = [];
  String? userKey, name;

  final loginFormKey = GlobalKey<FormState>();
  AutovalidateMode validateMode = AutovalidateMode.disabled;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool passVisibility = true, showPassButton = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() {
    final data = accounts.keys.map((key) {
      final item = accounts.get(key);
      return {
        'userKey': key,
        'name': item['name'],
        'email': item['email'],
        'password': item['password'],
      };
    }).toList();
    setState(() {
      accountData = data.reversed.toList();
    });
  }

  bool login() {
    if (accountData.isNotEmpty) {
      for (var i = 0; i < accountData.length; i++) {
        if (accountData[i]['email'] == emailController.text &&
            accountData[i]['password'] == passwordController.text) {
          userKey = accountData[i]['userKey'].toString();
          name = accountData[i]['name'].toString();
          return true;
        }
      }
    }
    return false;
  }

  void clearForm() {
    setState(() {
      loginFormKey.currentState!.reset();
      emailController.clear();
      passwordController.clear();
      validateMode = AutovalidateMode.disabled;
    });
  }

  @override
  Widget build(BuildContext context) {
    IconData visibilityIcon = passVisibility ? Icons.visibility_off : Icons.visibility;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 54, 23, 94),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              CustomAppBar(
                title: 'Login',
                icon: Icons.login,
              ),
              Column(
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  const Text(
                    'Welcome Back!',
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
                    'Please login to your account',
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
                    key: loginFormKey,
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
                          FocusScope(
                            child: Focus(
                              onFocusChange: (hasFocus) {
                                setState(() {
                                  showPassButton = hasFocus;
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
                                  labelText: 'Password',
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
                              onPressed: () async {
                                if (loginFormKey.currentState!.validate()) {
                                  if (login()) {
                                    clearForm();
                                    Navigator.pushNamed(
                                      context,
                                      '/home',
                                      arguments: {
                                        'name': name,
                                        'userKey': userKey,
                                      },
                                    );
                                  } else {
                                    Notif.showMessage('Wrong login credentials',
                                        Colors.red, context);
                                  }
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
                                'Login',
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
                                'Don\'t have an account?',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextButton(
                                onPressed: () async {
                                  clearForm();
                                  await Navigator.pushNamed(
                                      context, '/register');
                                  getData();
                                },
                                child: const Text(
                                  'Register',
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
