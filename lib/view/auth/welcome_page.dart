import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_management/controller/auth_provider.dart';

import 'package:student_management/service/firebase_auth.dart';
import 'package:student_management/util/snacbar.dart';
import 'package:student_management/view/auth/widgets/welcome_text.dart';
import 'package:student_management/view/otp/otp.dart';



class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool obscurePassword = true;
  bool isSignUp = true;

  final FirebaseAuthService _auth = FirebaseAuthService();
  FirebaseAuth auth = FirebaseAuth.instance;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 237, 242, 246),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 100, left: 22, right: 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const WelcomeText(),
              const SizedBox(height: 65),
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 0.12,
                      blurRadius: 1,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      hintStyle: TextStyle(color: Colors.grey.shade500),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter the email';
                      } else {
                        return null;
                      }
                    }),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 0.12,
                      blurRadius: 1,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    TextFormField(
                      controller: passwordController,
                      obscureText: obscurePassword,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        hintStyle: TextStyle(color: Colors.grey.shade500),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter the password';
                        } else {
                          return null;
                        }
                      },
                    ),
                    Align(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8, left: 290),
                        child: IconButton(
                          icon: Icon(
                          obscurePassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(
                              () {
                                obscurePassword = !obscurePassword;
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
          isSignUp
                  ? ElevatedButton(
                      onPressed: () {
                        signUp();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 100, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  : Column(
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, "/ForgotPassword");
                            },
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 11, 161, 154),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const SizedBox(height: 25),
                        ElevatedButton(
                          onPressed: () {
                            signIn();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 11, 161, 154),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 100, vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Sign In',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    isSignUp
                        ? 'Already have an account?'
                        : 'Don\'t have an account?',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        isSignUp = !isSignUp; 
                      });
                    
                    },
                    child: Text(
                      isSignUp ? 'Sign In' : 'Sign Up',
                      style: const TextStyle(
                          color: Color.fromARGB(255, 11, 161, 154),
                          fontSize: 16),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              const Divider(thickness: 2),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      FirebaseAuthService().signInWithGoogle(context);
                    },
                    child: SizedBox(
                      width: 35,
                      child: Image.asset(
                        'assets/image/2993685_brand_brands_google_logo_logos_icon.png',
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 55,
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const OtpScreen(),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.phone_android_rounded,
                      size: 35,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void signUp() async {
    String email = emailController.text;
    String password = passwordController.text;

    User? user =
        await _auth.singUpWithEmailAndpassword(email, password, context);

    if (user != null) {
      showSnackbar(context, 'User is Successfully created');

      Navigator.pushNamed(context, "/Homepage");
    }
  }

  void signIn() async {
    String email = emailController.text;
    String password = passwordController.text;

    User? user =
        await _auth.singInWithEmailAndpassword(email, password, context);

    if (user != null) {
      showSnackbar(context, 'User is Successfully SignIn');

      Navigator.pushNamed(context, "/Homepage");
    }
  }
}
