import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final forgotemail = TextEditingController();

  @override
  void dispose() {
    forgotemail.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: forgotemail.text.trim(),
      );
        showDialog(
          
        context: context,
        builder: (context) => const AlertDialog(
          content: Text(
        'Password reset link sent! Check your Email'
          ),
        ),
      );
    } on FirebaseAuthException catch (e) {
      (e);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text(
            e.message.toString(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 237, 242, 246),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(
              child: Text(
                'Enter your Email and we will send you a Password reset link',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 25),
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
                controller: forgotemail,
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
                },
              ),
            ),
            const SizedBox(height: 25),
            MaterialButton(
              onPressed: () {},
              child: const Text(
                'Reset Password',
                style: TextStyle(color: Colors.white),
              ),
              color: Color.fromARGB(255, 11, 161, 154),
            )
          ],
        ),
      ),
    );
  }
}
