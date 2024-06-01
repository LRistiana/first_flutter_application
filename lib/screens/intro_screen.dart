import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

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
                // image
                SvgPicture.asset(
                  'lib/images/intro_image.svg',
                  semanticsLabel: 'Hero Image',
                  height: 327,
                  width: 327,
                ),
                // teks
                Container(
                  padding:
                      const EdgeInsets.only(left: 72, right: 72, top: 24, bottom : 75),
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32)),
                  ),
                  child:  Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 24),
                        child: Text(
                          'Discover Our Products',
                          style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat'),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4),
                        child: Text(
                          'Browse thousands of products, from fashion to tech. Find what you love, effortlessly.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                              fontFamily: 'Montserrat'),
                        ),
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                      // button
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, '/signUp');
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => const SignUp(),
                          //     ));
                        },
                        child: Container(
                            decoration: const BoxDecoration(
                              color: Color.fromRGBO(215, 252, 112, 1),
                              borderRadius: BorderRadius.all(Radius.circular(16)),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 80),
                            child: const Text(
                              'Get Started',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromRGBO(27, 32, 51, 1),
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat'),
                            )),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
