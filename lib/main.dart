import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_management/controller/auth_provider.dart';
import 'package:student_management/view/auth/welcome_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:student_management/view/forgot_pass.dart';
import 'package:student_management/view/home/home.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create:(context)=>AuthProvi())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        
      
        routes: {
          '/': (context) => const WelcomePage(),
          '/Homepage': (context) => const HomePage(),
          '/WelcomePage': (context) => const WelcomePage(),
          '/ForgotPassword':(context)=> const ForgotPassword(),
        },
      ),
    );
  }
}
