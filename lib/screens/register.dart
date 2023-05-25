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

  Widget build(BuildContext context) {
    IconData visibilityIcon =
        (passVisibility) ? Icons.visibility_off : Icons.visibility;
    IconData confirmVisibilityIcon =
        (confirmPassVisibility) ? Icons.visibility_off : Icons.visibility;

    return Scaffold(
      backgroundColor: Color.fromARGB(
        255,
        54,
        23,
        94,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              CustomAppBar(
                title: 'Register',
                icon: Icons.person_add_alt_1,
              ),
              Column(
                children: [
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    'Create new account',
                    style: TextStyle(
                      fontSize: 28,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Please fill in the form to continue',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Form(
                    key: registrationFormKey,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      padding: EdgeInsets.fromLTRB(
                        20,
                        25,
                        20,
                        40,
                      ),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: nameController,
                            decoration: InputDecoration(
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
                              } else if (!validateEmail()) {
                                return 'Email already exists';
                              } else {
                                return null;
                              }
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
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
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: addressController,
                            decoration: InputDecoration(
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
                          SizedBox(
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
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        passVisibility = !passVisibility;
                                      });
                                    },
                                    child: Visibility(
                                      visible: showPassButton,
                                      child: Padding(
                                        padding: EdgeInsets.only(right: 10),
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
                          SizedBox(
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
                          SizedBox(
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
                                } 
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Style.violet,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: Text(
                                'Register',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Wrap(
                            alignment: WrapAlignment.center,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Text(
                                'Already have an account?',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Text(
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
