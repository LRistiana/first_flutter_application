import 'package:first_flutter_application/pages/sign_in_page.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _passwordVisible = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  String warningText = '';

  void onSignInTap() {}
  void swapPasswordVisibility() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(17, 17, 17, 1),
        body: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 84,
              ),
              SvgPicture.asset(
                'lib/images/started.svg',
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
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          hintStyle: TextStyle(color: Colors.grey),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(215, 252, 112, 1),
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(16)),
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
                        decoration:  InputDecoration(
                          labelText: 'Password',
                          hintStyle: const TextStyle(color: Colors.grey),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(215, 252, 112, 1),
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(16)),
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
                        decoration:  InputDecoration(
                          labelText: 'Confirm Password',
                          hintStyle: const TextStyle(color: Colors.grey),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(215, 252, 112, 1),
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(16)),
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
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUp(),
                        ));
                  },
                  child: Container(
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(215, 252, 112, 1),
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
        ));
  }
}
