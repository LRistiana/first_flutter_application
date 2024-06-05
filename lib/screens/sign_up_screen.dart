import 'package:dio/dio.dart';
import 'package:first_flutter_application/screens/sign_in_screen.dart';
import 'package:first_flutter_application/utils/theme/color_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:email_validator/email_validator.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:async';

import 'package:logger/logger.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _passwordVisible = false;
  bool _invalidInput = false;
  bool _invalidEmail = false;
  bool _invalidUsername = false;
  bool _invalidPassword = false;
  String _warningText = '';

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  String warningText = '';

  final myStorage = GetStorage();
  void onCreateAccountTap() {
    if (!emailValidator()) {
    } else if (!passwordValidator()) {
    } else {
      goRegister();
      // Navigator.pushReplacementNamed(context, '/homePage');
    }
  }

  void goRegister() async {
    final dio = Dio();
    var logger = Logger();
    try {
      final response = await dio.post(
        'https://mobileapis.manpits.xyz/api/register',
        data: {
          'email': _emailController.text,
          'name': _usernameController.text,
          'password': _passwordController.text,
        },
      );
      // Navigator.pushReplacementNamed(context, '/signIn');
      logger.i(response);
      if (response.statusCode == 200) {
        // Navigator.pushReplacementNamed(context, '/signIn');
        try {
          final response = await dio.post(
            'https://mobileapis.manpits.xyz/api/login',
            data: {
              'email': _emailController.text,
              'password': _passwordController.text,
            },
          );
          logger.i(response);
          if (response.statusCode == 200) {
            myStorage.write('token', response.data['data']['token']);
            Navigator.pushReplacementNamed(context, '/homePage');
          }
        } on DioException catch (e) {
          setState(() {
            _invalidInput = true;

            Timer(const Duration(seconds: 3), () {
              setState(() {
                _invalidInput = false;
              });
            });
            _warningText =
                e.response?.data['message'] ?? 'Something went wrong';
          });
          logger.e(e);
          // print('Error : ${e.response?.statusCode} - ${e.response?.data}');
        }
      }
    } on DioException catch (e) {
      setState(() {
        _invalidInput = true;

        Timer(const Duration(seconds: 3), () {
          setState(() {
            _invalidInput = false;
          });
        });
        _warningText = e.response?.data['message'] ?? 'Something went wrong';
      });
      logger.e(e);
      // print('Error : ${e.response?.statusCode} - ${e.response?.data}');
    }
  }

  bool emailValidator() {
    if (!EmailValidator.validate(_emailController.text)) {
      setState(() {
        _invalidInput = true;
        _invalidEmail = true;
        Timer(const Duration(seconds: 3), () {
          setState(() {
            _invalidInput = false;
            _invalidEmail = false;
          });
        });
        _warningText = "Please enter a valid email";
      });
      return false;
    }
    return true;
  }

  bool passwordValidator() {
    if (_passwordController.text.isEmpty) {
      setState(() {
        _invalidInput = true;
        _invalidPassword = true;
        Timer(const Duration(seconds: 3), () {
          setState(() {
            _invalidInput = false;
            _invalidPassword = false;
          });
        });
        _warningText = "Password can't be empty!";
      });
    } else if (_passwordController.text.length < 6) {
      setState(() {
        _invalidInput = true;
        _invalidPassword = true;
        Timer(const Duration(seconds: 3), () {
          setState(() {
            _invalidInput = false;
            _invalidPassword = false;
          });
        });
        _warningText = "Password must be at least 8 characters!";
      });
    } else if (_passwordController.text.contains(RegExp(r'[0-9]')) == false) {
      setState(() {
        _invalidInput = true;
        _invalidPassword = true;
        Timer(const Duration(seconds: 3), () {
          setState(() {
            _invalidInput = false;
            _invalidPassword = false;
          });
        });
        _warningText = "Password must contain at least one number!";
      });
    } else if (_passwordController.text.contains(RegExp(r'[A-Z]')) == false) {
      setState(() {
        _invalidInput = true;
        _invalidPassword = true;
        Timer(const Duration(seconds: 3), () {
          setState(() {
            _invalidInput = false;
            _invalidPassword = false;
          });
        });
        _warningText = "Password must contain at least one uppercase letter!";
      });
    } else if (_passwordController.text.contains(RegExp(r'[a-z]')) == false) {
      setState(() {
        _invalidInput = true;
        _invalidPassword = true;
        Timer(const Duration(seconds: 3), () {
          setState(() {
            _invalidInput = false;
            _invalidPassword = false;
          });
        });
        _warningText = "Password must contain at least one lowercase letter!";
      });
    } else if (_passwordController.text
            .contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]')) ==
        false) {
      setState(() {
        _invalidInput = true;
        _invalidPassword = true;
        Timer(const Duration(seconds: 3), () {
          setState(() {
            _invalidInput = false;
            _invalidPassword = false;
          });
        });
        _warningText = "Password must contain at least one special character!";
      });
    } else if (_passwordController.text != _confirmPasswordController.text) {
      setState(() {
        _invalidInput = true;
        _invalidPassword = true;
        Timer(const Duration(seconds: 3), () {
          setState(() {
            _invalidInput = false;
            _invalidPassword = false;
          });
        });
        _warningText = "Password doesn't match!";
      });
    } else {
      return true;
    }
    return false;
  }

  void swapPasswordVisibility() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(17, 17, 17, 1),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 84,
                ),
                SvgPicture.asset(
                  'lib/images/newstart.svg',
                  semanticsLabel: 'Hero Image',
                  height: 200,
                  width: 200,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 24),
                  child: Text(
                    'Get Started',
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 24),
                        child: TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            hintStyle: const TextStyle(color: Colors.grey),
                            enabledBorder: _invalidEmail
                                ? const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16)),
                                  )
                                : const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16)),
                                  ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(215, 252, 112, 1),
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                            ),
                          ),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 24),
                        child: TextField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                            labelText: 'Username',
                            hintStyle: const TextStyle(color: Colors.grey),
                            enabledBorder: _invalidUsername
                                ? const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16)),
                                  )
                                : const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16)),
                                  ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(215, 252, 112, 1),
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                            ),
                          ),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 24),
                        child: TextField(
                          controller: _passwordController,
                          obscureText: !_passwordVisible,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            hintStyle: const TextStyle(color: Colors.grey),
                            enabledBorder: _invalidPassword
                                ? const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16)),
                                  )
                                : const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16)),
                                  ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(215, 252, 112, 1),
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.white,
                              ),
                              onPressed: swapPasswordVisibility,
                            ),
                          ),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 24),
                        child: TextField(
                          controller: _confirmPasswordController,
                          obscureText: !_passwordVisible,
                          decoration: InputDecoration(
                            labelText: 'Confirm Password',
                            hintStyle: const TextStyle(color: Colors.grey),
                            enabledBorder: _invalidPassword
                                ? const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16)),
                                  )
                                : const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16)),
                                  ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(215, 252, 112, 1),
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.white,
                              ),
                              onPressed: swapPasswordVisibility,
                            ),
                          ),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: _invalidInput,
                  child: Container(
                    padding: const EdgeInsets.only(top: 10),
                    child: Center(
                      child: Text(
                        _warningText,
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: GestureDetector(
                    onTap: () {
                      onCreateAccountTap();
                    },
                    child: Container(
                        decoration: const BoxDecoration(
                          gradient: GradientColor.primaryGradientRevert,
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 114),
                        child: const Text(
                          'Create Account',
                          style: TextStyle(
                              fontSize: 16,
                              color: Color.fromRGBO(27, 32, 51, 1),
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat'),
                        )),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account?',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignIn(),
                            ));
                      },
                      child: const Text(
                        'Sign In',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
